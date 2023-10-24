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

// MedicationRequest, NutritionOrder, ServiceRequest with /draft/ status
parameter "draftOrders" List<Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>>

parameter "Service Request" FHIR.ServiceRequest
parameter "Service Request Id" System.String
  // TODO: remove defaults for production use
  default 'SleepStudy'
  //default { 'required-SleepStudy', 'not-required-SleepStudy', 'SleepStudy', 'SleepStudy2' }
  
parameter "Request Id" System.String
  // TODO: remove defaults for production use
  default 'generated-id-default-value'

parameter "Payor Context" FHIR.Bundle
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

define "Payor Coverage":
  // TODO: ensure the Coverage is the relevant coverage instead of just the first matching coverage
  First(
    "Payor"."Coverages" 
      // PayorCoverage
      // with "Provider"."Coverages" ProviderCoverage
      // such that exists(PayorCoverage.identifier.id intersect ProviderCoverage.identifier.id)
  )

define "Provider Coverage":
  // TODO: ensure the Coverage is the relevant coverage instead of just the first matching coverage
  First(
    "Provider"."Coverages" 
      // PayorCoverage
      // with "Provider"."Coverages" ProviderCoverage
      // such that exists(PayorCoverage.identifier.id intersect ProviderCoverage.identifier.id)
  )

define "Service Request Item Code":
  FHIRHelpers.ToCode(singleton from "Service Request Item".code.coding)

define "Service Request Item ID":
  GetResourceType("Service Request Item") + '/' + "Service Request Item".id.value

define function "GetResourceType"(resource Resource)
returns System.String:
  if (resource is FHIR.ServiceRequest) then
    'ServiceRequest'
  else if (resource is FHIR.NutritionOrder) then
    'NutritionOrder'
  else if (resource is FHIR.DeviceRequest) then
    'DeviceRequest'
  else
    'Resource'

define "System Generated Id":
  "Request Id"

define function ExtensionPriorAuthNotNeeded(covered System.String, priorAuthRequired System.String, codeValue System.String, qualification System.String, warningOrInfo System.String)
returns FHIR.Extension:
  ECI.ExtensionPriorAuthNotNeeded("Provider Coverage".id.value, covered, priorAuthRequired, "System Generated Id", "Service Request Item ID", "Service Request Item Code", codeValue, qualification, warningOrInfo)

define function ExtensionPriorAuthNeeded(covered System.String, priorAuthRequired System.String, codeValue System.String, qualification System.String, warningOrInfo System.String)
returns FHIR.Extension:
  ECI.ExtensionPriorAuthNeeded("Provider Coverage".id.value, covered, priorAuthRequired, "System Generated Id", "Service Request Item ID", "Service Request Item Code", codeValue, qualification, warningOrInfo)

define function TagExists(resource Resource, value System.Code)
returns System.Boolean:
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

define function IsPayorResource(resource Resource)
returns System.Boolean:
  TagExists(resource, "Payor Code")

define function GetIdentifier(item Choice<Practitioner, Organization>, url System.String)
returns System.String:
  singleton from
  (
    item.identifier I
      where I.system.value ~ url
      return I.value.value
  )

define fluent function npi(items List<Choice<Practitioner, Organization>>)
returns List<System.String>:
  items I
    return GetIdentifier(I, 'http://hl7.org/fhir/sid/us-npi')

define fluent function getNpi(item Choice<Practitioner, Organization>)
returns System.String:
  GetIdentifier(item, 'http://hl7.org/fhir/sid/us-npi')

// define function GetNPI(practitioner Choice<Practitioner, Organization>)
// returns System.String:
//   // TODO: rework this to use USCore identifier slice for NPI?
//   GetIdentifier(practitioner, 'http://hl7.org/fhir/sid/us-npi')

define function GetContext(isPayor System.Boolean):
// TODO: optimize retrieves
  if (isPayor and Count("Payor Context".entry) >= 1) then 
    {
      "Patient": First(("Payor Context".entry.resource PayorResource return if (PayorResource is Patient) then PayorResource as FHIR.Patient else null as FHIR.Patient) I where I is not null),
      "Coverages": ("Payor Context".entry.resource PayorResource return if (PayorResource is Coverage) then PayorResource as FHIR.Coverage else null as FHIR.Coverage) I where I is not null,
      "Practitioners": ("Payor Context".entry.resource PayorResource return if (PayorResource is Practitioner) then PayorResource as FHIR.Practitioner else null as FHIR.Practitioner) I where I is not null,
      "PractitionerRoles": ("Payor Context".entry.resource PayorResource return if (PayorResource is PractitionerRole) then PayorResource as FHIR.PractitionerRole else null as FHIR.PractitionerRole) I where I is not null,
      "Organizations": ("Payor Context".entry.resource PayorResource return if (PayorResource is Organization) then PayorResource as FHIR.Organization else null as FHIR.Organization) I where I is not null
    }
  else
    {
      "Patient": if isPayor then "Payor Patient" else "Provider Patient",
      "Coverages": [Coverage] item where IsPayorResource(item) = isPayor,
      "Practitioners": [Practitioner] item where IsPayorResource(item) = isPayor,
      "PractitionerRoles": [PractitionerRole] item where IsPayorResource(item) = isPayor,
      "Organizations": [Organization] item where IsPayorResource(item) = isPayor
    }

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

define "Service Request Item":
  Coalesce(
    First("draftOrders" D where D is FHIR.ServiceRequest),
    "Service Request",
    First([FHIR.ServiceRequest] SR where SR.id ~ "Service Request Id"),
    // TODO: Remove for production use, this is only for testing
    First([FHIR.ServiceRequest] SR where EndsWith(SR.id, "Service Request Id")),
    null as FHIR.ServiceRequest
  ) as FHIR.ServiceRequest

define "Provider":
  GetContext(false) // false = not payor

define "Payor":
  GetContext(true) // true = payor

define "Provider Patient":
  First([Patient] P where not IsPayorResource(P))

define "Payor Patient":
  First(
    [RelatedPerson] RP
      where exists(
        RP.relationship.coding C 
          where C.system.value ~ "Relationship Self Code".system
            and C.code.value ~ "Relationship Self Code".code
      )
      and IsPayorResource(RP)
  )