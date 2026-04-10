const { Repository, CodeService, Executor } = require('cql-execution');
const { PatientSource, FHIRWrapper } = require('cql-exec-fhir');
const fs = require('fs');
const path = require('path');

// --- Paths ---

const igRoot = path.join(__dirname, '..', '..');
const libraryDir = path.join(igRoot, 'input', 'resources', 'library');
const vsDir = path.join(igRoot, 'input', 'vocabulary', 'valueset');

// --- Load ELM ---

function loadElmFromLibrary(filePath, elmMap) {
  try {
    const lib = JSON.parse(fs.readFileSync(filePath, 'utf8'));
    if (lib.resourceType !== 'Library') return;
    for (const content of (lib.content || [])) {
      if (content.contentType === 'application/elm+json' && content.data) {
        const elm = JSON.parse(Buffer.from(content.data, 'base64').toString('utf8'));
        elmMap[elm.library.identifier.id] = elm;
        break;
      }
    }
  } catch (e) {
    // skip unparseable files
  }
}

const elmMap = {};
for (const file of fs.readdirSync(libraryDir).filter(f => f.endsWith('.json'))) {
  loadElmFromLibrary(path.join(libraryDir, file), elmMap);
}

// External HL7 CQL libraries from FHIR package cache (~/.fhir/packages/)
const fhirPackagesDir = path.join(require('os').homedir(), '.fhir', 'packages');
const externalLibraries = [
  { pkg: 'hl7.fhir.uv.cql#2.0.0', file: 'Library-FHIRHelpers.json' },
  { pkg: 'hl7.fhir.uv.cql#2.0.0', file: 'Library-FHIRCommon.json' },
  { pkg: 'hl7.fhir.us.cql#1.0.0', file: 'Library-USCoreElements.json' },
];
for (const { pkg, file } of externalLibraries) {
  const filePath = path.join(fhirPackagesDir, pkg, 'package', file);
  if (fs.existsSync(filePath)) loadElmFromLibrary(filePath, elmMap);
}

const repo = new Repository(elmMap);

// --- Load Value Sets ---

const valueSetsJson = {};
for (const file of fs.readdirSync(vsDir).filter(f => f.endsWith('.json'))) {
  try {
    const vs = JSON.parse(fs.readFileSync(path.join(vsDir, file), 'utf8'));
    if (vs.resourceType !== 'ValueSet' || !vs.url) continue;
    const codes = [];
    if (vs.compose && vs.compose.include) {
      for (const inc of vs.compose.include) {
        for (const concept of (inc.concept || [])) {
          codes.push({ code: concept.code, system: inc.system || '', version: inc.version || '' });
        }
      }
    }
    if (vs.expansion && vs.expansion.contains) {
      for (const c of vs.expansion.contains) {
        codes.push({ code: c.code, system: c.system || '', version: c.version || '' });
      }
    }
    if (codes.length > 0) {
      if (!valueSetsJson[vs.url]) valueSetsJson[vs.url] = {};
      valueSetsJson[vs.url][vs.version || ''] = codes;
    }
  } catch (e) {
    // skip unparseable files
  }
}
const codeService = new CodeService(valueSetsJson);

// --- Helpers ---

