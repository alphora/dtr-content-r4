library ASLPContext version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1' called FHIRHelpers 
include CrdExtendedCoverageInfo version '0.1.0' called ECI
include ASLPContextProvider version '0.1.0' called ContextProvider
include ASLPContextPayor version '0.1.0' called ContextPayor

codesystem "Relationship Role": 'http://terminology.hl7.org/CodeSystem/v3-RoleCode'
codesystem "Payor Identifier CodeSystem": 'http://terminology.hl7.org/CodeSystem/organization-type'

code "Payor Code": 'pay' from "Payor Identifier CodeSystem" display 'Payor'
code "Relationship Self Code": 'ONESELF' from "Relationship Role" display 'Self'

// NutritionOrder, ServiceRequest, DeviceRequest, MedicationRequest, VisionPrescription with /draft/ status
parameter "draftOrders" List<Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Task>>
parameter "selections" List<System.String> 
parameter "dispatchedOrders" List<System.String>
parameter "fulfillmentTasks" List<FHIR.Task>
parameter "appointments" List<FHIR.Appointment>
parameter "Request Id" System.String
  // NOTE: defaults should not be used in production
  //default 'generated-id-default-value'

context Patient

define "NewLine":
  '\r\n'

// define "UnknownResourceType":
//   'UnknownResourceType'

define "UnsupportedResourceTypes":
  { 'VisionPrescription' }

define "Provider Coverage":
  // NOTE: per PA team, the Coverage is just the first matching coverage
  //       - at some point we may return a "ambiguous data" response if there is > 1 Coverage
  First(
    [Coverage] item where IsPayorResource(item) = false
  )

define function "Service Request Item Code"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  if (requestItem is FHIR.CommunicationRequest) then 
    FHIRHelpers.ToCode(singleton from GetCodeableConceptForCommunicationRequest(requestItem).coding)
  else 
    FHIRHelpers.ToCode(singleton from GetCode(requestItem).coding)

define function GetCodeableConceptForCommunicationRequest(cr FHIR.CommunicationRequest):
  if exists (cr.payload P
    // where not IsNull(p.contentString)
    // or not IsNull(p.contentAttachment)
    // or not IsNull(p.contentReference)
    where (P.content as FHIR.string) is not null
      or (P.content as FHIR.Attachment) is not null
      or (P.content as FHIR.Reference) is not null
  ) then
    FHIR.CodeableConcept {
      coding: {
        FHIR.Coding {
          system: FHIR.uri { value: 'http://example.org/fhir/payload-content' },
          code: FHIR.code { value: CommunicationPayloadValue(cr) },
          display: FHIR.string { value: CommunicationPayloadValue(cr) }
        }
      },
      text: FHIR.string { value: CommunicationPayloadValue(cr) }
    }
  else null as FHIR.CodeableConcept

define function CommunicationPayloadValue(cr FHIR.CommunicationRequest):
  if exists(cr.payload p) then
    First(cr.payload p where not IsNull(p.content)).content as FHIR.string
  else null

define function "Service Request Item ID"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  // GetResourceType(requestItem) + '/' + requestItem.id.value
  if requestItem is FHIR.ServiceRequest 
    then 'ServiceRequest/' + requestItem.id.value
  else if requestItem is FHIR.DeviceRequest
    then 'DeviceRequest/' + requestItem.id.value
  else if requestItem is FHIR.NutritionOrder
    then 'NutritionOrder/' + requestItem.id.value
  else if requestItem is FHIR.MedicationRequest
    then 'MedicationRequest/' + requestItem.id.value
  else if requestItem is FHIR.VisionPrescription
    then 'VisionPrescription/' + requestItem.id.value
  else if requestItem is FHIR.CommunicationRequest
    then 'CommunicationRequest/' + requestItem.id.value
  else if requestItem is FHIR.Appointment
    then 'Appointment/' + requestItem.id.value
  else if requestItem is FHIR.Task  
    then 'Task/' + requestItem.id.value
  else 'UnknownResource'
  // if GetResourceType(requestItem) = 'ServiceRequest Resource' 
  //   then 'ServiceRequest/' + requestItem.id.value
  // else if GetResourceType(requestItem) = 'NutritionOrder Resource'
  //   then 'NutritionOrder/' + requestItem.id.value
  // else if GetResourceType(requestItem) = 'DeviceRequest Resource'
  //   then 'DeviceRequest/' + requestItem.id.value
  // else if GetResourceType(requestItem) = 'VisionPrescription Resource'
  //   then 'VisionPrescription/' + requestItem.id.value
  // else if GetResourceType(requestItem) = 'MedicationRequest Resource'
  //   then 'MedicationRequest/' + requestItem.id.value
  // else if GetResourceType(requestItem) = 'CommunicationRequest Resource'
  //   then 'CommunicationRequest/' + requestItem.id.value
  // else 'UnknownResource'

