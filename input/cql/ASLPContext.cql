library ASLPContext

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include USCoreCommon
include FHIRHelpers version '4.1.000'
include CrdExtendedCoverageInfo called ECI

codesystem "Relationship Role": 'http://terminology.hl7.org/CodeSystem/v3-RoleCode'
codesystem "Payor Identifier CodeSystem": 'http://terminology.hl7.org/CodeSystem/organization-type'

code "Payor Code": 'pay' from "Payor Identifier CodeSystem" display 'Payor'
code "Relationship Self Code": 'ONESELF' from "Relationship Role" display 'Self'

// NutritionOrder, ServiceRequest, DeviceRequest, MedicationRequest, VisionPrescription with /draft/ status
parameter "draftOrders" List<Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>>

parameter "Request Id" System.String
  // NOTE: defaults should not be used in production
  //default 'generated-id-default-value'

// TODO: separate this into different parameters
// parameter "Payor Patient" FHIR.Patient
// parameter "Payor Coverages" List<FHIR.Coverage>
// parameter "Payor Practitioners" List<FHIR.Practitioner>
// parameter "Payor PractitionerRoles" List<FHIR.PractitionerRole>
// parameter "Payor Organizations" List<FHIR.Organization>
parameter "Payor Context" FHIR.Bundle
  // NOTE: defaults should not be used in production
  /*
  default FHIR.Bundle {
    "id": FHIR.id { "value": 'abc' },
    "entry": {
      FHIR.Bundle.Entry {
        "resource": FHIR.Patient {
          "name": {
            FHIR.HumanName {
              "family": FHIR.string { "value": 'Chalmers' }
            }
          },
          "birthDate": FHIR.date { "value": @1974-12-25 }
        }
      }
    }
  }
  */

context Patient

define "NewLine":
  '\r\n'

define "UnknownResourceType":
  'UnknownResourceType'

define "UnsupportedResourceTypes":
  { 'VisionPrescription' }

define "Provider Coverage":
  // NOTE: per PA team, the Coverage is just the first matching coverage
  //       - at some point we may return a "ambiguous data" response if there is > 1 Coverage
  First(
    [Coverage] item where IsPayorResource(item) = false
  )

define function "Service Request Item Code"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  FHIRHelpers.ToCode(singleton from GetCode(requestItem).coding)

define function "Service Request Item ID"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  GetResourceType(requestItem) + '/' + requestItem.id.value

define function "GetResourceType"(resource Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
// returns System.String:
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

define function "System Generated Id"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest>):
  Coalesce(
    (First(
      requestItem.extension E
        where E.url = 'https://smiledigitalhealth.com/priorauth/smile-crd-assertion-id'
        return E
    )).value as FHIR.string,
    "Request Id"
  )

define function ExtensionPriorAuthNotNeeded(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>, covered System.String, priorAuthRequired System.String, codeValue System.String, detailText System.String, qualification System.String, warningOrInfo System.String):
// returns FHIR.Extension:
  ECI.ExtensionPriorAuthNotNeeded("Provider Coverage".id.value, covered, priorAuthRequired, "System Generated Id"(requestItem), "Service Request Item ID"(requestItem), "Service Request Item Code"(requestItem), codeValue, detailText, qualification, warningOrInfo)

define function ExtensionPriorAuthNeeded(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>, covered System.String, priorAuthRequired System.String, codeValue System.String, detailText System.String, qualification System.String, warningOrInfo System.String):
// returns FHIR.Extension:
  ECI.ExtensionPriorAuthNeeded("Provider Coverage".id.value, covered, priorAuthRequired, "System Generated Id"(requestItem), "Service Request Item ID"(requestItem), "Service Request Item Code"(requestItem), codeValue, detailText, qualification, warningOrInfo)

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

define function GetIdentifier(item Choice<Practitioner, Organization>, url System.String):
// returns System.String:
  singleton from
  (
    item.identifier I
      where I.system.value ~ url
      return I.value.value
  )

define fluent function npi(items List<Choice<Practitioner, Organization>>):
// returns List<System.String>:
  items I
    return GetIdentifier(I, 'http://hl7.org/fhir/sid/us-npi')

define fluent function getNpi(item Choice<Practitioner, Organization>):
// returns System.String:
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

