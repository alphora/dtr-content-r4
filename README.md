# dtr-content-r4

## Introduction

This Content IG contains Knowledge Artifacts for the Prior Authorization - DTR Use Case.

## Background

Prior Authorization is currently a manual process wherein the requestor (typically the clinician) uses a Payer website to search, fill-out, and submit a Payer questionnaire that includes information the Payer needs in order to make an authorization decision.  The Smile PA solution uses the CRD module to discover whether PA is required for a certain service and retrieves a like to a computable representation of the questionnaire (as a FHIR Questionnaire resource) and CQL (as a FHIR Library resource) capable of filling out the questionnaire if so.  The DTR module then evaluates the CQL and uses the result to pre-populates the questionnaire.  Together the FHIR Questionnaire and Library (containing the CQL) for a certain service is called a Payer Rule.  The Payer questionnaire for a certain service acts as the requirements for authoring a Payer Rule.  An [example of a Payer questionnaire](docs/Sleep.Studies.Adults.Questionnaire.pdf) has been included in this IG for reference.  The associated [FHIR Questionnaire](input/resources/questionnaire/questionnaire-ASLPA1.json) and [CQL](input/cql/ASLPDataElements.cql) have also been includes a Payer Rule implementation example.

## Walkthrough

For a complete walkthrough of building, and modifying this artifact library, refer to the [Walkthrough](WALKTHROUGH.md) page.

> TIP: To open the Walkthrough in Preview mode for easier viewing and navigation, right-click on the WALKTHROUGH.md file in the explorer pane to the left and select `Open Preview`.

## Repository Structure

It is setup like any HL7 FHIR IG project but also includes the CQL files and test data which means the file structure will be as follows:

```
   |-- _genonce.bat
   |-- _genonce.sh
   |-- _refresh.bat
   |-- _refresh.sh
   |-- _updatePublisher.bat
   |-- _updatePublisher.sh
   |-- _updateCQFTooling.bat
   |-- _updateCQFTooling.sh
   |-- ig.ini
   |-- bundles
       |-- plandefinition
           |-- ALSP
       |-- questionnaire
           |-- *.json
   |-- input
       |-- cql
           |-- *.cql
       |-- l2
           |-- *.xlsx
       |-- resources
           |-- library
               |-- *.json
           |-- questionnaire
               |-- *.json
       |-- tests
           |-- library
               |-- *.json
       |-- vocabulary
           |-- valueset
               |-- *.json
```

### bundles

The `bundles` folder contains folders that contain the knowledge artifacts within this IG and json files that are FHIR Bundle resources that contain those knowledge artifacts.  These artifacts are ready to be published to an artifact repository.

### cql

The `cql` folder contains CQL files that implement the logic that is used to pre-populate answers in the FHIR Questionnaire resources at runtime.  The `ASLPDataElements.cql` file is an example of the logic that pre-populates a FHIR Questionnaire that's based on the Adult Sleep Study Payer questionnaire.

### l2

The `l2` folder contains Excel files that have a certain format and act as Data Dictionaries for the Accelerator Kit command line tool. The `DTR.xlsx` file is an example of the Data Dictionary that represents the Clinical Concepts for the Adult Sleep Study Payer questionnaire.

### resources/library

The `resources/library` folder contains json FHIR Library resource files that contain the `CQL` as base64 encoded data.

### resources/questionnaire

The `resources/questionnaire` folder contains json FHIR Questionnaire resource files that implement the Payer questionnaire.  The `questionnaire-ASLPA1.json` file is an example of the implementation of the Adult Sleep Study Payer questionnaire.

### tests

The `tests` folder contains json FHIR patient data resource files that can be used to generate results via execution of the `CQL`.  the `ASLPDataElements` folder is an example of the FHIR patient data resource files that produce expected results when the `CQL` in the `ASLPDataElements.cql` file is executed.

### vocabulary/valueset

The `vocabulary/valueset` folder contains json FHIR ValueSet resource files that include the terminology for the Payer Questionnaire.

## Refresh IG Processing

The CQF Tooling provides support for refreshing measure and library resources based on
the content of the CQL libraries, as well as packaging the measures as artifacts that
include dependencies and test cases.

To run this tooling, make sure it is available locally using the _updateCQFTooling script,
then run the _refresh script. This script should be run whenever CQL content changes,
and prior to the publishing process.