define function GetResourceType(r Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
// returns System.String:
  if (r is FHIR.ServiceRequest) then
    'ServiceRequest Resource'
  else if (r is FHIR.NutritionOrder) then
    'NutritionOrder Resource'
  else if (r is FHIR.DeviceRequest) then
    'DeviceRequest Resource'
  else if (r is FHIR.VisionPrescription) then
    'VisionPrescription Resource'
  else if (r is FHIR.MedicationRequest) then
    'MedicationRequest Resource'
  else if (r is FHIR.CommunicationRequest) then
    'CommunicationRequest Resource'
  else if (r is FHIR.Appointment) then
    'Appointment Resource'
  else if (r is FHIR.Task) then 
    'Task Resource'
  else
    'UnknownResourceType'

define function "System Generated Id"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
  Coalesce(
    (First(
      requestItem.extension E
        where E.url = 'https://smiledigitalhealth.com/priorauth/smile-crd-assertion-id'
        return E
    )).value as FHIR.string,
    "Request Id"
  )

define function ExtensionPriorAuthNeeded(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>, covered System.String, priorAuthRequired System.String, codeValue System.String, detailText System.String, qualification System.String, warningOrInfo System.String)
returns FHIR.Extension:
  ECI.ExtensionPriorAuthNeeded(ContextProvider."Provider Coverage".id.value, covered, priorAuthRequired, "System Generated Id"(requestItem), "Service Request Item ID"(requestItem), "Service Request Item Code"(requestItem), codeValue, detailText, qualification, warningOrInfo)

define function TagExists(resource Resource, value System.Code):
// returns System.Boolean:
  if (exists(resource.meta.tag.system)) then
    AnyTrue(
      resource.meta.tag Tag
        return 
          if Tag.system.value ~ value.system and Tag.code.value ~ value.code then 
            true 
          else 
            false
    )
  else false
  
define function IsPayorResource(resource Resource):
// returns System.Boolean:
  TagExists(resource, "Payor Code")

// define function GetIdentifier(item Choice<FHIR.Practitioner, FHIR.Organization>, url System.String)
// returns System.String:
//   singleton from
//   (
//     item.identifier I
//       where I.system.value ~ url
//       return I.value.value
//   )

define function GetIdentifier(item Choice<FHIR.Practitioner, FHIR.Organization>, url System.String)
returns System.String:
  First(
    item.identifier I
      where I.system.value ~ url
      return I.value.value
  )

define fluent function npi(items List<Choice<FHIR.Practitioner, FHIR.Organization>>)
returns List<System.String>:
  items I
    return GetIdentifier(I, 'http://hl7.org/fhir/sid/us-npi')

define fluent function getNpi(item Choice<FHIR.Practitioner, FHIR.Organization>)
returns System.String:
  GetIdentifier(item, 'http://hl7.org/fhir/sid/us-npi')

// Option 1 (not feasible short-term): Use related context retrieve
// give me the patient that is the beneficiary of this coverage
// even then you'd still have to get to the coverage

// Option 2 (short-term): Consider payor/provider as single source 
// Use a meta.tag approach to distinguish payor/provider
// 1) Need to re-map all references from Payor Patient id to Provider Patient id (Observation, Condition, etc, etc)
// IDEA 1:
// RelatedPerson resource to represent the Payer Patient
// Payor Coverage resource remapped to reference the Provider Patient (just like all other resources: Observation, Condition, etc)

// IDEA 2: downside to this is that patient/coverage matching heuristic won't work in CQL
// Single source expects a merged patient for payor/provider
// Also expects a merged Coverage as well, since Coverage.beneficiary is 1..1 Patient reference

// need a architecture design question on how to solve longer term

define function GetCode(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>)
returns FHIR.CodeableConcept:
  if (item is FHIR.ServiceRequest) then
    if (item as FHIR.ServiceRequest).code is FHIR.CodeableConcept then 
      (item as FHIR.ServiceRequest).code as FHIR.CodeableConcept 
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.DeviceRequest) then
    if (item as FHIR.DeviceRequest).code is FHIR.CodeableConcept then
      (item as FHIR.DeviceRequest).code as FHIR.CodeableConcept
    else if (item as FHIR.DeviceRequest).code is FHIR.Reference then
      ([Device: id ~ ((item as FHIR.DeviceRequest).code as FHIR.Reference).reference]).type
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.NutritionOrder) then
    if (item as FHIR.NutritionOrder).enteralFormula.baseFormulaType is FHIR.CodeableConcept then 
      (item as FHIR.NutritionOrder).enteralFormula.baseFormulaType as FHIR.CodeableConcept
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.MedicationRequest) then 
    if (item as FHIR.MedicationRequest).medication is FHIR.CodeableConcept then
      (item as FHIR.MedicationRequest).medication as FHIR.CodeableConcept
    else if (item as FHIR.MedicationRequest).medication is FHIR.Reference then
      ([MedicationRequest: id ~ ((item as FHIR.MedicationRequest).medication as FHIR.Reference).reference])
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.VisionPrescription) then 
    if (exists ((item as FHIR.VisionPrescription).lensSpecification) LS 
      where exists ((LS.extension) E 
        where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
      )
    ) then 
        First(
          from ((item as FHIR.VisionPrescription).lensSpecification) LS 
          let billingExt: First(
              (LS.extension) E
                where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
                  and E.value is not null
          )
            where billingExt is not null
          return billingExt.value as FHIR.CodeableConcept
        )         
    else if exists ((item as FHIR.VisionPrescription).lensSpecification) LS
      where not exists ((LS.extension) E 
        where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
      ) then
          First(
            from ((item as FHIR.VisionPrescription).lensSpecification) LS 
              where exists ((LS.extension) E 
                where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
              )
              and LS.product is not null
            return 
              LS.product
          )
    else
      null as FHIR.CodeableConcept
  else if (item is FHIR.Appointment) then 
    if exists ((item as FHIR.Appointment).serviceType) then 
      First((item as FHIR.Appointment).serviceType)
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.Task) then 
    (item as FHIR.Task).code
  else null as FHIR.CodeableConcept

