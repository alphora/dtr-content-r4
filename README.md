# demo-content-r4

This repository contains knowledge content and instructions for demo environments for Clinical Reasoning.

## Usage

In general, the FHIR functionality for each demo is captured in the Thunder Client extension.  There is a separate Thunder Client Collection for each demo.

Note: Thunder Client updated their functionality, and Collection info within a GitHub repo now requires a license, so, unfortunately, this functionality is no longer available.  You're on your own with the provided documentation (below).

Additional information for each demo can be found in the wiki.

## Demos

- Care Gaps Management <https://github.com/alphora/demo-content-r4/wiki/Gare-Gaps-Management>

## Bundles

The `_refresh` operation misses a number of resources in its bundling.  Use the following to bundle everything:

``` bat
JAVA -jar "input-cache\tooling-cli-2.4.0.jar" -BundleResources -v=r4 -e=json -op=bundles -ptd=input\resources -bid=cc-cds-resources
JAVA -jar "input-cache\tooling-cli-2.4.0.jar" -BundleResources -v=r4 -e=json -op=bundles -ptd=input\vocabulary -bid=cc-cds-vocabulary
JAVA -jar "input-cache\tooling-cli-2.4.0.jar" -BundleResources -v=r4 -e=json -op=bundles -ptd=input\tests\ColorectalCancerCaseFeatures -bid=cc-cds-patient-data
JAVA -jar "input-cache\tooling-cli-2.4.0.jar" -BundleResources -v=r4 -e=json -op=bundles -ptd=input\examples -bid=cc-cds-examples
```

This IG includes demo content for:

- Quality Measure Evaluation
- Clinical Practice Guideline Recommendation

To load the demo content:

``` REST
POST [base] BODY=bundles/cc-cds-examples-bundle.json
POST [base] BODY=bundles/cc-cds-patient-data-bundle.json
POST [base] BODY=bundles/cc-cds-examples-bundle.json
```

These content can be used for:

