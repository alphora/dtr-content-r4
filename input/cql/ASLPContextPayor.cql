library ASLPContextPayor

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

codesystem "Payor Identifier CodeSystem": 'http://terminology.hl7.org/CodeSystem/organization-type'

code "Payor Code": 'pay' from "Payor Identifier CodeSystem" display 'Payor'

context Patient

define function IsPayorResource(resource Resource)
returns System.Boolean:
  TagExists(resource, "Payor Code")

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

define "Payor Coverage":
  // NOTE: per PA team, the Coverage is just the first matching coverage
  //       - at some point we may return a "ambiguous data" response if there is > 1 Coverage
  First("All Payor Coverages")

define "Payor":
  {
    "Patient": "Payor Patient",
    "Coverages": { "Payor Coverage" },
    "Practitioners": "All Payor Practitioners",
    "PractitionerRoles": "All Payor PractitionerRoles",
    "Organizations": "All Payor Organizations"
  }

define "Payor Patient":
  First([Patient])

define "All Payor Coverages":
  [Coverage] 
  
define "All Payor Practitioners":
  [Practitioner] Prac 
    with "All Payor PractitionerRoles" PR 
        such that PR.practitioner.reference = 'Practitioner/' + Prac.id

define "All Payor PractitionerRoles":
  [PractitionerRole] PR
  with "All Payor Organizations" O 
  such that PR.organization.reference = 'Organization/' + O.id

define "All Payor Organizations":
  [Organization] O 
    with "All Payor Coverages" C 
    such that exists (C.payor P 
      where P.reference = 'Organization/' + O.id)