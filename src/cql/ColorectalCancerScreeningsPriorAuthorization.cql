library ColorectalCancerScreeningsPriorAuthorization version '0.0.001'

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include MATGlobalCommonFunctionsFHIR4 version '6.1.000' called Global
include ColorectalCancerConcepts called Concepts
include CaseFeatureCommon called CFC
include ColorectalCancerRecommendation called Recommendation

codesystem "ObservationCategoryCodes": 'http://terminology.hl7.org/CodeSystem/observation-category' 

valueset "Malignant Neoplasm of Colon": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1001'
valueset "Total Colectomy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.12.1019'
valueset "Colonoscopy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1020' 
valueset "CT Colonography": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1038'
valueset "FIT DNA": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.108.12.1039' 
valueset "Flexible Sigmoidoscopy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.12.1010'

code "laboratory": 'laboratory' from "ObservationCategoryCodes" display 'laboratory'

parameter "Device Request" List<FHIR.DeviceRequest>
parameter "Device Request Id" List<System.String>
parameter "Medication Request" List<FHIR.MedicationRequest>
parameter "Medication Request Id" List<System.String>
parameter "Nutrition Order" List<FHIR.NutritionOrder>
parameter "Nutrition Order Id" List<System.String>
parameter "Service Request" List<FHIR.ServiceRequest>
parameter "Service Request Id" List<System.String> 
//  default { 'Colonoscopy', 'Colonoscopy2' }
parameter "Coverage Id" List<System.String>

context Patient

define "Service Request From ID":
  [ServiceRequest] SR
    where SR.id in "Service Request Id"     

// TODO: this is for demo only.
define "Service Request for PA":
  CFC.MostRecent(
    Coalesce(
      "Service Request From ID",
      null as List<FHIR.ServiceRequest>
    )
    union Coalesce(
      "Service Request",
      null as List<FHIR.ServiceRequest>
    )
  )

define "Service Request Code":
  ("Service Request for PA").code

define "Service Request Date":
  ("Service Request for PA").authoredOn

// these should be in a shared library
define "Patient Age":
  AgeInYears()
  
define "Qualified Total Colectomy":
  [Procedure: "Total Colectomy"] Colectomy
    where Colectomy.status = 'completed'

define "Total Colectomy Performed":
  exists "Qualified Total Colectomy"

define "Qualified Malignant Neoplasm": 
  [Condition: "Malignant Neoplasm of Colon"]

define "Has Malignant Neoplasm":
  exists "Qualified Malignant Neoplasm"

define "Colonoscopy Performed":
  [Procedure: "Colonoscopy"] Colonoscopy
    where Colonoscopy.status = 'completed'
      and Global."Normalize Interval" ( Colonoscopy.performed ) ends 10 years or less on or before Date(year from today(), 12, 31)

define "CT Colonography Performed":
  [Observation: "CT Colonography"] Colonography
    where Colonography.status in { 'final', 'amended', 'corrected', 'appended' }
      and Global."Normalize Interval" ( Colonography.effective ) ends 5 years or less on or before Date(year from today(), 12, 31)

define "Fecal Immunochemical Test DNA Performed":
  [Observation: "FIT DNA"] FitDNA
    where FitDNA.status in { 'final', 'amended', 'corrected' }
      and exists ( FitDNA.category FitDNACategory
        where "laboratory" in FHIRHelpers.ToConcept ( FitDNACategory ).codes
      )
      and FitDNA.value is not null
      and Global."Latest" ( FitDNA.effective ) 3 years or less on or before Date(year from today(), 12, 31)

define "Flexible Sigmoidoscopy Performed":
  [Procedure: "Flexible Sigmoidoscopy"] FlexibleSigmoidoscopy
    where FlexibleSigmoidoscopy.status = 'completed'
      and Global."Normalize Interval" ( FlexibleSigmoidoscopy.performed ) ends 5 years or less on or before Date(year from today(), 12, 31)

define "Qualifying Colorectal Screening":
  exists "Colonoscopy Performed"
    or exists "Flexible Sigmoidoscopy Performed"
    or exists "Fecal Immunochemical Test DNA Performed"
    or exists "CT Colonography Performed"

define "Colorectal Screening":
  if exists "Colonoscopy Performed" then
    "Colonoscopy Performed"
  else if exists "Flexible Sigmoidoscopy Performed" then
    "Flexible Sigmoidoscopy Performed"
  else if exists "Fecal Immunochemical Test DNA Performed" then
    "Fecal Immunochemical Test DNA Performed"
  else if exists "CT Colonography Performed" then
    "CT Colonography Performed"
  else
    null