define function GetRequester(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>)
returns List<FHIR.Reference>:
  if (item is FHIR.ServiceRequest) then
    ({ (item as FHIR.ServiceRequest).requester }) as List<FHIR.Reference>
  else if (item is FHIR.DeviceRequest) then
    ({ (item as FHIR.DeviceRequest).requester }) as List<FHIR.Reference>
  else if (item is FHIR.NutritionOrder) then
    ({ (item as FHIR.NutritionOrder).orderer }) as List<FHIR.Reference>
  else if (item is FHIR.MedicationRequest) then 
    ({ (item as FHIR.MedicationRequest).requester }) as List<FHIR.Reference>
  else if (item is FHIR.VisionPrescription) then 
    ({ (item as FHIR.VisionPrescription).prescriber }) as List<FHIR.Reference>
  else if (item is FHIR.CommunicationRequest) then
    ({ (item as FHIR.CommunicationRequest).requester }) as List<FHIR.Reference>
  else if (item is FHIR.Appointment) then
    ((item as FHIR.Appointment).participant.actor) as List<FHIR.Reference>
  else if (item is FHIR.Task) then
    ({ (item as FHIR.Task).for }) as List<FHIR.Reference>
  else null as List<FHIR.Reference>

define function GetPerformer(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>)
returns List<FHIR.Reference>:
  if (item is FHIR.ServiceRequest) then
    ((item as FHIR.ServiceRequest).performer) as List<FHIR.Reference>
  else if (item is FHIR.DeviceRequest) then
    if (IsNull((item as FHIR.DeviceRequest).performer)) then null as List<FHIR.Reference>
    else ({ (item as FHIR.DeviceRequest).performer }) as List<FHIR.Reference>
  else if (item is FHIR.NutritionOrder) then
    if (IsNull((item as FHIR.NutritionOrder).orderer)) then null as List<FHIR.Reference>
    else ({ (item as FHIR.NutritionOrder).orderer }) as List<FHIR.Reference>
  else if (item is FHIR.MedicationRequest) then
    if (IsNull((item as FHIR.MedicationRequest).performer)) then null as List<FHIR.Reference>
    else ({ (item as FHIR.MedicationRequest).performer }) as List<FHIR.Reference>
  else if (item is FHIR.VisionPrescription) then
    if (IsNull((item as FHIR.VisionPrescription).prescriber)) then null as List<FHIR.Reference>
    else ({ (item as FHIR.VisionPrescription).prescriber }) as List<FHIR.Reference>
  else if (item is FHIR.CommunicationRequest) then 
    if (IsNull((item as FHIR.CommunicationRequest).sender)) then null as List<FHIR.Reference>
    else ({ (item as FHIR.CommunicationRequest).sender }) as List<FHIR.Reference>
  else if (item is FHIR.Appointment) then
    ((item as FHIR.Appointment).participant.actor) as List<FHIR.Reference>
  else if (item is FHIR.Task) then
    null as List<FHIR.Reference>
  else null as List<FHIR.Reference>

