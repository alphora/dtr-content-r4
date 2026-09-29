library ColorectalCancerRecommendation

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include FHIRCommon version '1.1.000' called FC

valueset "Total Colectomy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.12.1019'
valueset "Sedation Concern Conditions": 'http://example.org/sdh/demo/ValueSet/SedationConcernConditions'
valueset "Colon Procedure Complication Conditions": 'http://example.org/sdh/demo/ValueSet/ColonProcedureComplicationConditions' 

context Patient

//TODO: some of these should return resources, not discreet values.
define "Coverage Concern":
  [Coverage]

define "Sedation Concern":
  [Condition: "Sedation Concern Conditions"]

define "Colon Invasive Procedure Complications":
  [Condition: "Colon Procedure Complication Conditions"]

/* Intermediate Data Elements */
define "45 through 75":
  AgeInYears() >= 45 and AgeInYears() <= 75

/* Inclusion Criteria */
define "Inclusion Criteria":
  "45 through 75"
    and not "Exclusion Criteria"

define "Is Eligible Summary":
  if "Inclusion Criteria"
    then 'Eligible patient: ' + First(Patient.name).text
        + ': Born ' + ToString(Patient.birthDate)
        + ' (Age: ' + ToString(AgeInYears())
        + '), Gender: ' + Patient.gender
  else null

define "Is Eligible Indicator":
  if "Inclusion Criteria"
    then 'info'
  else null

/* Exclusion Criteria */
define "Total Colectomy Performed":
  [Procedure: "Total Colectomy"] Colectomy
    where Colectomy.status = 'completed'

define "Exclusion Criteria":
  (
    (not "45 through 75")
        or exists("Total Colectomy Performed")
  )

define "Exclusion Summary":
  if "Exclusion Criteria"
    then First(Patient.name).text +
      ': Born ' + ToString(Patient.birthDate) +
      ' (Age: ' + ToString(AgeInYears()) +
      '), Gender: ' + Patient.gender
    else null

define "Exclusion Detail":
  if "Exclusion Criteria" then
    'Patient is not currently recommended for colorectal cancer screening'
      +
        if (not "45 through 75") then
          ' becauase they are not between 45 and 75'
        else if exists("Total Colectomy Performed") then
          ' because they have had a Total Colectomy performed'
        else 
          ''
      + '.'
  else null

define "Exclusion Indicator":
  if "Exclusion Criteria"
    then 'info'
  else null
