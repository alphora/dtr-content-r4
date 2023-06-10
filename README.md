# dtr-content-r4


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
   |-- input
       |-- cql
           |-- ALSP.cql
       |-- resources
           |-- library
               |-- ALSP.json
       |-- tests
           |-- library
               |-- ALSP
       |-- vocabulary
           |-- valueset
```

## Refresh IG Processing

The CQF Tooling provides support for refreshing measure and library resources based on
the content of the CQL libraries, as well as packaging the measures as artifacts that
include dependencies and test cases.

To run this tooling, make sure it is available locally using the _updateCQFTooling script,
then run the _refresh script. This script should be run whenever CQL content changes,
and prior to the publishing process.
