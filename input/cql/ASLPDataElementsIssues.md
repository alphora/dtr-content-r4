# Issues

- The ValueSets and codes in the ASLPConcepts need to be replaced with real ValueSets

  - The associated data needs to be updated too
    - BMI
    - Height
    - Glucose
    - Blood Pressure
    - Weight

- The types of Observations for QI Core should be the specific US Core profiles
  - BMI-positive should be: [http://hl7.org/fhir/us/core/StructureDefinition/us-core-bmi], but that causes a null
  - Height-positive should be: [http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-height]

- Get the following error when `using QICore version '4.1.1'`: Error: Could not load model information for model QICore, version 4.1.1 because version 4.1.0 is already loaded.

- Running `_refresh` creates bundles in the test directory that then get picked up by `CQL Evaluation`, which causes a duplicate Patient error.

- The "History of Diabetes" and "History of Hypertension" should be based on other clinical factors (Condition?), not an Observation.

- Manually added ValueSet `active-condition`

- Consider this: [https://trifolia-fhir.lantanagroup.com/igs/lantana_hapi_r4/MCC-IG/index.html]

- `conceptmap-ICD-10.json` and `codesystem-aslp-codes.json` error when posted to CQFRuler
