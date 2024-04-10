library ASLPCrdOnPriorAuthListLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

valueset "Prior Auth Required for Procedure Valueset": 'http://terminology.smilecdr.com/cs/priorauth'
valueset "Prior Auth Required for Procedure Grouper": 'http://terminology.smilecdr.com/cs/priorauth-grouper'

context Patient

// CRD-6
define "Title-NotFound":
  "Title"
  
// CRD-6
define "Description-NotFound":
  "Description"

// CRD-6
define function "Qualification-NotFound"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  Ctx."Service Request Item Code"(requestItem).display + ' is not a recognized procedure electronically. Please contact the payer for further information.'
  
// CRD-6
define "Detail Text-NotFound":
  'Code Not Found'

// CRD-6
define function "CoverageExtension-NotFound"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'not-covered', 'conditional', 'not-covered', "Detail Text-NotFound", "Qualification-NotFound"(requestItem), 'Warning')

// CRD-5
define "Title":
  'Prior Auth Evaluation'

// CRD-5
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission' 

// CRD-5
define "Detail Text":
  'Prior Authorization Required'

// CRD-5
define function "Qualification"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  'Prior authorization is required for ' + Ctx."Service Request Item Code"(requestItem).display

// CRD-5
define "Detail Debugging":
  'Not yet implemented.'

// CRD-5
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'conditional', 'auth-needed', 'auth-needed', "Detail Text", "Qualification"(requestItem), 'Warning')

define function "Is OnPriorAuthList"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  exists(("Prior Auth Required Service Requests"(requestItem)))

define function "Not OnPriorAuthList"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  not (("Is OnPriorAuthList"(requestItem)))

define function "Prior Auth Required Service Requests"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  ({ requestItem }) R
    where (Ctx.GetCode(R)) in "Prior Auth Required for Procedure Grouper"