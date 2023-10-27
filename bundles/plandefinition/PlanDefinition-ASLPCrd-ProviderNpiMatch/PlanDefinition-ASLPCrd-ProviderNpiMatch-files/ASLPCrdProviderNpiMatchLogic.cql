library ASLPCrdProviderNpiMatchLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext version '0.1.0' called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'
 
context Patient

// CRD-3.1
define "Title":
  'Provider Not in Network'

// CRD-3.1
define "Description":
  '- Provider is not in the network.' + Ctx."NewLine" +
  '- You can submit a PA request as an exception.'

// CRD-3.1
define "Qualification":
  'Prior auth is required for: ' + Ctx."Service Request Item ID"

// CRD-3.1
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('conditional', 'auth-needed', 'auth-needed', "Qualification", 'Warning')

//TODO: CHANGE THE function names to match the Org name & type logic
define "Is ProviderNpiMatch":
  "Requesting Organization Match"
    and "Performing Organization Match"

define "Requesting Organization Match":
  exists("Matching Requesting Organizations by Name & Type or NPI")

define "Performing Organization Match":
  exists("Matching Performing Organizations by Name & Type or NPI")
  or not exists("Performing Practitioners from Provider")

define "Not ProviderNpiMatch":
  not ("Is ProviderNpiMatch")


define "Requesting Practitioners from Provider":
  Ctx."Provider"."Practitioners" Practitioner
    with ({ Ctx."Service Request Item".requester }) RequesterPractitioner
    such that RequesterPractitioner.reference.getId() ~ Practitioner.id.value

define "Requesting Practitioners from Payor":
  Ctx."Payor"."Practitioners" Practitioner
    with "Requesting Practitioners from Provider" PractitionerRequester
    such that PractitionerRequester.getNpi() ~ Practitioner.getNpi()

define "Requesting PractitionerRoles":
  Ctx."Payor"."PractitionerRoles" PractitionerRole
    with "Requesting Practitioners from Payor" RequesterPractitioner
    such that PractitionerRole.practitioner.reference.getId() ~ RequesterPractitioner.id.value

define "Requesting Organizations associated with a PracitionerRole":
  Ctx."Payor"."Organizations" Organization
    with "Requesting PractitionerRoles" RequestPractRole
    such that RequestPractRole.organization.reference.getId() ~ Organization.id.value

define "Requesting Organizations":
  "Requesting Organizations associated with a PracitionerRole"

define "Matching Requesting Organizations by Name & Type or NPI":
 "Requesting Organizations" RequestingOrganization
    with "Payor Organization from Provider Coverage for Patient" PayorOrg
    such that 
      (RequestingOrganization.name ~ PayorOrg.name and RequestingOrganization.type ~ PayorOrg.type)
      or RequestingOrganization.getNpi() ~ PayorOrg.getNpi()

define "Performing Practitioners from Provider":
  Ctx."Provider"."Practitioners" Practitioner
    with Ctx."Service Request Item".performer PractitionerPerformer
    such that PractitionerPerformer.reference.getId() ~ Practitioner.id.value

define "Performing Practitioners from Payor":
  Ctx."Payor"."Practitioners" Practitioner
    with "Performing Practitioners from Provider" PractitionerPerformer
    such that PractitionerPerformer.getNpi() ~ Practitioner.getNpi()

define "Performing PractitionerRoles from Payor":
  Ctx."Payor"."PractitionerRoles" PractitionerRole
    with "Performing Practitioners from Payor" Practitioner
    such that PractitionerRole.practitioner.reference.getId() ~ Practitioner.id.value

define "Performing Practitioners via PracitionerRoles":
  Ctx."Provider"."Practitioners" Practitioner
    with "Performing PractitionerRoles from Payor" PractitionerRole
    such that PractitionerRole.practitioner.reference.getId() ~ Practitioner.id.value
    
define "Payor Organization via Performing PracitionerRole":
  Ctx."Payor"."Organizations" Organization
    with "Performing PractitionerRoles from Payor" PractitionerRole
    such that PractitionerRole.organization.reference.getId() ~ Organization.id.value

define "Performing Organizations associated with a PracitionerRole":
  Ctx."Payor"."Organizations" Organization
  with "Performing PractitionerRoles from Payor" PractitionerRole
  such that PractitionerRole.organization.reference.getId() ~ Organization.id.value

define "Performing Organizations":
  "Performing Organizations associated with a PracitionerRole"

define "Matching Performing Organizations by Name & Type or NPI":
  "Performing Organizations" PerformingOrganization
    with "Payor Organization from Provider Coverage for Patient" PayorOrg
    such that 
      (PerformingOrganization.name ~ PayorOrg.name and PerformingOrganization.type ~ PayorOrg.type)
      or PerformingOrganization.getNpi() ~ PayorOrg.getNpi()

define "Performing Practitioners NPIs":
  "Performing Practitioners".npi() 
    union "Performing Practitioners via PracitionerRoles".npi()

define "Performing Organizations NPIs":
  "Performing Organizations".npi()

define "Payor Organization from Provider Coverage for Patient":
  Ctx."Provider"."Organizations" O
    with "Payor References by Coverage.payor" R
    such that R.getId() = O.id.value