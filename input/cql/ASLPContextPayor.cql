library ASLPContextPayor version '0.1.0'

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include ASLPConcepts version '0.1.0' called ASLPConcepts

context Patient

define "Payor Coverage":
  // NOTE: per PA team, the Coverage is just the first matching coverage
  //       - at some point we may return a "ambiguous data" response if there is > 1 Coverage
  First("All Payor Coverages")

define "Payor":
  if (ASLPConcepts.IsLocalTesting) then
    {
      "Patient": "Payor Patient",
      "Coverages": { First("All Payor Coverages" item where ASLPConcepts.IsPayorResource(item) = true) },
      "Practitioners": "All Payor Practitioners" item where ASLPConcepts.IsPayorResource(item) = true,
      "PractitionerRoles": "All Payor PractitionerRoles" item where ASLPConcepts.IsPayorResource(item) = true,
      "Organizations": "All Payor Organizations" item where ASLPConcepts.IsPayorResource(item) = true
    }
  else 
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