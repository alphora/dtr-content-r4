library ASLPCrdNCQADemo version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include ASLPContext version '0.1.0' called Ctx
include ASLPCrdOnPriorAuthListLogic version '0.1.0' called PriorAuthList
include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

context Patient

define "DebuggingEnabled": 
  false
        
// CRD Matrix of values
define function "CRD Matrix"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment>):
    {
      "CRD-5": { 
      "ID": 'CRD-5',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": PriorAuthList."Detail Text", 
      "DetailQualification": PriorAuthList."Qualification"(requestItem),
      "DetailDebugging": if "DebuggingEnabled" then PriorAuthList."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    }
  }

// CRD Static text
define "Title":
  'Prior Auth Evaluation'

// CRD Static text
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

define "null Service Request Item":
  null as Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment>

// CRD Coverage Extensions
define "CoverageExtensionList":
  if ((Ctx."Service Request Item List" is null 
    or not exists (Ctx."Service Request Item List"))) then
        { 
          "GetCoverageExtension"(
            "null Service Request Item", 
            GetCrdResult("null Service Request Item")
          ) 
        }
  else 
     Ctx."Service Request Item List" request
      return all
        "GetCoverageExtension"(request, GetCrdResult(request))

// CRD Logic tree
define function GetCrdResult(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment>):
// returns Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailDebugging" System.String, "DetailValue" System.String}:
    "CRD Matrix"(requestItem)."CRD-5"

define function "GetCoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment>, item Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailDebugging" System.String, "DetailValue" System.String})
returns FHIR.Extension:
  Ctx."ExtensionPriorAuthNeeded"(
    requestItem,
    item."Covered", 
    item."PriorAuthNeeded", 
    item."DetailCode", 
    item."DetailText", 
    if "DebuggingEnabled" then item."DetailQualification" + Ctx.NewLine + '--- DEBUGGING ---' + Ctx.NewLine + item."DetailDebugging" else item."DetailQualification",
    item."DetailValue"
  )