function loadResources(dir) {
  return fs.readdirSync(dir)
    .filter(f => f.endsWith('.json'))
    .map(f => JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8')));
}

function collectListParams(libraryName) {
  const listParams = {};

  function processElm(elm) {
    for (const p of ((elm.library.parameters || {}).def || [])) {
      const spec = p.resultTypeSpecifier || p.parameterTypeSpecifier;
      if (!spec || spec.type !== 'ListTypeSpecifier') continue;
      const types = [];
      const et = spec.elementType;
      if (et.type === 'ChoiceTypeSpecifier' && et.choice) {
        for (const c of et.choice) types.push(c.name.replace('{http://hl7.org/fhir}', ''));
      } else if (et.name) {
        types.push(et.name.replace('{http://hl7.org/fhir}', ''));
      }
      if (types.length > 0 && !listParams[p.name]) listParams[p.name] = types;
    }
    for (const inc of ((elm.library.includes || {}).def || [])) {
      const depName = inc.path.includes('/') ? inc.path.split('/').pop() : inc.path;
      if (elmMap[depName]) processElm(elmMap[depName]);
    }
  }

  if (elmMap[libraryName]) processElm(elmMap[libraryName]);
  return listParams;
}

// --- Build a FHIR Bundle with correctly-typed entry resources ---
// FHIRWrapper.wrap() on a whole Bundle types entry.resource as abstract Resource
// (configurable: false), so CQL `is Patient` checks fail. We wrap each resource
// individually for concrete typing, then assemble a plain object with correct _typeInfo.

let _bundleTypeInfo = null;
let _entryTypeInfo = null;

function getTypeInfoTemplates() {
  if (!_bundleTypeInfo) {
    const w = FHIRWrapper.FHIRv401();
    const t = w.wrap({ resourceType: 'Bundle', type: 'collection', entry: [{ resource: { resourceType: 'Basic', id: 'x' } }] });
    _bundleTypeInfo = t._typeInfo;
    _entryTypeInfo = t.entry[0]._typeInfo;
  }
  return { bundleTypeInfo: _bundleTypeInfo, entryTypeInfo: _entryTypeInfo };
}

function buildTypedBundle(resources, wrapper) {
  const { bundleTypeInfo, entryTypeInfo } = getTypeInfoTemplates();
  const entries = resources.map(r => {
    const wrapped = wrapper.wrap(r);
    const entry = {};
    Object.defineProperty(entry, '_typeInfo', { value: entryTypeInfo, writable: false, configurable: false, enumerable: false });
    Object.defineProperty(entry, 'resource', { value: wrapped, writable: false, configurable: false, enumerable: true });
    return entry;
  });
  const bundle = {};
  Object.defineProperty(bundle, '_typeInfo', { value: bundleTypeInfo, writable: false, configurable: false, enumerable: false });
  Object.defineProperty(bundle, 'entry', { value: entries, writable: false, configurable: false, enumerable: true });
  return bundle;
}

// --- CRD Test Execution ---
// Mimics the production $apply flow:
//   - Payor resources → PatientSource (patient context)
//   - Provider resources → "Provider Context" Bundle parameter (with concrete typing)
//   - ServiceRequests/DeviceRequests from provider dir → draftOrders parameter

async function executeCrdTestCase(libraryName, providerDir, payorDir) {
  const listParams = collectListParams(libraryName);
  const providerResources = loadResources(providerDir);
  const payorResources = loadResources(payorDir);
  const wrapper = FHIRWrapper.FHIRv401();

  const draftOrders = providerResources
    .filter(r => r.resourceType === 'ServiceRequest' || r.resourceType === 'DeviceRequest')
    .map(r => wrapper.wrap(r));

  const ps = PatientSource.FHIRv401();
  ps.loadBundles([{ resourceType: 'Bundle', type: 'collection', entry: payorResources.map(r => ({ resource: r })) }]);

  const params = { 'Provider Context': buildTypedBundle(providerResources, wrapper), 'draftOrders': draftOrders };
  for (const paramName of Object.keys(listParams)) {
    if (!params[paramName]) params[paramName] = [];
  }

  const lib = repo.resolve(libraryName);
  const result = await new Executor(lib, codeService, params).exec(ps);
  const patientKeys = Object.keys(result.patientResults);
  return patientKeys.length > 0 ? result.patientResults[patientKeys[0]] : null;
}

// --- CRD Result Extraction ---

function extractCrdExtensionValue(ext, url) {
  for (const sub of (ext.extension || [])) {
    const urlVal = sub.url && sub.url.value !== undefined ? sub.url.value : sub.url;
    if (urlVal === url) {
      const val = sub.value;
      if (val === null || val === undefined) return null;
      if (val.value !== undefined) return val.value;
      if (val.reference && val.reference.value !== undefined) return val.reference.value;
      return val;
    }
  }
  return undefined;
}

function extractCrdDetailValue(ext, url) {
  for (const sub of (ext.extension || [])) {
    const urlVal = sub.url && sub.url.value !== undefined ? sub.url.value : sub.url;
    if (urlVal === 'detail') return extractCrdExtensionValue(sub, url);
  }
  return undefined;
}

function extractCrdResult(covExtItem) {
  return {
    covered: extractCrdExtensionValue(covExtItem, 'covered'),
    paNeeded: extractCrdExtensionValue(covExtItem, 'pa-needed'),
    detailText: extractCrdDetailValue(covExtItem, 'code')?.text?.value,
    qualification: extractCrdDetailValue(covExtItem, 'qualification'),
  };
}

module.exports = { executeCrdTestCase, extractCrdResult };