define function GetCode(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription>):
// returns FHIR.CodeableConcept:
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
  else if (item is FHIR.MedicationRequest) then
    if (item as FHIR.MedicationRequest).medication is FHIR.CodeableConcept then
      (item as FHIR.MedicationRequest).medication as FHIR.CodeableConcept
    else if (item as FHIR.MedicationRequest).medication is FHIR.Reference then
      ([Medication: id ~ ((item as FHIR.MedicationRequest).medication as FHIR.Reference).reference]).code
    else 
      null as FHIR.CodeableConcept
  // else if (item is FHIR.CommunicationRequest) then
  //   (item as FHIR.CommunicationRequest).payload.contentString
  else null as FHIR.CodeableConcept

define function GetRequester(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
// returns List<FHIR.Reference>:
  if (item is FHIR.ServiceRequest) then
    ({ (item as FHIR.ServiceRequest).requester }) as List<FHIR.Reference>
  else if (item is FHIR.DeviceRequest) then
    ({ (item as FHIR.DeviceRequest).requester }) as List<FHIR.Reference>
  else if (item is FHIR.NutritionOrder) then
    ({ (item as FHIR.NutritionOrder).orderer }) as List<FHIR.Reference>
  else null as List<FHIR.Reference>

define function GetPerformer(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
// returns List<FHIR.Reference>:
  if (item is FHIR.ServiceRequest) then
    ((item as FHIR.ServiceRequest).performer) as List<FHIR.Reference>
  else if (item is FHIR.DeviceRequest) then
    if (IsNull((item as FHIR.DeviceRequest).performer)) then null as List<FHIR.Reference>
    else ({ (item as FHIR.DeviceRequest).performer }) as List<FHIR.Reference>
  else if (item is FHIR.NutritionOrder) then
    if (IsNull((item as FHIR.NutritionOrder).orderer)) then null as List<FHIR.Reference>
    else ({ (item as FHIR.NutritionOrder).orderer }) as List<FHIR.Reference>
  else null as List<FHIR.Reference>

define function GetSubjectID(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
// returns System.String:
  if (item is FHIR.VisionPrescription or item is FHIR.NutritionOrder) then
    item.patient.reference.getId()
  else item.subject.reference.getId()
  

define "Service Request Item List":
  "draftOrders"
  // NOTE: these retrieves are only for local testing
  // ([ServiceRequest]) 
  // union ([DeviceRequest]) 
  // union ([NutritionOrder])
  // union ([MedicationRequest])
  // union ([CommunicationRequest])

define "Provider":
  {
    "Patient": "Provider Patient",
    "Coverages": { "Provider Coverage" },
    "Practitioners": [Practitioner] item where IsPayorResource(item) = false,
    "PractitionerRoles": [PractitionerRole] item where IsPayorResource(item) = false,
    "Organizations": [Organization] item where IsPayorResource(item) = false
  }

define "Payor":
  if (Count("Payor Context".entry) >= 1) then 
    {
      "Patient": First(("Payor Context".entry.resource PayorResource return if (PayorResource is Patient) then PayorResource as FHIR.Patient else null as FHIR.Patient) I where I is not null),
      "Coverages": ("Payor Context".entry.resource PayorResource return if (PayorResource is Coverage) then PayorResource as FHIR.Coverage else null as FHIR.Coverage) I where I is not null,
      "Practitioners": ("Payor Context".entry.resource PayorResource return if (PayorResource is Practitioner) then PayorResource as FHIR.Practitioner else null as FHIR.Practitioner) I where I is not null,
      "PractitionerRoles": ("Payor Context".entry.resource PayorResource return if (PayorResource is PractitionerRole) then PayorResource as FHIR.PractitionerRole else null as FHIR.PractitionerRole) I where I is not null,
      "Organizations": ("Payor Context".entry.resource PayorResource return if (PayorResource is Organization) then PayorResource as FHIR.Organization else null as FHIR.Organization) I where I is not null
    }
  // This section is only for local CQL vs code plugin testing
  else
    {
      "Patient": "Payor Patient",
      "Coverages": [Coverage] item where IsPayorResource(item) = true,
      "Practitioners": [Practitioner] item where IsPayorResource(item) = true,
      "PractitionerRoles": [PractitionerRole] item where IsPayorResource(item) = true,
      "Organizations": [Organization] item where IsPayorResource(item) = true
    }

define "Provider Patient":
  First([Patient] P where not IsPayorResource(P))

define "Payor Patient":
  First(
    [RelatedPerson] RP
      where 
        IsPayorResource(RP)
  )