library ASLPCrdContextValidationLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

// CRD-8
define "Title":
  'Prior Auth Evaluation'

// CRD-8
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

// CRD-8 // detail.code.text
define "Detail Text 8":
  'Submit Prior Authorization Form'

// CRD-8 // detail.qualification
define "Qualification 8":
  'Unable to process due to incomplete/ambiguous information. Please submit a prior auth form.'

// CRD-8.1 // detail.code.text
define "Detail Text 8.1":
  'Error has occurred. No order found.'

// CRD-8.1 // detail.qualification
define "Qualification 8.1":
  'Error has occurred. No order found. Please contact your system administrator.'

// CRD-8.3 // detail.code.text
define "Detail Text 8.3":
  'Unable to Process Request electronically.'

// CRD-8.3 // detail.qualification
define "Qualification 8.3":
  'Unable to Process Request electronically. Please contact the payer.'

// CRD-8
define "Detail Debugging":
  'Not yet implemented.'

// CRD-8
define function "Insufficient or Ambiguous High"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  "Too many provider or payor coverages"
    or "Request Patient does not match Context Patient"(requestItem)

define "Too many provider or payor coverages":  
  Count(Ctx."Provider"."Coverages") > 1 or
    Count(Ctx."Payor"."Coverages") > 1

define function "Request Patient does not match Context Patient"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  if requestItem is null then 
    false
  else
    Ctx.GetSubjectID(requestItem) !~ Ctx."Provider"."Patient".id.value

// CRD-8.1
define function "DomainResource is Empty"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  IsNull(requestItem)

// CRD-8.3
define function "Received Provider Data Cannot be Processed"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  Ctx."GetResourceType"(requestItem) in Ctx."UnsupportedResourceTypes"