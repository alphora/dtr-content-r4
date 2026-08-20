library ASLPCrdMultipleRequestLogic version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include ASLPContext version '0.1.0' called Ctx
include ASLPCrdMemberEligibleLogic version '0.1.0' called MemberEligible
include ASLPCrdOrderLOBMatchLogic version '0.1.0' called OrderLOBMatch
include ASLPCrdProviderNpiMatchLogic version '0.1.0' called NpiMatch
include ASLPCrdOrderGoldStatusLogic version '0.1.0' called GoldCard
include ASLPCrdRoutineLogic version '0.1.0' called Routine
include ASLPCrdOnPriorAuthListLogic version '0.1.0' called PriorAuthList
include ASLPCrdContextValidationLogic version '0.1.0' called ContextValidation
include ASLPCrdEvaluationLogic version '0.1.0' called Evaluation
include QuestionnaireRouter version '0.1.0' called Router
include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

codesystem "AdjudicationOutcomes": 'https://codesystem.x12.org/005010/306' 

valueset "Prior Auth Required for Procedure Valueset": 'http://terminology.smilecdr.com/cs/priorauth'
valueset "Sleep Study Procedure": 'http://terminology.smilecdr.com/cs/sleepstudy'
valueset "Routine Procedure Valueset": 'http://terminology.smilecdr.com/cs/routine'

code "Approved": 'A1' from "AdjudicationOutcomes" display 'Approved'
code "Denied": 'A3' from "AdjudicationOutcomes" display 'Denied'
code "Pended": 'A4' from "AdjudicationOutcomes" display 'Pended'

context Patient

define "DebuggingEnabled": 
  false
        
// CRD Matrix of values
define function "CRD Matrix"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
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
      "DetailQualification": Routine."Detail Qualification",
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
    "CRD-9": { 
      "ID": 'CRD-9',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'conditional', 
      "DetailCode": 'coverage-info', 
      "DetailText": Evaluation."Detail Text 9", 
      "DetailQualification": Evaluation."Qualification 9",
      "DetailDebugging": if "DebuggingEnabled" then Evaluation."Detail Debugging" else 'Debugging disabled',
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
      "DetailValue": 'critical'
    } 
  }

// CRD Static text
define "Title":
  'Prior Auth Evaluation'

// CRD Static text
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

define "null Service Request Item":
  null as Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>

// CRD Coverage Extensions
define "CoverageExtensionList":
  if exists (Ctx."Selections Orders List") then
    Ctx."Selections Orders List" request
      return all
        "GetCoverageExtension"(request, GetCrdResult(request))
        // TESTING OUTPUT
        //(GetCrdResult(RequestItem)).ID + Ctx.NewLine +
        //(GetCrdResult(RequestItem)).DetailDebugging
  else if exists (Ctx."Dispatched Orders List") then
    if exists Ctx."Fulfillment Tasks For Dispatched Orders" then
      Ctx."Fulfillment Tasks For Dispatched Orders" request
        return all
          "GetCoverageExtension"(request, GetCrdResult(request))
          // TESTING OUTPUT
          //(GetCrdResult(RequestItem)).ID + Ctx.NewLine +
          //(GetCrdResult(RequestItem)).DetailDebugging
    else 
      Ctx."Dispatched Orders List" request 
        return all
          "GetCoverageExtension"(request, GetCrdResult(request))
  else if exists (Ctx."Appointments List") then
    Ctx."Appointments List" appointment
      return all 
        "GetCoverageExtension"(appointment, GetCrdResult(appointment))
  else if exists Ctx."Service Request Item List" then 
    Ctx."Service Request Item List" request 
      return all 
        "GetCoverageExtension"(request, GetCrdResult(request))
  else
    "GetCoverageExtension"(
      "null Service Request Item", 
      GetCrdResult("null Service Request Item")
    ) 
    
