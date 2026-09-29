library ColorectalCancerScreeningsPAAdjudication version '0.0.001'

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include ColorectalCancerConcepts called Concepts
include CaseFeatureCommon called CFC
include ColorectalCancerRecommendation called Recommendation
include ColorectalCancerScreeningsPriorAuthorization called CCSPA

context Patient

//These are used for the derived Questionnaire/Adjudication approach
define "Most Recent Qualifying Patient Age":
  CFC.MostRecent([Observation: Concepts."Qualifying Patient Age"])

define "Qualifying Patient Age":
  if not "Most Recent Qualifying Patient Age" is null then
    "Most Recent Qualifying Patient Age"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying Patient Age Assertion",
      Recommendation."45 through 75",
      'http://example.org/sdh/demo/StructureDefinition/ccs-qualifying-age-casefeature',
      Patient,
      ''
    )

define "Within Qualifying Age Range":
  "Qualifying Patient Age".value.value as System.Boolean

define "Not Within Qualifying Age Range":
  not "Within Qualifying Age Range"

define "Most Recent Total Colectomy Performed":
  CFC.MostRecent([Observation: Concepts."Total Colectomy Performed"])

define "Total Colectomy Performed":
  if not "Most Recent Total Colectomy Performed" is null then
    "Most Recent Total Colectomy Performed"
  else
    CFC.CaseFeatureObservation(
      Concepts."Total Colectomy Performed Assertion",
      CCSPA."Total Colectomy Performed",
      'http://example.org/sdh/demo/StructureDefinition/total-colectomy-casefeature',
      CFC.MostRecent(CCSPA."Qualified Total Colectomy"),
      ''
    )

define "Has Total Colectomy Performed":
  "Total Colectomy Performed".value.value as System.Boolean

define "Has Not Had Total Colectomy Performed":
  not "Has Total Colectomy Performed"

define "Most Recent Has Malignant Neoplasm":
  CFC.MostRecent([Observation: Concepts."Has Malignant Neoplasm"])

define "Malignant Neoplasm":
  if not "Most Recent Has Malignant Neoplasm" is null then
    "Most Recent Has Malignant Neoplasm"
  else
    CFC.CaseFeatureObservation(
      Concepts."Has Malignant Neoplasm Assertion",
      CCSPA."Has Malignant Neoplasm",
      'http://example.org/sdh/demo/StructureDefinition/malignant-neoplasm-casefeature',
      CFC.MostRecent(CCSPA."Qualified Malignant Neoplasm"),
      ''
    )

define "Has Malignant Neoplasm":
  "Malignant Neoplasm".value.value as System.Boolean

define "Does Not Have Malignant Neoplasm":
  not "Has Malignant Neoplasm"

define "Most Recent Colorectal Screening Performed":
  CFC.MostRecent([Observation: Concepts."Qualifying Colorectal Screening Performed"])

define "Qualifying Colorectal Screening":
  if not "Most Recent Colorectal Screening Performed" is null then
    "Most Recent Colorectal Screening Performed"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying Colorectal Screening Performed Assertion",
      CCSPA."Qualifying Colorectal Screening",
      'http://example.org/sdh/demo/StructureDefinition/cc-qualifying-screening-casefeature',
      CFC.MostRecent(CCSPA."Colorectal Screening"),
      ''
    )

define "Has Qualifying Colorectal Screening":
  "Qualifying Colorectal Screening".value.value as System.Boolean

define "Does Not Have Qualifying Colorectal Screening":
  not "Has Qualifying Colorectal Screening"

define "Not Approved Detail":
  'Prior Authorization NOT APPROVED.'
    + '<br />Reasoning:' 
    + Coalesce(
      if "Not Within Qualifying Age Range" then '<br />- Not within qualifying age range' else '',
      if "Has Total Colectomy Performed" then '<br />- Total colectomy performed' else '',
      if "Has Malignant Neoplasm" then '<br />- Has malignant neoplasm' else '',
      if "Has Qualifying Colorectal Screening" then '<br />- Already has qualifying colorectal screening' else ''
    )

define "Approved Detail":
  'Prior Authorization APPROVED.'
    + '<br />Reasoning:'
    + '<br />- Within qualifying age range' 
    + '<br />- Has not had total colectomy performed' 
    + '<br />- Does not have malignant neoplasm' 
    + '<br />- Does not have qualifying colorectal screening'

define "Patient Reference":
  CFC.ReferenceTo(Patient)

//TODO this should be a reference to the provider
define "Provider Reference":
  CFC.ReferenceTo(Patient)