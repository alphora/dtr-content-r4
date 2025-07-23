library ASLPCrdMultipleRequestLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include ASLPCrdMemberEligibleLogic called MemberEligible
include ASLPCrdOrderLOBMatchLogic called OrderLOBMatch
include ASLPCrdProviderNpiMatchLogic called NpiMatch
include ASLPCrdOrderGoldStatusLogic called GoldCard
include ASLPCrdRoutineLogic called Routine
include ASLPCrdOnPriorAuthListLogic called PriorAuthList
include ASLPCrdContextValidationLogic called ContextValidation
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

define "DebuggingEnabled": 
  false
        
// CRD Matrix of values
define function "CRD Matrix"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  {
    "CRD-2": {
      "ID": 'CRD-2',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": MemberEligible."Detail Text", 
      "DetailQualification": MemberEligible."Qualification",
      "DetailDebugging": if "DebuggingEnabled" then MemberEligible."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-3.2": { 
      "ID": 'CRD-3.2',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": OrderLOBMatch."Detail Text", 
      "DetailQualification": OrderLOBMatch."Qualification",
      "DetailDebugging": if "DebuggingEnabled" then OrderLOBMatch."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-3.2b": { 
      "ID": 'CRD-3.2b',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": OrderLOBMatch."Detail Text", 
      "DetailQualification": OrderLOBMatch."Qualification",
      "DetailDebugging": if "DebuggingEnabled" then OrderLOBMatch."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-3.1": { 
      "ID": 'CRD-3.1',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": NpiMatch."Detail Text", 
      "DetailQualification": NpiMatch."Qualification",
      "DetailDebugging": if "DebuggingEnabled" then NpiMatch."Detail Debugging"(requestItem) else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-4": { 
      "ID": 'CRD-4',
      "Covered": 'covered', 
      "PriorAuthNeeded": 'no-auth', 
      "DetailCode": 'gold-card', 
      "DetailText": GoldCard."Detail Text", 
      "DetailQualification": GoldCard."Qualification",
      "DetailDebugging": if "DebuggingEnabled" then GoldCard."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'info'
    },
    "CRD-7": { 
      "ID": 'CRD-7',
      "Covered": 'covered', 
      "PriorAuthNeeded": 'no-auth', 
      "DetailCode": 'no-auth', 
      "DetailText": Routine."Detail Text", 
      "DetailQualification": Routine."Qualification"(requestItem),
      "DetailDebugging": if "DebuggingEnabled" then Routine."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'info'
    },
    "CRD-6": { 
      "ID": 'CRD-6',
      "Covered": 'not-covered', 
      "PriorAuthNeeded": 'conditional', 
      "DetailCode": 'not-covered', 
      "DetailText": PriorAuthList."Detail Text-NotFound", 
      "DetailQualification": PriorAuthList."Qualification-NotFound"(requestItem),
      "DetailDebugging": if "DebuggingEnabled" then PriorAuthList."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-5": { 
      "ID": 'CRD-5',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": PriorAuthList."Detail Text", 
      "DetailQualification": PriorAuthList."Qualification"(requestItem),
      "DetailDebugging": if "DebuggingEnabled" then PriorAuthList."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-8": { 
      "ID": 'CRD-8',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": ContextValidation."Detail Text 8", 
      "DetailQualification": ContextValidation."Qualification 8",
      "DetailDebugging": if "DebuggingEnabled" then ContextValidation."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-8.1": { 
      "ID": 'CRD-8.1',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'conditional', 
      "DetailCode": 'coverage-info', 
      "DetailText": ContextValidation."Detail Text 8.1", 
      "DetailQualification": ContextValidation."Qualification 8.1",
      "DetailDebugging": if "DebuggingEnabled" then ContextValidation."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-8.3": { 
      "ID": 'CRD-8.3',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'conditional', 
      "DetailCode": 'coverage-info', 
      "DetailText": ContextValidation."Detail Text 8.3", 
      "DetailQualification": ContextValidation."Qualification 8.3",
      "DetailDebugging": if "DebuggingEnabled" then ContextValidation."Detail Debugging" else 'Debugging disabled',
      "DetailValue": 'Warning'
    },
    "CRD-UnexpectedError": { 
      "ID": 'CRD-UnexpectedError',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'conditional', 
      "DetailCode": 'coverage-info', 
      "DetailText": 'Unexpected result', 
      "DetailQualification": 'Unexpected Prior Authorization result. Please try again or contact support.',
      "DetailDebugging": 'No debugging available',
      "DetailValue": 'error'
    } 
  }

// CRD Static text
define "Title":
  'Prior Auth Evaluation'

// CRD Static text
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

define "null Service Request Item":
  null as Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>

// CRD Coverage Extensions
define "CoverageExtensionList":
  if Ctx."Service Request Item List" is null then
    { 
      "GetCoverageExtension"(
        "null Service Request Item", 
        GetCrdResult("null Service Request Item")
      ) 
    }
  else
    Ctx."Service Request Item List" RequestItem
      return all
        "GetCoverageExtension"(RequestItem, GetCrdResult(RequestItem))
        // TESTING OUTPUT
        //(GetCrdResult(RequestItem)).ID + Ctx.NewLine +
        //(GetCrdResult(RequestItem)).DetailDebugging

// CRD Logic tree
define function GetCrdResult(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
// returns Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailDebugging" System.String, "DetailValue" System.String}:
  if (requestItem is FHIR.CommunicationRequest) then
    "CRD Matrix"(requestItem)."CRD-7"
  else if (ContextValidation."Insufficient or Ambiguous High"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-8"
  else if (ContextValidation."DomainResource is Empty"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-8.1"
  else if (ContextValidation."Received Provider Data Cannot be Processed"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-8.3"
  else if (MemberEligible."Not MemberEligible") then
    "CRD Matrix"(requestItem)."CRD-2"
  else if (NpiMatch."Not ProviderNpiMatch"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-3.1"
  else if (OrderLOBMatch."Not OrderLOBMatch") then
    "CRD Matrix"(requestItem)."CRD-3.2"
  else if (NpiMatch."Not LOBMatch"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-3.2b"
  else if (GoldCard."Is OrderGoldStatus") then
    "CRD Matrix"(requestItem)."CRD-4"
  else if (Routine."Is Routine"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-7"
  else if(PriorAuthList."Is OnPriorAuthList"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-5"
  else if(PriorAuthList."Not OnPriorAuthList"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-6"
  else
    "CRD Matrix"(requestItem)."CRD-UnexpectedError"

define function "GetCoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>, item Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailDebugging" System.String, "DetailValue" System.String})
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