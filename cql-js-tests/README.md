# CQL CRD Tests

JavaScript test suite that executes CQL logic against FHIR test data and asserts on CRD (Coverage Requirements Discovery) decision outcomes.

## Prerequisites

- **Java 11+** - required by CQF Tooling to compile CQL to ELM
- **Node.js 18+** - runs the test suite
- **CQF Tooling jar** - must be present at `input-cache/tooling-cli-3.10.0.jar`. Run `_updateCQFTooling.sh` from the repo root if missing
- **FHIR package cache** - external HL7 CQL libraries (FHIRHelpers, FHIRCommon, USCoreElements) are loaded from `~/.fhir/packages/`. These are automatically downloaded when CQF Tooling runs RefreshIG

## Setup

```bash
cd cql-js-tests
npm install
```

## Running Tests

### Quick (tests only, uses existing compiled ELM)

```bash
cd cql-js-tests
npm test
```

### Full (recompile CQL + run tests)

From the repo root:

```bash
./test-js-cql.sh
```

This runs RefreshIG (compiles CQL to ELM, embeds in Library resources) then executes the test suite.

## How It Works

1. ELM is loaded directly from `input/resources/library/*.json` (base64-decoded from FHIR Library resources) - no separate ELM copy needed
2. Test data lives in `input/tests/library/ASLPContext/` with provider/payor folder pairs per scenario
3. Each test mimics the production `$apply` flow:
   - Payor resources go into PatientSource (patient context)
   - Provider resources go into a "Provider Context" Bundle parameter
   - ServiceRequests/DeviceRequests are routed to the draftOrders parameter
4. Assertions check the CoverageExtensionList output (covered, pa-needed, detail text, qualification)

## Test Scenarios

Test cases are defined in `resources/crd-tests.json`. Current coverage:

| Scenario | Description | Expected Outcome |
|----------|-------------|------------------|
| CRD-2 (x2) | DOB / last name mismatch | Member Not Found |
| CRD-3-1 (x3) | NPI missing, practitioner missing | Provider Not in Network |
| CRD-3-2 (x2) | Org name mismatch, org not linked | LOB Mismatch / Provider Not in Network |
| CRD-4 | Gold card | Code Not Found |
| CRD-5 | Prior auth required | Prior Authorization Required |
| CRD-6 | Code not on PA list | Code Not Found |
| CRD-7 | Routine code | No Prior Auth Required |
| CRD-8 | Multiple coverage | Member Not Found |

## Adding a Test Case

1. Create provider and payor test data directories under `input/tests/library/ASLPContext/`
2. Add an entry to `resources/crd-tests.json`:

```json
{
  "patient": "<payor-patient-id>",
  "description": "CRD-X: Description",
  "providerDir": "ASLPContext/<provider-dir-name>",
  "payorDir": "ASLPContext/<payor-dir-name>",
  "expectedCrd": [
    {
      "covered": "conditional|covered|not-covered",
      "paNeeded": "auth-needed|no-auth|conditional",
      "detailText": "expected detail text",
      "qualification": "expected qualification message"
    }
  ]
}
```

3. Run `./test-js-cql.sh` to verify

## Project Structure

```
cql-js-tests/
  package.json
  resources/
    crd-tests.json          # Test case definitions and expected results
  test/
    cql-engine.js           # ELM loading, value sets, CRD execution engine
    run-all.test.js          # Mocha test runner
```
