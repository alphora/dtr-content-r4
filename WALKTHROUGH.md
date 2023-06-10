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
  
The Accelerator Kit is the combination of a JAVA Command Line tool and a Data Dictionary that generates the FHIR/CQL resources for the data elements defined in the Data Dictionary.  The Data Dictionary is in the form of a spreadsheet with a specific format.  More details can be found in the [CQF Tooling](https://github.com/cqframework/cqf-tooling) repository.

### JAVA Command Line tool

The JAVA Command Line tool is deployed to Maven as a JAVA jar file named tooling-x.y.z-SNAPSHOT-jar-with-dependencies.jar.  A script named `_updateCQFTooling` has been included in the root this repository to download the jar file for local use.  There are Windows (.bat) and non-Windows (.sh) versions of the script.  Run the appicable script to copy the CQF Tooling Command Line tool locally.

NOTE: Due to breaking changes in this project's Data Dictionary file a specific version of the CQF Tooling Command Line tool has temporarily beein included directly in the repository.  Until this issue is resolved you do not need to run the script to download it locally.

### Data Dictionary

The Data Dictionary is a specifically formatted Excel spreadsheet.  The Data Dictionary for this project has been included directly in the repository at [input/l2/DTR.xlsx](input/l2/DTR.xlsx).
  
<!-- 
## USPSTF Recommendation on Colorectal Cancer Screening

The artifacts in this walkthrough provide a platform-independent, standards-based representation of a decision support rule and quality measure for implementing the US Preventive Services Task Force recommendation on Colorectal Cancer Screening:

* The U.S. Preventive Services Task Force (2016) recommends screening for colorectal cancer starting at age 50 years and continuing until age 75 years. This is a Grade A recommendation ([U.S. Preventive Services Task Force, 2016](https://www.uspreventiveservicestaskforce.org/uspstf/recommendation/colorectal-cancer-screening-june-2016)).

> NOTE: This recommendation was updated in May of 2021; the updates have not been applied to this artifact. It is an exercise for the reader to update the content per the 2021 recommendation.

 -->
