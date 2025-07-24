library ASLPCrdGenericResponseLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include CrdExtendedCoverageInfo called ECI
include FHIRHelpers version '4.1.000'

parameter "Request Id" System.String

// NutritionOrder, ServiceRequest, DeviceRequest, MedicationRequest, VisionPrescription with /draft/ status
parameter "draftOrders" List<Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>>

context Patient

define "DebuggingEnabled": 
  false

define "Service Request Item List":
  "draftOrders"

define "UnknownResourceType":
  'UnknownResourceType'
        
// CRD Matrix of values
// Duplicated the minimum necessary for CRD-7 from ASLPCrdMultipleRequestLogic
// Refactored DetailText, DetailQualification to remove dependency on ASLPCrdRoutineLogic
define function "CRD Matrix"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  {
    "CRD-7": { 
      "ID": 'CRD-7',
      "Covered": 'covered', 
      "PriorAuthNeeded": 'no-auth', 
      "DetailCode": 'no-auth', 
      "DetailText": 'Prior Authorization Not Required', 
      "DetailQualification": 'Order is covered. No prior auth is required for ' + "Service Request Item Code"(requestItem).display + '.',
      "DetailDebugging": 'Not yet implemented.',
      "DetailValue": 'info'
    }
  }

define "null Service Request Item":
  null as Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>

// CRD Static text
define "Title":
  'Prior Auth Evaluation'

// CRD Static text
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'
  
define "CoverageExtensionList":
  if "Service Request Item List" is null then
    { 
      "GetCoverageExtension"(
        "null Service Request Item", 
        GetCrdResult("null Service Request Item")
      ) 
    }
  else
    "Service Request Item List" RequestItem
      return all
        "GetCoverageExtension"(RequestItem, GetCrdResult(RequestItem))

// CRD Logic tree
define function GetCrdResult(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>)
returns Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailDebugging" System.String, "DetailValue" System.String}:
  // Always just return CRD-7 response
  "CRD Matrix"(requestItem)."CRD-7"

define function "GetCoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>, item Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailDebugging" System.String, "DetailValue" System.String})
returns FHIR.Extension:
  "ExtensionPriorAuthNeeded"(
    requestItem,
    item."Covered", 
    item."PriorAuthNeeded", 
    item."DetailCode", 
    item."DetailText", 
    item."DetailQualification",
    item."DetailValue"
  )
define function ExtensionPriorAuthNeeded(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>, covered System.String, priorAuthRequired System.String, codeValue System.String, detailText System.String, qualification System.String, warningOrInfo System.String)
returns FHIR.Extension:
  ECI.ExtensionPriorAuthNeeded('ProviderIdValue', covered, priorAuthRequired, "Request Id", "Service Request Item ID"(requestItem), "Service Request Item Code"(requestItem), codeValue, detailText, qualification, warningOrInfo)

define function "Service Request Item ID"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  GetResourceType(requestItem) + '/' + requestItem.id.value

define function "GetResourceType"(resource Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>)
returns System.String:
  if (resource is FHIR.ServiceRequest) then
    'ServiceRequest'
  else if (resource is FHIR.NutritionOrder) then
    'NutritionOrder'
  else if (resource is FHIR.DeviceRequest) then
    'DeviceRequest'
  else if (resource is FHIR.VisionPrescription) then
    'VisionPrescription'
  else if (resource is FHIR.MedicationRequest) then
    'MedicationRequest'
  else if (resource is FHIR.CommunicationRequest) then
    'CommunicationRequest'
  else
    "UnknownResourceType"

define function "Service Request Item Code"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  if (requestItem is FHIR.CommunicationRequest) then 
    FHIRHelpers.ToCode(singleton from GetCodeableConceptForCommunicationRequest(requestItem).coding)
  else 
    FHIRHelpers.ToCode(singleton from GetCode(requestItem).coding)

define function GetCodeableConceptForCommunicationRequest(cr FHIR.CommunicationRequest):
  if exists (cr.payload p
    where not IsNull(p.content)
    // where not IsNull(p.contentString)
      // or not IsNull(p.contentAttachment)
      // or not IsNull(p.contentReference)
  ) then
    FHIR.CodeableConcept {
      coding: {
        FHIR.Coding {
          system: FHIR.uri { value: 'http://example.org/fhir/payload-content' },
          code: FHIR.code { value: CommunicationPayloadValue(cr) }
        }
      },
      text: FHIR.string { value: CommunicationPayloadValue(cr) }
    }
  else null as FHIR.CodeableConcept

define function CommunicationPayloadValue(cr FHIR.CommunicationRequest):
  if exists(cr.payload p) then
    First(cr.payload p where not IsNull(p.content)).content as FHIR.string
  else null

define function GetCode(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>)
returns FHIR.CodeableConcept:
  if (item is FHIR.ServiceRequest) then
    (item as FHIR.ServiceRequest).code
  else if (item is FHIR.DeviceRequest) then
    if (item as FHIR.DeviceRequest).code is FHIR.CodeableConcept then
      (item as FHIR.DeviceRequest).code as FHIR.CodeableConcept
    else if (item as FHIR.DeviceRequest).code is FHIR.Reference then
      ([Device: id ~ ((item as FHIR.DeviceRequest).code as FHIR.Reference).reference]).type
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.NutritionOrder) then
    (item as FHIR.NutritionOrder).enteralFormula.baseFormulaType
  else null as FHIR.CodeableConcept