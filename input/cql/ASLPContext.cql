library ASLPContext version '0.1.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'

codesystem "Relationship Role": 'http://terminology.hl7.org/CodeSystem/v3-RoleCode'
codesystem "Payor Identifier CodeSystem": 'http://terminology.hl7.org/CodeSystem/organization-type'

code "Payor Code": 'pay' from "Payor Identifier CodeSystem" display 'Payor'
code "Relationship Self Code": 'ONESELF' from "Relationship Role" display 'Self'

context Patient

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

define "Provider":
  {
    "Patient": "Provider Patient",
    "Coverages": "Provider Coverages",
    "Practitioners": "Provider Practitioners"
  }

define "Payor":
  {
    "Patient": "Payor Patient",
    "Coverages": "Payor Coverages",
    "Practitioners": "Payor Practitioners"
  }

define "Provider Patients":
  [Patient] P where not IsPayorResource(P)

define "Provider Patient":
  First("Provider Patients")

define "Payor Patients":
  [RelatedPerson] RP
    where exists(
      RP.relationship.coding C 
        where C.system.value ~ "Relationship Self Code".system
          and C.code.value ~ "Relationship Self Code".code
    )
    and IsPayorResource(RP)

define "Payor Patient":
  First("Payor Patients")

define "Payor Coverages":
  [Coverage] C where IsPayorResource(C)

define "Provider Coverages":
  [Coverage] C where not IsPayorResource(C)

define "Payor Practitioners":
  [Practitioner] P where IsPayorResource(P)

define "Provider Practitioners":
  [Practitioner] P where not IsPayorResource(P)