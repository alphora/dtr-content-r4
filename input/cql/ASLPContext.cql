library ASLPContext version '0.1.0'

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

codesystem "Relationship Role": 'http://terminology.hl7.org/CodeSystem/v3-RoleCode'
codesystem "Payor Identifier CodeSystem": 'http://terminology.hl7.org/CodeSystem/organization-type'

code "Payor Code": 'pay' from "Payor Identifier CodeSystem" display 'Payor'
code "Relationship Self Code": 'ONESELF' from "Relationship Role" display 'Self'

parameter "Service Request" List<FHIR.ServiceRequest>
parameter "Service Request Id" List<System.String> 
  // TODO: remove defaults for production use
  default { 'required-SleepStudy', 'not-required-SleepStudy', 'SleepStudy', 'SleepStudy2' }

context Patient

define function ExtensionPriorAuthNotNeeded(coverageId System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information' },
    "extension": { 
      FHIR.Extension {
        "url": FHIR.uri { "value": 'coverageInfo' },
        "value": FHIR.Coding {
          system: FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp' },
          code: FHIR.code { "value": 'covered' },
          display: FHIR.string { "value": 'Covered' }
        }
      },
      FHIR.Extension {
        "url": FHIR.uri { "value": 'coverage' },
        "value": FHIR.Reference {
          "reference": FHIR.string { "value": 'Coverage/' + coverageId }
        }
      },
      FHIR.Extension {
          "url": FHIR.uri { "value": 'date' },
          "value": FHIR.date { "value": @2023-07-13 }
      }
    }
  }

define function ExtensionPriorAuthNeeded(coverageId System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information' },
    "extension": { 
      FHIR.Extension {
        "url": FHIR.uri { "value": 'coverageInfo' },
        "value": FHIR.Coding {
          system: FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp' },
          code: FHIR.code { "value": 'clinical' },
          display: FHIR.string { "value": 'Clinical' }
        }
      },
      FHIR.Extension {
        "url": FHIR.uri { "value": 'coverage' },
        "value": FHIR.Reference {
          "reference": FHIR.string { "value": 'Coverage/' + coverageId }
        }
      },
      FHIR.Extension {
          "url": FHIR.uri { "value": 'date' },
          "value": FHIR.date { "value": @2022-06-12 }
      },
      FHIR.Extension {
          "url": FHIR.uri { "value": 'questionnaire' },
          "value": FHIR.canonical { "value": 'http://example.org/sdh/dtr/asip/Questionnaire/ASLPA1' }
      },
      FHIR.Extension {
        "url": FHIR.uri { "value": 'detail' },
        "extension": {
          FHIR.Extension {
            "url": FHIR.uri { "value": 'code' },
            "value": FHIR.CodeableConcept { 
              "coding": {
                FHIR.Coding {
                  system: FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp' },
                  code: FHIR.code { "value": 'to-endpoint' },
                  display: FHIR.string { "value": 'Send information to endpoint' }
                }
              },
              "text": FHIR.string { "value": 'Send information to endpoint' }
            }
          },
          FHIR.Extension {
            "url": FHIR.uri { "value": 'value' },
            "value": FHIR.string { "value": 'Warning' }
          },
          FHIR.Extension {
            "url": FHIR.uri { "value": 'qualification' },
            "value": FHIR.string { "value": 'Prior auth is required for: inpatient non-acute' }
          }
        }
      }
    }
  }

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
  First(
    Coalesce(
      // TODO: require an exact match instead of an EndsWith match?
      //[FHIR.ServiceRequest] SR where exists("Service Request Id" id where SR.id ~ id),
      [FHIR.ServiceRequest] SR where exists("Service Request Id" id where EndsWith(SR.id, id)),
      "Service Request",
      { null as FHIR.ServiceRequest }
    )
  )

define "Provider":
  GetContext(false)

define "Payor":
  GetContext(true)

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