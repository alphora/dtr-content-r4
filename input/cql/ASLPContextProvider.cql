library ASLPContextProvider version '0.1.0'

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include ASLPConcepts version '0.1.0' called ASLPConcepts

// TODO: separate this into different parameters
// parameter "Provider Patient" FHIR.Patient
// parameter "Provider Coverages" List<FHIR.Coverage>
// parameter "Provider Practitioners" List<FHIR.Practitioner>
// parameter "Provider PractitionerRoles" List<FHIR.PractitionerRole>
// parameter "Provider Organizations" List<FHIR.Organization>
parameter "Provider Context" FHIR.Bundle
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

define "Provider Coverage":
  First("Provider"."Coverages")

define "Provider":
  if (Count("Provider Context".entry) >= 1) then 
    {
      "Patient": First(("Provider Context".entry.resource PayorResource return if (PayorResource is Patient) then PayorResource as FHIR.Patient else null as FHIR.Patient) I where I is not null),
      "Coverages": ("Provider Context".entry.resource PayorResource return if (PayorResource is Coverage) then PayorResource as FHIR.Coverage else null as FHIR.Coverage) I where I is not null,
      "Practitioners": ("Provider Context".entry.resource PayorResource return if (PayorResource is Practitioner) then PayorResource as FHIR.Practitioner else null as FHIR.Practitioner) I where I is not null,
      "PractitionerRoles": ("Provider Context".entry.resource PayorResource return if (PayorResource is PractitionerRole) then PayorResource as FHIR.PractitionerRole else null as FHIR.PractitionerRole) I where I is not null,
      "Organizations": ("Provider Context".entry.resource PayorResource return if (PayorResource is Organization) then PayorResource as FHIR.Organization else null as FHIR.Organization) I where I is not null
    }
  // This section is only for local CQL vs code plugin testing
  else
    {
      "Patient": "Provider Patient",
      "Coverages": "All Provider Coverages",
      "Practitioners": "All Provider Practitioners",
      "PractitionerRoles": "All Provider PractitionerRoles",
      "Organizations": "All Provider Organizations"
    }

define "Provider Patient":
  //First([RelatedPerson])
  First([Patient])

define "All Provider Coverages":
  [Coverage] item where ASLPConcepts.IsPayorResource(item) = false

define "All Provider Practitioners":
  [Practitioner] item where ASLPConcepts.IsPayorResource(item) = false

define "All Provider PractitionerRoles":
  [PractitionerRole] item where ASLPConcepts.IsPayorResource(item) = false

define "All Provider Organizations":
  [Organization] item where ASLPConcepts.IsPayorResource(item) = false