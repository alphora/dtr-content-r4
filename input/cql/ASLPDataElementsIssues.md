# Issues

- The ValueSets and codes in the ASLPConcepts need to be replaced with real ValueSets

  - The associated data needs to be updated too
    - BMI-positive should be:
      `"coding" : [
      {
        "system" : "http://loinc.org",
        "code" : "39156-5",
        "display" : "Body mass index (BMI) [Ratio]"
      }
    ]`
    - Height-positive should be:
      `"coding": [
        {
          "system": "http://loinc.org",
          "code": "8302-2",
          "display": "Body height"
        }
      ]`

- The types of Observations for QI Core should be the specific US Core profiles
  - BMI-positive should be: [http://hl7.org/fhir/us/core/StructureDefinition/us-core-bmi], but that causes a null
  - Height-positive should be: [http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-height]

- `define "Diagnosis of Obstructive Sleep Apnea"` returns a null

- Get the following error when `using QICore version '4.1.1'`: Error: Could not load model information for model QICore, version 4.1.1 because version 4.1.0 is already loaded.
