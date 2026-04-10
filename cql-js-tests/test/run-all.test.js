const { expect } = require('chai');
const fs = require('fs');
const path = require('path');
const { executeCrdTestCase, extractCrdResult } = require('./cql-engine');

const testDataDir = path.join(__dirname, '..', '..', 'input', 'tests', 'library');
const spec = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'resources', 'crd-tests.json'), 'utf8'));

describe(spec.library, function () {
  this.timeout(30000);

  for (const tc of spec.testCases) {
    describe(`${tc.patient}: ${tc.description}`, function () {
      let results;

      before(async function () {
        const provDir = path.join(testDataDir, tc.providerDir);
        const payDir = path.join(testDataDir, tc.payorDir);
        results = await executeCrdTestCase(spec.library, provDir, payDir);
        if (!results) throw new Error(`No patient results for ${tc.patient}`);
      });

      for (let i = 0; i < tc.expectedCrd.length; i++) {
        for (const [field, expectedVal] of Object.entries(tc.expectedCrd[i])) {
          it(`CoverageExtensionList[${i}].${field} = ${JSON.stringify(expectedVal)}`, function () {
            const covExtList = results['CoverageExtensionList'];
            expect(covExtList, 'CoverageExtensionList').to.be.an('array').with.length.at.least(i + 1);
            expect(extractCrdResult(covExtList[i])[field], `CoverageExtensionList[${i}].${field}`).to.equal(expectedVal);
          });
        }
      }
    });
  }
});
