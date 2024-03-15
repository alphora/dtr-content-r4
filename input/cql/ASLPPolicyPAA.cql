library ASLPPolicyPAA

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'
include ASLPPolicyCaseFeatures called PCF
include ASLPPolicyConcepts called AC
include ASLPPolicyScreening called PS

context Patient

define "Most Recent Qualifying Patient Age":
  PCF.MostRecent([Observation: AC."Qualifying Patient Age Assertion"])

define "Qualifying Patient Age":
  if not "Most Recent Qualifying Patient Age" is null
    then "Most Recent Qualifying Patient Age"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Patient Age Assertion",
      PS."Qualifying Patient Age",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-patientage-casefeature-definition',
      Patient,
      ''
    )

define "Is Qualifying Age":
  "Qualifying Patient Age".value.value as System.Boolean

define "Not Within Qualifying Age":
  not "Is Qualifying Age"


define "Most Recent Excessive Daytime Sleepiness Observation":
  PCF.MostRecent([Observation: AC."Qualifying Excessive Daytime Sleepiness Assertion"])

define "Qualified Excessive Daytime Sleepiness":
  if not "Most Recent Excessive Daytime Sleepiness Observation" is null 
    then "Most Recent Excessive Daytime Sleepiness Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Excessive Daytime Sleepiness Assertion",
      PS."Qualified Excessive Daytime Sleepiness",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-eds-screening-casefeature',
      PCF.MostRecent(PS."Excessive Daytime Sleepiness"),
      ''
    )

define "Has Excessive Daytime Sleepiness":
  "Qualified Excessive Daytime Sleepiness".value.value as System.Boolean

define "No Excessive Daytime Sleepiness":
  not "Has Excessive Daytime Sleepiness"

/*


define "Has Total Colectomy Performed":
  "Total Colectomy Performed".value.value as System.Boolean

define "Has Not Had Total Colectomy Performed":
  not "Has Total Colectomy Performed"

*/