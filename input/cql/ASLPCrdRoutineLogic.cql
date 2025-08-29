library ASLPCrdRoutineLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

valueset "Routine Procedure Valueset": 'http://terminology.smilecdr.com/cs/routine'

context Patient

// CRD-7
define "Title":
  'Prior Auth Evaluation'

// CRD-7
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission' 

// CRD-7
define function "Qualification"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  'Order is covered. No prior auth is required for ' + Ctx."Service Request Item Code"(requestItem).display

define "Qualification":
  'Order is covered. No prior auth is required for this request'

// CRD-7
define "Detail Text":
  'Prior Authorization Not Required'

// CRD-7
define "Detail Debugging":
  'Not yet implemented.'

// CRD-7
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'covered', 'no-auth', 'no-auth', "Detail Text", "Qualification"(requestItem), 'info')

define function "Is Routine"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  exists(("Routine Service Requests"(requestItem)))

define function "Not Routine"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  not (("Is Routine"(requestItem)))

define function "Routine Service Requests"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  ({ requestItem }) R
    where (Ctx.GetCode(R)) in "Routine Procedure Valueset"