define function GetSubjectID(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>)
returns System.String:
  if (item is FHIR.ServiceRequest) then
    Last(Split(item.subject.reference.value, '/'))
  else if (item is FHIR.VisionPrescription or item is FHIR.NutritionOrder) then
    Last(Split(item.patient.reference.value, '/'))
  else if (item is FHIR.Appointment) then
    Last(Split(First(item.participant).actor.reference.value, '/'))
  else if (item is FHIR.Task) then 
    Last(Split(item.for.reference.value, '/'))
  else Last(Split(item.subject.reference.value, '/'))

define function GetOrderReference(
  order Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>
):
  case
    when order is FHIR.ServiceRequest then 'ServiceRequest/' + order.id.value
    when order is FHIR.DeviceRequest then 'DeviceRequest/' + order.id.value
    when order is FHIR.MedicationRequest then 'MedicationRequest/' + order.id.value
    when order is FHIR.NutritionOrder then 'NutritionOrder/' + order.id.value
    when order is FHIR.VisionPrescription then 'VisionPrescription/' + order.id.value
    when order is FHIR.CommunicationRequest then 'CommunicationRequest/' + order.id.value
    else null
  end
  
define function ToRefString(r Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Task>):
  case
    when r is FHIR.MedicationRequest then 'MedicationRequest/' + (r as FHIR.MedicationRequest).id.value
    when r is FHIR.NutritionOrder then 'NutritionOrder/' + (r as FHIR.NutritionOrder).id.value
    when r is FHIR.ServiceRequest then 'ServiceRequest/' + (r as FHIR.ServiceRequest).id.value
    when r is FHIR.DeviceRequest then 'DeviceRequest/' + (r as FHIR.DeviceRequest).id.value
    when r is FHIR.VisionPrescription then 'VisionPrescription/' + (r as FHIR.VisionPrescription).id.value
    when r is FHIR.CommunicationRequest then 'CommunicationRequest/' + (r as FHIR.CommunicationRequest).id.value
    when r is FHIR.Task then 'Task/' + (r as FHIR.Task).id.value
    else null
  end

define function GetOrderFromDraftOrders(list List<System.String>):
  "Service Request Item List" S 
    where exists ((list) L
      where Split(L, '/').last() = S.id.value
    )

define function TaskReferencesDispatchedOrder(T FHIR.Task):
  exists (("Dispatched Orders List") D
    where 
      (T.focus is not null 
        and Split(FHIRHelpers.ToString(T.focus.reference), '/').last() = D.id.value
      )
      or exists ((T.basedOn) B 
        where Split(FHIRHelpers.ToString(B.reference), '/').last() = D.id.value
      )
  )

define "Selections Orders List":
  if (exists "selections") then
    GetOrderFromDraftOrders("selections")
  else 
    "Service Request Item List"

define "Dispatched Orders List": 
  if (exists "dispatchedOrders") then
    GetOrderFromDraftOrders("dispatchedOrders")
  else 
    "Service Request Item List"
    
define "Fulfillment Tasks For Dispatched Orders":
  "fulfillmentTasks" T
    where TaskReferencesDispatchedOrder(T)

define "Service Request Item List":
  "draftOrders"
  // NOTE: these retrieves are only for local testing

define "Appointments List": 
  "appointments"

define "Payor":
  ContextPayor."Payor"

define "Provider":
  ContextProvider."Provider"