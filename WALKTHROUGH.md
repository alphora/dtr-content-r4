# Adult Sleep Studies Prior Authorization DTR Walkthrough

This walkthrough guides you through setting up, building, and modifying the Adult Sleep Studies artifact library to illustrate how to author, distribute, and consume FHIR- and CQL-based knowledge artifacts for
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
  
The Accelerator Kit is the combination of a JAVA Command Line tool and a Data Dictionary that generates the FHIR/CQL resources for the data elements defined in the Data Dictionary.  The JAVA command Line tool is in the form of a JAVA jar file named CQF Tooling. The Data Dictionary is in the form of a spreadsheet with a specific format.  More details can be found in the [CQF Tooling](https://github.com/cqframework/cqf-tooling) repository.

### CQF Tooling CLI

CQF Tooling CLI is deployed to Maven as a JAVA jar file named tooling-x.y.z-SNAPSHOT-jar-with-dependencies.jar.  A script named `_updateCQFTooling` has been included in the root this repository to download the jar file for local use.  There are Windows (.bat) and non-Windows (.sh) versions of the script.  Run the appicable script to copy the CQF Tooling locally.

NOTE: Due to breaking changes in this project's Data Dictionary file a specific version of the CQF Tooling has temporarily been included directly in the repository.  Until this issue is resolved you do not need to run the script to download it locally.

### Data Dictionary

The Data Dictionary is a specifically formatted Excel spreadsheet.  The Data Dictionary for this project has been included directly in the repository at [input/l2/DTR.xlsx](input/l2/DTR.xlsx).  To view the contents, open the file using Microsoft Excel or equivalent.

### Running the Accelerator Kit

The JAVA CLI command can be used in a terminal to run the Accelerator Kit, using the following steps:

- ensure the JAVA CLI is installed
- open a terminal (in VS Code: Terminal/New Terminal)
- ensure the CQF Tooling has been copied locally [CQF Tooling CLI](#cqf-tooling-cli)
- in the terminal, run:

```
JAVA -jar "input-cache/<tooling-x.y.z-SNAPSHOT-jar-with-dependencies.jar>" -ProcessAcceleratorKit -s=ASLP -pts=input/l2/DTR.xlsx -op=./ -dep="ASLP.A1 Adult Sleep Studies"
```

NOTE: Due to breaking changes in this project's Data Dictionary file a specific version of the CQF Tooling has temporarily been included directly in the repository.  Until this issue is resolved run the following instead:

```
JAVA -jar "bin/tooling-1.3.2-SNAPSHOT-jar-with-dependencies.jar" -ProcessAcceleratorKit -s=ASLP -pts=input/l2/DTR.xlsx -op=./ -dep="ASLP.A1 Adult Sleep Studies"
```

NOTE: Due to errors in the CQF Tooling running the Accelerator Kit will result in changes to local files.  These changes should not be commited to the repository.  Instead the bugs in the CQF Tooling should be fixed so that running the Accelerator Kit produces the files currently in this IG.  

Use the following steps to revert local files after running the Accelerator kit:

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
