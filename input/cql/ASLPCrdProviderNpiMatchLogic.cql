library ASLPCrdProviderNpiMatchLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext version '0.1.0' called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

context Patient

define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"(First(Ctx."Provider"."Coverages").id)

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

define "Requesting Organizations associated with a PracitionerRole":
  Ctx."Provider"."Organizations" Organization
  with "Requesting PractitionerRoles" PractitionerRole
  such that PractitionerRole.organization.reference.getId() ~ Organization.id.value

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

define "Performing Organizations associated with a PracitionerRole":
  Ctx."Provider"."Organizations" Organization
  with "Performing PractitionerRoles" PractitionerRole
  such that PractitionerRole.organization.reference.getId() ~ Organization.id.value
  
define "Performing Practitioners NPIs":
  "Performing Practitioners".npi() 
    union "Performing Practitioners via PracitionerRoles".npi()

define "Performing Organizations NPIs":
  "Performing Organizations".npi()
  union "Performing Organizations associated with a PracitionerRole".npi()

define "Performing NPIs":
  (
    "Performing Practitioners NPIs"
      union "Performing Organizations NPIs"
  ) NPI where not IsNull(NPI)

define "Organization Provider":
  Ctx."Provider"."Organizations"

define "Payor References by Coverage.payor":
  flatten(Ctx."Payor"."Coverages" C return C.payor.reference.value)

define "Organization from Coverage for Patient":
  Ctx."Payor"."Organizations" O
    with "Payor References by Coverage.payor" R
    such that R.getId() = O.id.value

define "Matching Organizations by Name":
  "Organization Provider" ProviderPayorOrg
    with "Organization from Coverage for Patient" PayorOrg
    such that 
      ProviderPayorOrg.name ~ PayorOrg.name