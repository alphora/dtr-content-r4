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
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'conditional', 'auth-needed', 'auth-needed', "Detail Text", "Qualification", 'Warning')

define function "Is LOBMatch"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  "Requesting Organization Match"(requestItem)
    and "Performing Organization Match"(requestItem)

define function "Not LOBMatch"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  not ("Is LOBMatch"(requestItem))

define function "Is ProviderNpiMatch"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  // 1. The requesting provider must be in the payer system.
  // 2. AND All performing providers from the provider's system must match a performing provider from the payer's system. 
  //    NOTE: This step can be skipped if there are no performing providers. 
  "Requesting Provider Match"(requestItem)
    and "Performing Provider Match"(requestItem)

define function "Requesting Provider Match"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  if (not "All Requesting Practitioners Found"(requestItem)) then 
    false 
  else
    // 'included in': Returns true if every element in list X is also in list Y, using equality semantics
    (
      ("Requesting Practitioners from Provider"(requestItem)).npi() // X
        included in ("Requesting Practitioners from Payor"(requestItem)).npi() // Y
    ) and exists("Requesting Practitioners from Provider"(requestItem)) // NOTE: This step cannot be skipped if there is no requester provider.

define function "Performing Provider Match"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  if (not "All Performing Practitioners Found"(requestItem)) then 
    false 
  else
    // 'included in': Returns true if every element in list X is also in list Y, using equality semantics
    (
      ("Performing Practitioners from Provider"(requestItem)).npi() // X
        included in ("Performing Practitioners from Payor"(requestItem)).npi() // Y
    ) or not exists("Performing Practitioners from Provider"(requestItem)) // NOTE: This step can be skipped if there are no performing providers. 

define function "Requesting Organization Match"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  exists(("Matching Requesting Organizations by Name & Type or NPI"(requestItem)))

define function "Performing Organization Match"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  exists(("Matching Performing Organizations by Name & Type or NPI"(requestItem)))
    or not exists(("Performing Practitioners from Provider"(requestItem)))

define function "Not ProviderNpiMatch"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  not ("Is ProviderNpiMatch"(requestItem))

// TODO: Need to investigate how to handle a ServiceRequest.requester as an Organization
define function "Requesting PractitionerRoles from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Provider"."PractitionerRoles" PractitionerRole
    with (Ctx.GetRequester(requestItem)) RequesterPractitioner
    such that RequesterPractitioner.reference.getId() ~ PractitionerRole.id.value

define function "Requesting Practitioners from PractitionerRoles"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Provider"."Practitioners" Practitioner
    with ("Requesting PractitionerRoles from ServiceRequest"(requestItem)) RequesterPractitionerRole
    such that RequesterPractitionerRole.practitioner.reference.getId() ~ Practitioner.id.value

define function "Requesting Practitioners from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Provider"."Practitioners" Practitioner
    with (Ctx.GetRequester(requestItem)) RequesterPractitioner
    such that RequesterPractitioner.reference.getId() ~ Practitioner.id.value

define function "Requesting Practitioner IDs from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  (
    ("Requesting PractitionerRoles from ServiceRequest"(requestItem)) RequesterPractitionerRole
    return RequesterPractitionerRole.practitioner.reference.getId()
  )
  union
  (
    (Ctx.GetRequester(requestItem)) RequesterPractitioner
      return RequesterPractitioner.reference.getId()
  )

define function "All Requesting Practitioners Found"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  IsTrue(
    "Requesting Practitioner IDs from ServiceRequest"(requestItem)
      included in (("Requesting Practitioners from Provider"(requestItem)) Practitioner return Practitioner.id.value)
  )

define function "Requesting Practitioners from Provider"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  ("Requesting Practitioners from ServiceRequest"(requestItem))
    union ("Requesting Practitioners from PractitionerRoles"(requestItem))

define function "Requesting Practitioners from Payor"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Payor"."Practitioners" Practitioner
    with ("Requesting Practitioners from Provider"(requestItem)) PractitionerRequester
    such that PractitionerRequester.getNpi() ~ Practitioner.getNpi()

define function "Requesting PractitionerRoles"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Payor"."PractitionerRoles" PractitionerRole
    with ("Requesting Practitioners from Payor"(requestItem)) RequesterPractitioner
    such that PractitionerRole.practitioner.reference.getId() ~ RequesterPractitioner.id.value

define function "Requesting Organizations associated with a PracitionerRole"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Payor"."Organizations" Organization
    with ("Requesting PractitionerRoles"(requestItem)) RequestPractRole
    such that RequestPractRole.organization.reference.getId() ~ Organization.id.value

