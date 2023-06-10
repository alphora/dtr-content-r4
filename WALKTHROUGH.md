# Adult Sleep Studies Prior Authorization DTR Walkthrough

This walkthrough guides you through setting up, building, and modifying the Adult Sleep Studies artifact library to illustrate how to author, distribute, and consume FHIR and CQL based knowledge artifacts for
Prior Authorization - DTR.

## Overview

The walkthrough is organized into the following sections:

- [Adult Sleep Studies Prior Authorization DTR Walkthrough](#adult-sleep-studies-prior-authorization-dtr-walkthrough)
  - [Overview](#overview)
  - [Background](#background)
  - [Accelerator Kit](#accelerator-kit)
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

The artifacts are built using the [Accelerator Kit](#accelerator-kit). The walkthrough does not assume familiarity with this material, but interested readers can find more detailed information.

Specifically, because the knowledge artifacts in this Artifact Library are FHIR canonical resources, the content here is built as a FHIR Implementation Guide, allowing knowledge authors to leverage the FHIR publishing toolchain to provide distribution and documentation of the artifacts.

## Accelerator Kit
  
The Accelerator Kit is the combination of a JAVA Command Line tool named CQF Tooling and a Data Dictionary that generates the FHIR/CQL resources for the data elements defined in the Data Dictionary.  The CQF Tooling is in the form of a JAVA jar file. The Data Dictionary is in the form of a spreadsheet with a specific format.  More details can be found in the [CQF Tooling](https://github.com/cqframework/cqf-tooling) repository.

### CQF Tooling CLI

CQF Tooling CLI is deployed to Maven as a JAVA jar file using the following convention: `tooling-x.y.z-SNAPSHOT-jar-with-dependencies.jar`.  A script `_updateCQFTooling` has been included in the root of this repository to download the jar file for local use.  There are Windows (.bat) and non-Windows (.sh) versions of the script.  Run the appicable script to copy the CQF Tooling locally.

NOTE: Due to breaking changes in this project's Data Dictionary file a specific version of the CQF Tooling must be used.  Until this issue is resolved download [this](https://drive.google.com/file/d/1RSmztNdifWgqwMyeuFjnJTcOpiN0VjDe/view?usp=sharing) file locally and copy it to the local [input-cache](input-cache) directory (you may need to create the `input-cache` folder).  NOTE TO MAINTAINERS: once the issue is fixed delete the [file](https://drive.google.com/file/d/1RSmztNdifWgqwMyeuFjnJTcOpiN0VjDe/view?usp=sharing). 

The Data Dictionary is a specifically formatted Excel spreadsheet.  The Data Dictionary for this project has been included directly in the repository at [input/l2/DTR.xlsx](input/l2/DTR.xlsx).  To view the contents, open the file using Microsoft Excel or equivalent.

### Running the Accelerator Kit

The `JAVA command can be used in a terminal to run the Accelerator Kit, using the following steps:

- ensure the JAVA CLI is installed (version 8+): https://www.java.com/en/download/help/download_options.html
- ensure the CQF Tooling has been copied locally [CQF Tooling CLI](#cqf-tooling-cli)
- open a terminal (in VS Code: Terminal/New Terminal)
- in the terminal, run:

SEE NOTE BELOW BEFORE RUNNING:
```
JAVA -jar "input-cache/<tooling-x.y.z-SNAPSHOT-jar-with-dependencies.jar>" -ProcessAcceleratorKit -s=ASLP -pts=input/l2/DTR.xlsx -op=./ -dep="ASLP.A1 Adult Sleep Studies"
```

NOTE: Due to breaking changes in this project's Data Dictionary file a specific version of the CQF Tooling has temporarily been included directly in the repository.  Until this issue is resolved run the following instead:

```
JAVA -jar "input-cache/tooling-1.3.2-SNAPSHOT-jar-with-dependencies.jar" -ProcessAcceleratorKit -s=ASLP -pts=input/l2/DTR.xlsx -op=./ -dep="ASLP.A1 Adult Sleep Studies"
```

NOTE: Due to errors in the CQF Tooling running the Accelerator Kit will result in changes to local files.  These changes should not be commited to the repository.  Instead the bugs in the CQF Tooling should be fixed so that running the Accelerator Kit produces the files currently in this IG.  Until this issue is resolved run [Resetting Local Files](#resetting-local-files) to remove the unwanted local file changes.

### Viewing the results

Running the Accelerator Kit results in newly created and/or updated files matching the Data Elements as specified in the DTR Data Dictionary.

New and/or updated files are output to the following directories:

- [input/cql](input/cql)
- [input/examples](input/examples)
- [input/resources/questionnaire](input/resources/questionnaire)
- [input/resources/vocabulary/valueset](input/resources/vocabulary/valueset)

### Modifying

Modifications to the Adult Sleep Studies artifact library can be made by updating the DTR Data Dictionary and then running the [Running the Accelerator Kit](#running-the-accelerator-kit).

Perform the following steps to walkthrough an example addition:

- open the Sleep.Studies.Adults.Questionniare.pdf Questionnaire specification located in the `docs` folder
- open the DTR Data Dictionary located in the `input/l2` folder using Excel (or equivalent)
- note that the DTR Data Dictionary does not include entries for the last box on the Questionnaire "Check appropriate boxes"
- add a new row to the DTR Data Dictionary for the "Patient snores in his/her sleep" question:
   - Activity ID: ASLP.A1 Adult Sleep Studies
   - Data element ID: ASLP.AE.DE1
   - Data element label: Snores in Sleep
   - Description and definition: Patient snores in his/her sleep
   - Multiple choice: Select one
   - Data type: Coding
   - Quantity sub-type: N/A
   - Validation Condition: None
   - Editable: Yes
   - Required R
   - HL7 FHIR R4 – Resource: Observation.value[x]
   - HL7 FHIR R4 - Resource Type: CodeableConcept
   - HL7 FHIR R4 - Base Profile: http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-observation
   - HL7 FHIR R4 - Version Number: 4.0.1
   - Custom Profile ID: ASLP Snores in Sleep
   - Scope: ASLP
   - Selector: MostRecent
   - FHIR Code System: http://example.org/sdh/dtr/aslp/CodeSystem/aslp-codes
 - add six new rows to the DTR Data Dictionary for the six answer options for the "Patient snores in his/her sleep" question:
    - Option One
      - Activity ID: ASLP.A1 Adult Sleep Studies
      - Data element ID: ASLP.AE.DE2
      - Data element label: Not Known or N/A
      - Description and definition: Agreement Degree
      - Multiple choice: Input Option
      - Data type: Codes
      - Input options: None
      - Calculation: None
      - Quantity sub-type: N/A
      - Validation Condition: None
      - Editable: Yes
      - Required O
      - HL7 FHIR R4 – Resource: Observation.value[x]
      - HL7 FHIR R4 - Resource Type: CodeableConcept
      - Binding or Custom Value Set Name or Reference: Agreement Degree
      - Scope: ASLP
      - FHIR Code System: http://example.org/sdh/dtr/aslp/CodeSystem/aslp-codes
    - Option Two (note only the `Data element ID` and `Data element Label` columns vary between options so consider copy/paste/updating the existing option row)
      - Activity ID: ASLP.A1 Adult Sleep Studies
      - Data element ID: ASLP.AE.DE3
      - Data element label: Strongly Disagree (Never)
      - Description and definition: Agreement Degree
      - Multiple choice: Input Option
      - Data type: Codes
      - Input options: None
      - Calculation: None
      - Quantity sub-type: N/A
      - Validation Condition: None
      - Editable: Yes
      - Required O
      - Binding or Custom Value Set Name or Reference: Agreement Degree
      - Scope: ASLP
      - FHIR Code System: http://example.org/sdh/dtr/aslp/CodeSystem/aslp-codes
    - Option Three
      - Activity ID: ASLP.A1 Adult Sleep Studies
      - Data element ID: ASLP.AE.DE4
      - Data element label: Disagree (<1/wk)
      - Description and definition: Agreement Degree
      - Multiple choice: Input Option
      - Data type: Codes
      - Input options: None
      - Calculation: None
      - Quantity sub-type: N/A
      - Validation Condition: None
      - Editable: Yes
      - Required O
      - Binding or Custom Value Set Name or Reference: Agreement Degree
      - Scope: ASLP
      - FHIR Code System: http://example.org/sdh/dtr/aslp/CodeSystem/aslp-codes
    - Option Four
      - Activity ID: ASLP.A1 Adult Sleep Studies
      - Data element ID: ASLP.AE.DE5
      - Data element label: Somewhat Agree (1-2/wk)
      - Description and definition: Agreement Degree
      - Multiple choice: Input Option
      - Data type: Codes
      - Input options: None
      - Calculation: None
      - Quantity sub-type: N/A
      - Validation Condition: None
      - Editable: Yes
      - Required O
      - Binding or Custom Value Set Name or Reference: Agreement Degree
      - Scope: ASLP
      - FHIR Code System: http://example.org/sdh/dtr/aslp/CodeSystem/aslp-codes
    - Option Five
      - Activity ID: ASLP.A1 Adult Sleep Studies
      - Data element ID: ASLP.AE.DE6
      - Data element label: Agree (3-4/wk)
      - Description and definition: Agreement Degree
      - Multiple choice: Input Option
      - Data type: Codes
      - Input options: None
      - Calculation: None
      - Quantity sub-type: N/A
      - Validation Condition: None
      - Editable: Yes
      - Required O
      - Binding or Custom Value Set Name or Reference: Agreement Degree
      - Scope: ASLP
      - FHIR Code System: http://example.org/sdh/dtr/aslp/CodeSystem/aslp-codes
    - Option Six
      - Activity ID: ASLP.A1 Adult Sleep Studies
      - Data element ID: ASLP.AE.DE7
      - Data element label: Strongly Agree (5-7/wk)
      - Description and definition: Agreement Degree
      - Multiple choice: Input Option
      - Data type: Codes
      - Input options: None
      - Calculation: None
      - Quantity sub-type: N/A
      - Validation Condition: None
      - Editable: Yes
      - Required O
      - Binding or Custom Value Set Name or Reference: Agreement Degree
      - Scope: ASLP
      - FHIR Code System: http://example.org/sdh/dtr/aslp/CodeSystem/aslp-codes
- save and close the Data Dictionary
- run the Accelerator Kit [Running the Accelerator Kit](#running-the-accelerator-kit)
- note:
   - input/cql/ASLPConcepts.cql has a new concept "Snores in Sleep"
   - input/cql/ASLPDataElements.cql has a new define "Snores in Sleep"
   - input/resources/questionnaire/questionnaire-ASLPA1.json has a new action, linkId = 10
   - input/vocabulary/codesystem/codesystem-aslp-codes.json has new codes for the "Snores in Sleep" answer options
   - there are new files for the "Snores in Sleep" Data Element:
      - input/examples/observation-aslp-snores-in-sleep-example.json
      - input/frofiles/structuredefinition-aslp-snores-in-sleep.json
      - input/vocabulary/valueset/valueset-aslp-ae-de2.json
- revert the changes from this walkthrough:
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

Use the following steps to revert unwanted changes to local files after running the Accelerator kit, for example, when pracicing [Modifying](#modifying) the Adult Sleep Studies artifact library as part of this Walkthrough:

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
