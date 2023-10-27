library ASLPCrdProviderNpiMatchLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'
 
context Patient

// CRD-3.1
define "Title":
  'Prior Auth Evaluation'

// CRD-3.1
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

// CRD-3.1
define "Qualification":
  'Provider is not in the network. You can submit a PA request as an exception.'

// CRD-3.1
define "Detail Text":
  'Provider Not in Network'

// CRD-3.1
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('conditional', 'auth-needed', 'auth-needed', "Detail Text", "Qualification", 'Warning')

define "Is ProviderNpiMatch":
  "Requesting NPIs Match"
    and "Performing NPIs Match"

define "Requesting NPIs Match":
  exists("Requesting NPIs")
    and "Requesting NPIs" included in "Payor NPIs"

define "Performing NPIs Match":
  "Performing NPIs" included in "Payor NPIs"

define "Not ProviderNpiMatch":
  not ("Is ProviderNpiMatch")

define "Payor NPIs":
  (
    "Payor Practitioners NPIs"
      union "Payor Organizations NPIs"
  ) NPI where not IsNull(NPI)

define "Payor Practitioners NPIs":
  Ctx."Payor"."Practitioners".npi()

define "Payor Organizations NPIs":
  Ctx."Payor"."Organizations".npi()

define "Requesting Practitioners":
  Ctx."Provider"."Practitioners" Practitioner
    with ({ Ctx."Service Request Item".requester }) RequesterPractitioner
    such that RequesterPractitioner.reference.getId() ~ Practitioner.id.value

define "Requesting PractitionerRoles":
  Ctx."Provider"."PractitionerRoles" PractitionerRole
    with ({ Ctx."Service Request Item".requester }) RequesterPractitionerRole
    such that RequesterPractitionerRole.reference.getId() ~ PractitionerRole.id.value

define "Requesting Practitioners via PracitionerRoles":
  Ctx."Provider"."Practitioners" Practitioner
    with "Requesting PractitionerRoles" PractitionerRole
    such that PractitionerRole.practitioner.reference.getId() ~ Practitioner.id.value

define "Requesting Organizations":
  Ctx."Provider"."Organizations" Organization
    with ({ Ctx."Service Request Item".requester }) RequesterOrganization
    such that RequesterOrganization.reference.getId() ~ Organization.id.value

define "Requesting Practitioners NPIs":
  "Requesting Practitioners".npi()
    union "Requesting Practitioners via PracitionerRoles".npi()

define "Requesting Organizations NPIs":
  "Requesting Organizations".npi()

define "Requesting NPIs":
  (
    "Requesting Practitioners NPIs"
      union "Requesting Organizations NPIs"
  ) NPI where not IsNull(NPI)
    
define "Performing Practitioners":
  Ctx."Provider"."Practitioners" Practitioner
    with Ctx."Service Request Item".performer PractitionerPerformer
    such that PractitionerPerformer.reference.getId() ~ Practitioner.id.value

define "Performing PractitionerRoles":
  Ctx."Provider"."PractitionerRoles" PractitionerRole
    with Ctx."Service Request Item".performer PractitionerPerformerRole
    such that PractitionerPerformerRole.reference.getId() ~ PractitionerRole.id.value

define "Performing Practitioners via PracitionerRoles":
  Ctx."Provider"."Practitioners" Practitioner
    with "Performing PractitionerRoles" PractitionerRole
    such that PractitionerRole.practitioner.reference.getId() ~ Practitioner.id.value

define "Performing Organizations":
  Ctx."Provider"."Organizations" Organization
    with Ctx."Service Request Item".performer PractitionerOrganization
    such that PractitionerOrganization.reference.getId() ~ Organization.id.value

// TODO: ensure this is correct
define "Performing Organizations associated with PractitionerRoles":
  Ctx."Provider"."Organizations" Organization
    with "Performing PractitionerRoles" PractitionerRole
    such that PractitionerRole.organization.reference.getId() ~ Organization.id.value

define "Performing Practitioners NPIs":
  "Performing Practitioners".npi() 
    union "Performing Practitioners via PracitionerRoles".npi()

define "Performing Organizations NPIs":
  "Performing Organizations".npi()
    union "Performing Organizations associated with PractitionerRoles".npi()

define "Performing NPIs":
  (
    "Performing Practitioners NPIs"
      union "Performing Organizations NPIs"
  ) NPI where not IsNull(NPI)