define function "Requesting Organizations"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  "Requesting Organizations associated with a PracitionerRole"(requestItem)

define function "Matching Requesting Organizations by Name & Type or NPI"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
 ("Requesting Organizations"(requestItem)) RequestingOrganization
    with "Payor Organization from Provider Coverage for Patient" PayorOrg
    such that 
      (RequestingOrganization.name ~ PayorOrg.name)
        or (RequestingOrganization.name ~ PayorOrg.name and RequestingOrganization.type ~ PayorOrg.type)
        or RequestingOrganization.getNpi() ~ PayorOrg.getNpi()

define function "Performing PractitionerRoles from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Provider"."PractitionerRoles" PractitionerRole
    with (Ctx.GetPerformer(requestItem)) PerformerPractitioner
    such that PerformerPractitioner.reference.getId() ~ PractitionerRole.id.value

define function "Performing Practitioners from PractitionerRoles"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Provider"."Practitioners" Practitioner
    with ("Performing PractitionerRoles from ServiceRequest"(requestItem)) PerformerPractitionerRole
    such that PerformerPractitionerRole.practitioner.reference.getId() ~ Practitioner.id.value

define function "Performing Practitioners from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Provider"."Practitioners" Practitioner
    with (Ctx.GetPerformer(requestItem)) PerformerPractitioner
    such that PerformerPractitioner.reference.getId() ~ Practitioner.id.value

define function "Performing Practitioners from Provider"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  ("Performing Practitioners from ServiceRequest"(requestItem))
    union ("Performing Practitioners from PractitionerRoles"(requestItem))

define function "Performing Practitioners from Payor"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Payor"."Practitioners" Practitioner
    with ("Performing Practitioners from Provider"(requestItem)) PractitionerPerformer
    such that PractitionerPerformer.getNpi() ~ Practitioner.getNpi()

define function "Performing PractitionerRoles from Payor"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Payor"."PractitionerRoles" PractitionerRole
    with ("Performing Practitioners from Payor"(requestItem)) Practitioner
    such that PractitionerRole.practitioner.reference.getId() ~ Practitioner.id.value

define function "Performing Practitioners via PracitionerRoles"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Provider"."Practitioners" Practitioner
    with ("Performing PractitionerRoles from Payor"(requestItem)) PractitionerRole
    such that PractitionerRole.practitioner.reference.getId() ~ Practitioner.id.value

define function "Performing Practitioner IDs from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  (
    ("Performing PractitionerRoles from ServiceRequest"(requestItem)) PerformerPractitionerRole
    return PerformerPractitionerRole.practitioner.reference.getId()
  )
  union
  (
    (Ctx.GetPerformer(requestItem)) PerformerPractitioner
      return PerformerPractitioner.reference.getId()
  )

define function "All Performing Practitioners Found"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  IsTrue(
    "Performing Practitioner IDs from ServiceRequest"(requestItem)
      included in (("Performing Practitioners from Provider"(requestItem)) Practitioner return Practitioner.id.value)
  )

define function "Payor Organization via Performing PracitionerRole"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Payor"."Organizations" Organization
    with ("Performing PractitionerRoles from Payor"(requestItem)) PractitionerRole
    such that PractitionerRole.organization.reference.getId() ~ Organization.id.value

define function "Performing Organizations associated with a PracitionerRole"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."Payor"."Organizations" Organization
  with ("Performing PractitionerRoles from Payor"(requestItem)) PractitionerRole
  such that PractitionerRole.organization.reference.getId() ~ Organization.id.value

define function "Performing Organizations"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  "Performing Organizations associated with a PracitionerRole"(requestItem)

define function "Matching Performing Organizations by Name & Type or NPI"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  ("Performing Organizations"(requestItem)) PerformingOrganization
    with "Payor Organization from Provider Coverage for Patient" PayorOrg
    such that 
      PerformingOrganization.name ~ PayorOrg.name
        or (PerformingOrganization.name ~ PayorOrg.name and PerformingOrganization.type ~ PayorOrg.type)
        or PerformingOrganization.getNpi() ~ PayorOrg.getNpi()

define "Payor References by Coverage.payor":
  flatten(Ctx."Provider"."Coverages" C return C.payor.reference.value)

define "Payor Organization from Provider Coverage for Patient":
  Ctx."Provider"."Organizations" O
    with "Payor References by Coverage.payor" R
    such that R.getId() = O.id.value