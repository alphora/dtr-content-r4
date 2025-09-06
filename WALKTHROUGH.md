# Adult Sleep Studies Prior Authorization DTR Walkthrough

This walkthrough guides you through setting up, building, and modifying the Adult Sleep Studies artifact library to illustrate how to author, distribute, and consume FHIR and CQL based knowledge artifacts for Prior Authorization - DTR.

## Overview

The walkthrough is organized into the following sections:

- [Adult Sleep Studies Prior Authorization DTR Walkthrough](#adult-sleep-studies-prior-authorization-dtr-walkthrough)
  - [Overview](#overview)
  - [Background](#background)
  - [Setup](#setup)
  - [Project Layout](#project-layout)
  - [CRD → DTR → PAS](#crd--dtr--pas)
    - [CRD](#crd)
    - [DTR](#dtr)
    - [PAS](#pas)
  - [Modifying](#modifying)
    - [Resetting Local Files](#resetting-local-files)

<!--   - [USPSTF Recommendation on Colorectal Cancer Screening](#uspstf-recommendation-on-colorectal-cancer-screening)
  - [Approach](#approach)
  - [Artifact Source](#artifact-source)
  - [Unit Testing](#unit-testing)
  - [Building the Artifact Library](#building-the-artifact-library)
  - [Running the Decision Support](#running-the-decision-support)
    - [Configuring the CDS Hooks Sandbox](#configuring-the-cds-hooks-sandbox)
  - [Running the Quality Measure](#running-the-quality-measure)
  - [Updating the Content](#updating-the-content) -->

## Background

This walkthrough is an illustration of FHIR- and CQL-based knowledge artifacts that provide prior authorization dtr implementations of the Humana Adult Sleep Studies Questionnaire for Prior Authorization.

Specifically, because the knowledge artifacts in this Artifact Library are FHIR canonical resources, the content here is built as a FHIR Implementation Guide, allowing knowledge authors to leverage the FHIR publishing toolchain to provide distribution and documentation of the artifacts.

## Setup 

- FHIR R4 server (e.g., HAPI/Smile CDR) with CRUD and $apply, $populate (SDC), $extract; $next-question if you want adaptive.
- CQL toolchain: CQL → ELM translator and a CQL evaluator.

## Project Layout

/input
  /cql
    ASLPCrdMultipleRequestLogic.cql
  /resources
    /library
      ASLPCrdMultipleRequestLogic.json
    /plandefinition
      PlanDefinition-ASLPCrd-MultipleRequest.json
    /questionnaire
      questionnaire-ASLPA1.json
    /structuredefinition
      aslp-paa-patientage-casefeature-definition.json
    /tests
      /library
        /ASLPCrdMultipleRequestLogic
          /patient-1
            patient-1.json
    /vocabulary 
      /codesystem
      /valueset

## CRD → DTR → PAS

### CRD

CRD (CDS Hooks order-sign) returns card pointing to DTR.

### DTR

DTR runs the artifacts.

  1. Fetch artifacts by canonical (Questionnaire, PlanDefinition, Library/ELM).
  2. Prefill via $populate (optional).
  3. Adaptive (optional): call $next-question iteratively.
  4. Evaluate CQL (ELM) to compute.
  5. Option A: Present Questionnaire to gather missing items. On submit, capture QuestionnaireResponse.
     Option B: Call PlanDefinition/$apply to instantiate the resource and produce a Bundle of resources.
  6. Extract (optional): $extract turns QuestionnaireResponse into FHIR resources for submission.

### PAS

Assemble PA request with a FHIR resource and send through your PAS intermediary to payer.

## Modifying

Change policy criteria:
- Update CQL, re-translate to ELM

Change workflow:
- Add/remove action in PlanDefinition, or point to different ActivityDefinition.

Revert changes:
  - run [Resetting Local Files](#resetting-local-files)
  - run the following:

    Windows:

    ```
    del "input\examples\observation-aslp-snores-in-sleep-example.json"
    del "input\profiles\structuredefinition-aslp-snores-in-sleep.json"
    del "input\vocabulary\valueset\valueset-aslp-ae-de2.json"
    ```

    Non-Windows:

    ``` 
    rm input/examples/observation-aslp-snores-in-sleep-example.json
    rm input/profiles/structuredefinition-aslp-snores-in-sleep.json
    rm input/vocabulary/valueset/valueset-aslp-ae-de2.json
    ```

### Resetting Local Files

Use the following steps to revert unwanted changes to local files.

```
git restore .
```

Windows:

```
del "input\cql\ASLPContactDataElements.cql"
```

Non-Windows:

``` 
rm input/cql/ASLPContactDataElements.cql
```

<!-- 
## USPSTF Recommendation on Colorectal Cancer Screening

The artifacts in this walkthrough provide a platform-independent, standards-based representation of a decision support rule and quality measure for implementing the US Preventive Services Task Force recommendation on Colorectal Cancer Screening:

* The U.S. Preventive Services Task Force (2016) recommends screening for colorectal cancer starting at age 50 years and continuing until age 75 years. This is a Grade A recommendation ([U.S. Preventive Services Task Force, 2016](https://www.uspreventiveservicestaskforce.org/uspstf/recommendation/colorectal-cancer-screening-june-2016)).

> NOTE: This recommendation was updated in May of 2021; the updates have not been applied to this artifact. It is an exercise for the reader to update the content per the 2021 recommendation.

 -->