- [Quality Reporting](#quality-reporting)
- [Clinical Decision Support Recommendation](#clinical-decision-support-recommendation)
- [Care List](#care-list)
- [Care Gap](#care-gap)

## Quality Reporting

Documentation TBD

## Clinical Decision Support Recommendation

TODO: persist the result like with the Care List and Care Gap use cases.  Pending design.

### Recommendation Usage

``` REST
GET [base]/PlanDefinition/cc-screening-pathway-definition/$r5.apply?subject=<patientid>
```

### Example (given the demo content has been loaded)

``` REST
GET [base]/PlanDefinition/cc-screening-pathway-definition/$r5.apply?subject=Patient/nocoverageconcern-sedconcern-sigcomp
```

### Example Recommendation Result

[Bundle](input/examples/Bundle-apply-nocoverageconcern-sedconcern-sigcomp-cc-screening-pathway-definition.json)

### Recommendation Result Walk Through

The result is a `Bundle` with items in the `entry` element.

The entry items consist of (in no particular order):

- RequestGroup(s)
- ServiceRequest(s)
- Questionnaire

#### RequestGroup(s)

The RequestGroup(s) set is a hierarchical chain, with links from parent to child being the action.resource.reference.
The pertinent RequestGroup is the bottommost child, which references the ServiceRequest(s).

So the structure is:

- Top Parent: not referenced by another RequestGroup and action.resource.reference => another RequestGroup

- Mid Parent/Child:  referenced by another RequestGroup and action.resource.reference => another RequestGroup (or blank in the case of an intermediate state; see below for details)

- Bottom Child: referenced by another RequestGroup and action.resource.reference => ServiceRequest

In the example result ([Bundle](input/examples/Bundle-apply-nocoverageconcern-sedconcern-sigcomp-cc-screening-pathway-definition.json)), the Bottom Child:

- has an `id`=`cc-screening-recommendation-definition-ct-colonography`

- has references to four ServiceRequests

An extension on each action of the Bottom Child indicates whether the referenced ServiceRequest is Recommended.  The extension url is `http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-option-recommended`.

In this example, the CT Colonography ServiceRequest is Recommended:

``` JSON
{
    "extension": [
        {
            "url": "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-option-selected",
            "valueBoolean": false
        },
        {
            "url": "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-option-recommended",
            "valueBoolean": true
        }
    ],
    "title": "CT Colonography Recommendation",
    "description": "Provides a recommendation for a patient where sedation is a concern, with an evasive procedure complication.",
    "type": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/action-type",
                "code": "create",
                "display": "Create"
            }
        ]
    },
    "resource": {
        "reference": "ServiceRequest/cc-cds-ct-colonography"
    }
}
```

And Colonoscopy is not:

``` JSON
{
    "extension": [
        {
            "url": "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-option-selected",
            "valueBoolean": false
        },
        {
            "url": "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-option-recommended",
            "valueBoolean": false
        }
    ],
    "title": "Colonoscopy Recommendation",
    "description": "Provides a recommendation for a patient where sedation is not a concern, without an invasive procedure complication.",
    "type": {
        "coding": [
            {
                "system": "http://terminology.hl7.org/CodeSystem/action-type",
                "code": "create",
                "display": "Create"
            }
        ]
    },
    "resource": {
        "reference": "ServiceRequest/cc-cds-colonoscopy"
    }
}
```

NOTE: if there is no "Bottom Child" (i.e., a RequestGroup that references ServiceRequest(s) instead of another RequestGroup), then there is no Recommendation.  This is an intermediate state.  Resolving this state is beyond the scope of this documentation (for now).

#### ServiceRequest(s)

The set of ServiceRequest(s) is the set of "order" options.  The Recommended order option is indicated as described above.

Each ServiceRequest includes:

- the code of the "order"
- a reference to the patient the order is for

When a ServiceRequest is submitted to the EHR, the expected result is that an Order for the Service will be placed.  Placing an Order is beyond the scope of this documentation (for now).

#### Questionnaire

Used by the Recommender Application to allow the user to influence the Recommendation.  
Using this is beyond the scope of this documentation (for now).

## Care List

### Care List Usage (given the demo content has been loaded)

``` REST
GET [base]/MeasureReport?type=subject-list&_sort=date&_maxresults=1
```

You can also generate the result dynamically.

Example:

``` REST
GET [base]/Measure/ColorectalCancerScreeningsFHIR/$evaluate-measure?reportType=subject-list&periodStart=2024-01-01&periodEnd=2024-06-01
```

However, the intent is that the Care List is generated by a separate process (chron, event, etc.), so this should only be used for training/discovery purposes.

### Example Care List Result

[MeasureReport](input/examples/MeasureReport-subject-list-ColorectalCancerScreeningFHIR-prospective.json)

### Care List Result Walk Through

The result is a `MeasureReport` resource with the Denominator and Numerator represented as `List` resource(s) in the `contained` element.

#### Patients With Open Gaps

The result needs to be parsed to determine the patients with open gaps.
`Patients with Open Gaps` = `patients in Denominator` without `patients in Numerator`.

#### Denominator

The List of patients in the Denominator is in the `contained` of the result.  The `id` of the List is in the `group.population.subjectResults.reference` where the population code is `denominator`:

``` FHIRPath
Bundle.entry[0].resource.group[0].population.where(code.coding.code='denominator').subjectResults.reference
```

For example, for the example Care List Result, the result of:

``` FHIRPath
Bundle.entry[0].resource.group[0].population.where(code.coding.code='denominator').subjectResults.reference
```

= `#6b384f55-b3dd-40c3-9dff-e29041651fc9`.

That `id` can then be used in the following to get the List resource within the `contained` that includes references to the patients in the Denominator:

(note, you have to remove the '#')

``` FHIRPath
Bundle.entry[0].resource.contained.where(id='6b384f55-b3dd-40c3-9dff-e29041651fc9')
```

Note: you should be able to do it all in one, but it wasn't working in the FHIRPath tester for me:

``` FHIRPath
Bundle.entry[0].resource.contained.where(id=Bundle.entry[0].resource.group[0].population.where(code.coding.code='denominator').subjectResults.reference.replace('#',''))
```

#### Numerator

Same as the Denominator, except use `numerator` for the code:

``` FHIRPath
Bundle.entry[0].resource.group[0].population.where(code.coding.code='numerator').subjectResults.reference
```

#### Lists

The Denominator and Numerator will give you a FHIR List resource with items in the entry element. Each item has a reference `entry.item.reference`.

Example Denominator List:

(note there is a bug in the references.  They should include the resource type, `Patient\`)

``` JSON
{
    "resourceType": "List",
    "id": "6b384f55-b3dd-40c3-9dff-e29041651fc9",
    "entry": [
        {
            "item": {
                "reference": "coverage-concern-sed-assertion-override"
            }
        },
        {
            "item": {
                "reference": "nocoverageconcern-sedationconcern"
            }
        },
        {
            "item": {
                "reference": "coverage-concern"
            }
        },
        {
            "item": {
                "reference": "nocovconcern-nosedconcern-colonscopycomp"
            }
        },
        {
            "item": {
                "reference": "nocovconcern-nosedconcern-nocolonscopycomp"
            }
        },
        {
            "item": {
                "reference": "nocoverageconcern-sedconcern-sigcomp"
            }
        },
        {
            "item": {
                "reference": "coverage-concern-sed-assertion-new"
            }
        },
        {
            "item": {
                "reference": "nocoverageconcern-sedconcern-nosigcomp"
            }
        }
    ]
}
```

The numerator List example is similar.  Note if the Numerator count is zero there will not be an associated List resource in the `contained` (i.e., all the patients in the Denominator are gaps).

## Care Gap

We can't currently run the actual $care-gap report because there's a bug in Smile with the [SearchParameter](input/resources/searchparameter/bundle-composition-patient-identifier.json) needed and "mixed inter-Bundle" referencing (bug has been fixed in Smile, in `master`, as of 12/31/23, usage pending inclusion in a release).  We can get the same info from the regular Measure Report though by using `_include` so we'll use that for now.

### Care Gap Usage (regular MR version)

``` REST
GET [base]/MeasureReport?patient=<patientid>&measure=<measure>&_sort=date&_maxresults=1&_include=MeasureReport:evaluated-resource
```

Example (given the demo content has been loaded):

``` REST
GET [base]/MeasureReport?patient=Patient/nocoverageconcern-sedconcern-sigcomp&measure=http://example.org/sdh/demo/Measure/ColorectalCancerScreeningsFHIR|0.0.003&_sort=date&_maxresults=1&_include=MeasureReport:evaluated-resource
```

You can also generate the result dynamically.

Example:

``` REST
GET [base]/Measure/ColorectalCancerScreeningsFHIR/$evaluate-measure?subject=Patient/nocoverageconcern-sedconcern-nosigcomp&periodStart=2024-01-01&periodEnd=2024-06-01&type=individual
```

However, the intent is that the Care Gaps are generated by a separate process (chron, event, etc.), so this should only be used for training/discovery purposes.

### Example Care Gap Result (regular MR version)

The result is a Bundle, which includes information about the resources used to determine each population value, plus the actual resources, including the Patient.

Example: [Bundle](input/examples/Bundle-evaluate-measure-nocoverageconcern-sedconcern-sigcomp-ColorectalCancerScreeningFHIR.json).

### Care Gap Result Walk Through (regular MR version)

Due to the `_include` parameter, the result is a `searchset` Bundle.  

The Bundle structure only includes entries.  The entries include the following:

- MeasureReport
- MeasureReport.evaluatedResources (as FHIR resources, including the Patient)

### Care Gap Usage (pending fix of bug)

``` REST
GET [base]/Bundle?composition.type=96315-7&type=document&composition.patient.identifier=<patientidentifier>
```

Note the usage of `patientidentifier` versus the normally used `patientid`.  This is because searching by `patientid` is risky so Smile doesn't implement it.

Example (given the demo content has been loaded):

``` REST
GET [base]/Bundle?composition.type=96315-7&type=document&composition.patient.identifier=999999975
```

You can also generate the result dynamically.

Example:

``` REST
GET [base]/Measure/$care-gaps?subject=Patient/nocoverageconcern-sedconcern-sigcomp&periodStart=2024-01-01&periodEnd=2024-06-01&status=open-gap&measureId=ColorectalCancerScreeningsFHIR
```

However, the intent is that the Care Gaps are generated by a separate process (chron, event, etc.), so this should only be used for training/discovery purposes.

### Example Care Gap Result (pending fix of bug)

The result is a Bundle with a MeasureReport that includes information about the resources used to determine each population value, plus the actual resources, including the Patient.

Example: [Bundle](input/examples/Bundle-care-gaps-nocoverageconcern-sedconcern-sigcomp-ColorectalCancerScreeningFHIR-prospective.json).

### Care Gap Result Walk Through  (pending fix of bug)

The result is a Bundle of type `document`.  The `document` Bundle proscribes a certain structure where the first entry is a Composition.  The DEQM IG further proscribes a certain structure  which includes the MeasureReport, a DetectedIssue, and the MeasureReport.evaluatedResources:

- Composition
- MeasureReport
- DetectedIssue
- MeasureReport.evaluatedResources (as FHIR resources, including the Patient)