// CRD Logic tree
define function GetCrdResult(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
// returns Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailDebugging" System.String, "DetailValue" System.String}:
  if (ContextValidation."Insufficient or Ambiguous High"(requestItem)) then
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
  else if (requestItem is FHIR.CommunicationRequest) then
    GetCrdResultCommunicationRequest(requestItem)
  else if (requestItem is FHIR.Appointment) then
    GetCrdResultAppointment(requestItem)
  else if (requestItem is FHIR.MedicationRequest) then
    GetCrdResultMedicationRequest(requestItem)
  else if (not requestItem is FHIR.CommunicationRequest) then
    GetCrdResultOther(requestItem)
  else
    "CRD Matrix"(requestItem)."CRD-UnexpectedError"

define function GetCrdResultCommunicationRequest(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
    "CRD Matrix"(requestItem)."CRD-7"

define function GetCrdResultAppointment(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  if exists (requestItem.basedOn) then 
    if (
      PriorAuthList."Is OnPriorAuthList"(requestItem)
      or exists ((Ctx.GetCode(requestItem).coding) c
        where c in "Sleep Study Procedure"
      )
    ) then 
      "CRD Matrix"(requestItem)."CRD-5"
    else if Routine."Is Routine"(requestItem) then 
      "CRD Matrix"(requestItem)."CRD-7"
    else 
      "CRD Matrix"(requestItem)."CRD-6"  
  // else if exists (requestItem.serviceType) then 
    // if (
    //   PriorAuthList."Is OnPriorAuthList"(requestItem)
    //   or exists ((Ctx.GetCode(requestItem).coding) c
    //     where c in "Sleep Study Procedure"
    //   )
    // ) then
    //   "CRD Matrix"(requestItem)."CRD-5"
    // else if Routine."Is Routine"(requestItem) then 
    //   "CRD Matrix"(requestItem)."CRD-7"
    // else 
    //   "CRD Matrix"(requestItem)."CRD-6"
  else 
    // "CRD Matrix"(requestItem)."CRD-9"
    // "CRD Matrix"(requestItem)."CRD-UnexpectedError"
    "CRD Matrix"(requestItem)."CRD-7"

define function GetCrdResultMedicationRequest(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  if BillingOptionExtensionPresent(requestItem) then 
    if (PriorAuthList."Is OnPriorAuthList"(requestItem)
      or exists ((Ctx.GetCode(requestItem).coding) c 
        where c in "Sleep Study Procedure"
      )
    ) then
      "CRD Matrix"(requestItem)."CRD-5"
    else if (Routine."Is Routine"(requestItem)) then 
      "CRD Matrix"(requestItem)."CRD-7"
    else 
      "CRD Matrix"(requestItem)."CRD-6"
  else if (((requestItem.medication as FHIR.CodeableConcept) is not null) or ((requestItem.medication as FHIR.Reference) is not null)) then
    if (PriorAuthList."Is OnPriorAuthList"(requestItem)
      or exists ((Ctx.GetCode(requestItem).coding) c 
        where c in "Sleep Study Procedure"
      )
    ) then
        if not exists (OrderLOBMatch."Matching Organizations by Name") 
        or OrderLOBMatch."Matching Organizations by Name" is null then 
          "CRD Matrix"(requestItem)."CRD-3.2"
        else 
          "CRD Matrix"(requestItem)."CRD-5"
    else if (
      PriorAuthList."Not OnPriorAuthList"(requestItem)
      or exists ((Ctx.GetCode(requestItem).coding) c 
        where not (c in "Sleep Study Procedure")
      )
    ) then 
      "CRD Matrix"(requestItem)."CRD-6"
          // if not exists (OrderLOBMatch."Matching Organizations by Name") 
          // or OrderLOBMatch."Matching Organizations by Name" is null then 
          //   "CRD Matrix"(requestItem)."CRD-3.2"
          // else "CRD Matrix"(requestItem)."CRD-6"
    else if (Routine."Is Routine"(requestItem)) then 
      "CRD Matrix"(requestItem)."CRD-7"
    else 
      "CRD Matrix"(requestItem)."CRD-6"
  else 
    "CRD Matrix"(requestItem)."CRD-6"
    // "CRD Matrix"(requestItem)."CRD-UnexpectedError"

define function hasBillingExtension(exts List<FHIR.Extension>) returns System.Boolean:
  exists(
    exts E 
      where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
  )

define function BillingOptionExtensionPresent(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  if requestItem is FHIR.MedicationRequest then 
    ((requestItem as FHIR.MedicationRequest).medication) is FHIR.CodeableConcept
    and hasBillingExtension(((requestItem as FHIR.MedicationRequest).medication as FHIR.CodeableConcept).extension)
  else if requestItem is FHIR.VisionPrescription then 
    exists (((requestItem as FHIR.VisionPrescription).lensSpecification) LS 
      where hasBillingExtension(LS.extension)
    )
  else if requestItem is FHIR.ServiceRequest then 
    hasBillingExtension((requestItem as FHIR.ServiceRequest).extension)
  else if requestItem is FHIR.NutritionOrder then 
    hasBillingExtension((requestItem as FHIR.NutritionOrder).oralDiet.extension)
    or hasBillingExtension((requestItem as FHIR.NutritionOrder).enteralFormula.extension)
    or exists (
      ((requestItem as FHIR.NutritionOrder).supplement) S
        where hasBillingExtension(S.extension)
    )
  else if requestItem is FHIR.DeviceRequest then
    hasBillingExtension((requestItem as FHIR.DeviceRequest).extension)
  else if requestItem is FHIR.CommunicationRequest then 
    hasBillingExtension((requestItem as FHIR.CommunicationRequest).extension)
    or exists (((requestItem as FHIR.CommunicationRequest).payload) P
      where hasBillingExtension(P.extension)
    )
  else if requestItem is FHIR.Appointment then 
    hasBillingExtension((requestItem as FHIR.Appointment).extension)
  else if requestItem is FHIR.Task then 
    hasBillingExtension((requestItem as FHIR.Task).extension)
    or exists (((requestItem as FHIR.Task).input) I
      where hasBillingExtension(I.extension)
    )
  else null

define function GetCrdResultOther(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  if (PriorAuthList."Is OnPriorAuthList"(requestItem)) then
    if not exists (OrderLOBMatch."Matching Organizations by Name") 
    or OrderLOBMatch."Matching Organizations by Name" is null then 
      "CRD Matrix"(requestItem)."CRD-3.2"
    else "CRD Matrix"(requestItem)."CRD-5"
  else if (PriorAuthList."Not OnPriorAuthList"(requestItem)) then
    "CRD Matrix"(requestItem)."CRD-6"
  else
    "CRD Matrix"(requestItem)."CRD-UnexpectedError"

define function "GetCoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>, item Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailDebugging" System.String, "DetailValue" System.String})
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

//Questionnaire elements
define "PriorAuthSubmissionRequisite":
  exists (
    "CoverageExtensionList" ExtList
      where exists (ExtList.extension E
          where E.url.value = 'pa-needed'
            and (
              E.value.value = 'auth-needed' 
              or E.value.value = 'conditional'
            )
      )
  )

//Created by Claude 3.7 Sonnet
define "AdjudicationOutcome":
  GetAdjudicationOutcome(First("CoverageExtensionList"))
  // from "CoverageExtensionList" ExtList
  // return GetAdjudicationOutcome(ExtList)

define "AdjudicationRationale":
  GetAdjudicationRationale(First("CoverageExtensionList"))
  // from "CoverageExtensionList" ExtList
  // return GetAdjudicationRationale(ExtList)

define "AdjudicationReasonCodes":
  GetAdjudicationReasonCodes(First("CoverageExtensionList"))
  // from "CoverageExtensionList" ExtList
  // return GetAdjudicationReasonCodes(ExtList)

define "QuestionnaireExtensionForTask":
  if First("CoverageExtensionList") is null then 
      null 
  else if IsConditionalPended(First("CoverageExtensionList")) then 
    FHIR.Extension {
      "url": FHIR.uri { "value": 'http://hl7.org/fhir/StructureDefinition/task-input-type' },
      "extension": ( {
        FHIR.Extension {
          "url": FHIR.uri { "value": 'questionnaire documentation' },
          "extension": ( {
            FHIR.Extension {
              "url": FHIR.uri { "value": 'code' },
              "value": FHIR.CodeableConcept {
                  "coding": {
                    FHIR.Coding {
                      "system": FHIR.uri { "value": 'http://loinc.org' },
                      "code": FHIR.code { "value": '102089-0' },
                      "display": FHIR.string { 
                        "value": 'Documentation request from payers and providers' 
                      }
                    }
                  }
              }
            },
            FHIR.Extension {
              "url": FHIR.uri { "value": 'questionnaire' },
              "value": FHIR.canonical { "value": 'http://example.org/sdh/dtr/aslp/Questionnaire/ASLPCrd-MultipleRequest' }
            }
          } )
        },
        FHIR.Extension {
          "url": FHIR.uri { "value": 'attachment-documentation' },
          "extension": ( {
            FHIR.Extension {
              "url": FHIR.uri { "value": 'code' },
              "value": FHIR.CodeableConcept {
                  "coding": {
                    FHIR.Coding {
                      "system": FHIR.uri { "value": 'http://loinc.org' },
                      "code": FHIR.code { "value": '11506-3' },
                      "display": FHIR.string { 
                        "value": 'Progress notes' 
                      }
                    }
                  }
              }
            }
          } )
        }
      } )
    }
  else 
    null

define function GetOrderReference(extension FHIR.Extension):
  First(
    from extension.extension E 
    where E.url = 'dependency'
    return (E.value as FHIR.Reference).reference
  )
    
define function GetAdjudicationOutcome(extension FHIR.Extension):
  if extension is null then
    null 
  else if IsApproved(extension) then
    FHIR.CodeableConcept {
      coding: { 
        FHIR.Coding {
          system: FHIR.uri { value: 'https://codesystem.x12.org/005010/306' },
          code: FHIR.code { value: 'A1' },
          display: FHIR.string { value: 'Approved' }
        }
      }
    }
  else if IsDenied(extension) then 
    FHIR.CodeableConcept {
      coding: {
        FHIR.Coding {
          system: FHIR.uri { value: 'https://codesystem.x12.org/005010/306' },
          code: FHIR.code { value: 'A3' },
          display: FHIR.string { value: 'Denied' }
        }
      }
    }
  else if IsConditionalApproved(extension) then 
    FHIR.CodeableConcept {
      coding: { 
        FHIR.Coding {
          system: FHIR.uri { value: 'https://codesystem.x12.org/005010/306' },
          code: FHIR.code { value: 'A1' },
          display: FHIR.string { value: 'Approved' }
        }
      }
    }
  else if IsConditionalDenied(extension) then 
    FHIR.CodeableConcept {
      coding: {
        FHIR.Coding {
          system: FHIR.uri { value: 'https://codesystem.x12.org/005010/306' },
          code: FHIR.code { value: 'A3' },
          display: FHIR.string { value: 'Denied' }
        }
      }
    }
  else
    FHIR.CodeableConcept {
      coding: {
        FHIR.Coding {
          system: FHIR.uri { value: 'https://codesystem.x12.org/005010/306' },
          code: FHIR.code { value: 'A4' },
          display: FHIR.string { value: 'Pended' }
        }
      }
    }

define function GetAdjudicationRationale(extension FHIR.Extension):
  if extension is null then 
    null 
  else if IsDenied(extension) then
    FHIR.CodeableConcept {
      text: FHIR.string { value: 'Service is not covered under the current benefit plan' }
    }
  else if IsApproved(extension) then
    FHIR.CodeableConcept {
      text: FHIR.string { value: 'Service has been approved for coverage' }
    }
  else if IsConditionalPended(extension) then
    FHIR.CodeableConcept {
      text: FHIR.string { value: 'Additional patient clinical information is required to complete prior authorization review' }
    }
  else if IsConditionalApproved(extension) then 
    FHIR.CodeableConcept {
      text: FHIR.string { value: 'Service has been approved for coverage' }
    }
  else if IsConditionalDenied(extension) then 
    FHIR.CodeableConcept {
      text: FHIR.string { value: 'Service is not covered under the current benefit plan' }
    }
  else null

define function GetAdjudicationReasonCodes(extension FHIR.Extension):
  if extension is null then 
    null 
  else if IsDenied(extension) then
    {
      FHIR.CodeableConcept {
        coding: {
          FHIR.Coding {
            system: FHIR.uri { value: 'https://codesystem.x12.org/external/886' },
            code: FHIR.code { value: '0M' },
            display: FHIR.string { value: 'Non-covered Service' }
          }
        }
      }
    }
  else if IsApproved(extension) then
    {
      FHIR.CodeableConcept {
        coding: {
          FHIR.Coding {
            system: FHIR.uri { value: 'https://codesystem.x12.org/external/886' },
            code: FHIR.code { value: '0N' },
            display: FHIR.string { value: 'Covered Service' }
          }
        }
      }
    }
  else if IsConditionalPended(extension) then
    {
      FHIR.CodeableConcept {
        coding: {
          FHIR.Coding {
            system: FHIR.uri { value: 'https://codesystem.x12.org/external/886' },
            code: FHIR.code { value: '0U' },
            display: FHIR.string { value: 'Additional Patient Information Required' }
          }
        }
      }
    }
  else if IsConditionalApproved(extension) then 
    {
      FHIR.CodeableConcept {
        coding: {
          FHIR.Coding {
            system: FHIR.uri { value: 'https://codesystem.x12.org/external/886' },
            code: FHIR.code { value: '0N' },
            display: FHIR.string { value: 'Covered Service' }
          }
        }
      }
    }
  else if IsConditionalDenied(extension) then 
    {
      FHIR.CodeableConcept {
        coding: {
          FHIR.Coding {
            system: FHIR.uri { value: 'https://codesystem.x12.org/external/886' },
            code: FHIR.code { value: '0M' },
            display: FHIR.string { value: 'Non-covered Service' }
          }
        }
      }
    }
  else 
    null 

define function IsApproved(extension FHIR.Extension):
  if extension is null then 
    null 
  else exists (
    extension.extension E
    where E.url.value = 'covered' 
      and E.value.value = 'covered'
  )

define function IsDenied(extension FHIR.Extension):
  if extension is null then 
    null 
  else exists (
    extension.extension E
    where E.url.value = 'covered' 
      and E.value.value = 'not-covered'
  )

define function IsConditionalPended(extension FHIR.Extension):
  if extension is null then 
    null 
  else 
    exists (
      extension.extension E
      where E.url.value = 'covered' 
        and E.value.value = 'conditional'
    )
    and not exists ([QuestionnaireResponse])

define function IsConditionalApproved(extension FHIR.Extension):
  if extension is null then 
    null 
  else 
    exists (
      extension.extension E
      where E.url.value = 'covered' 
        and E.value.value = 'conditional'
    )
    and exists (([QuestionnaireResponse]) QR
      where exists ((QR.item) I
        where I.definition is not null 
        and I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-physicianevaluated-screening-casefeature'
        and exists ((I.item) i 
          where exists ((i.answer) a 
            where a.value = true
          )
        )
      )
    )

define function IsConditionalDenied(extension FHIR.Extension):
  if extension is null then 
    null 
  else 
    exists (
      extension.extension E
      where E.url.value = 'covered' 
        and E.value.value = 'conditional'
    )
    and exists (([QuestionnaireResponse]) QR
      where exists ((QR.item) I
        where I.definition is not null 
        and (
          (
            I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-patientage-casefeature-definition'
            and exists ((I.item) i 
              where exists ((i.answer) a 
                where a.value = false
              )
            )
          )
          or (
            (
              I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-ess-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = false
                )
              )
            ) 
            and (
              I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-sleepydriving-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = false
                )
              )
            ) 
            and (
              I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-loudsnoring-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = false
                )
              )
            ) 
            and (
              I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-apnea-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = false
                )
              )
            ) 
          )
          or (
            (
              I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-moderatetoseverepulmonarydisease-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = true
                )
              )
            )
            or 
            (
              I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscularwithpulmonary-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = true
                )
              )
            )
            or
            (
              I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = true
                )
              )
            )
          )
          or (
            I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-qualifieddevice-screening-casefeatur'
            and exists ((I.item) i 
              where exists ((i.answer) a 
                where a.value = false
              )
            )
          )
          or (
            I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-safehomeuse-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = false
                )
              )
          )
          or (
            I.definition = 'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-physicianevaluated-screening-casefeature'
              and exists ((I.item) i 
                where exists ((i.answer) a 
                  where a.value = false
                )
              )
          )
        )
      )
    )