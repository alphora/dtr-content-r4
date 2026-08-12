library ASLPCrdRoutineLogic version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include ASLPContext version '0.1.0' called Ctx
include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

valueset "Routine Procedure Valueset": 'http://terminology.smilecdr.com/cs/routine'

context Patient

// CRD-7
define "Title":
  'Prior Auth Evaluation'

// CRD-7
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission' 

// CRD-7
define function "Qualification"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  'Order is covered. No prior auth is required for ' + Ctx."Service Request Item Code"(requestItem).display

define "Detail Qualification":
  'Order is covered. No prior auth is required for this request'

// CRD-7
define "Detail Text":
  'Prior Authorization Not Required'

// CRD-7
define "Detail Debugging":
  'Not yet implemented.'

// CRD-7
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'covered', 'no-auth', 'no-auth', "Detail Text", "Qualification"(requestItem), 'info')

define function "Is Routine"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest,FHIR.Appointment, FHIR.Task>):
  Ctx.GetCode(requestItem) is not null
    and exists ((Ctx.GetCode(requestItem).coding) c 
      where c in "Routine Procedure Valueset"
    )

define function "Not Routine"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  not (("Is Routine"(requestItem)))

// define function "Routine Service Requests"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
//   requestItem R
//     where Ctx.GetCode(R) is not null
//       and exists ((Ctx.GetCode(R).coding) c 
//         where c in "Routine Procedure Valueset"
//       )