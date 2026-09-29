library ASLPCrdProviderNpiMatchLogic version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include ASLPContext version '0.1.0' called Ctx
include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
 
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
define function "Detail Debugging"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  '"Is LOBMatch"=' + ToString("Is LOBMatch"(requestItem))  + Ctx.NewLine +
  '  - "Requesting Organization Match"=' + ToString("Requesting Organization Match"(requestItem))  + Ctx.NewLine +
  '  - "Performing Organization Match"=' + ToString("Performing Organization Match"(requestItem))  + Ctx.NewLine +
  Ctx.NewLine +
  '"Is ProviderNpiMatch"=' + Ctx.NewLine + ToString("Is ProviderNpiMatch"(requestItem))  + Ctx.NewLine +
  '  - "Requesting Provider Match"=' + Ctx.NewLine + ToString("Requesting Provider Match"(requestItem))  + Ctx.NewLine +
  '    - "All Requesting Practitioners Found"(requestItem)=' + Ctx.NewLine + ToString("All Requesting Practitioners Found"(requestItem))  + Ctx.NewLine +
  '    - "Requesting PractitionerRoles from ServiceRequest Output"(requestItem)=' + Ctx.NewLine + Combine("Requesting PractitionerRoles from ServiceRequest Output"(requestItem), ',')  + Ctx.NewLine +
  '    - ("Requesting Practitioners from Provider"(requestItem)).npi()=' + Ctx.NewLine + Combine(("Requesting Practitioners from Provider"(requestItem)).npi(), ',')  + Ctx.NewLine +
  '    - ("Requesting Practitioners from Payor"(requestItem)).npi()=' + Ctx.NewLine + Combine(("Requesting Practitioners from Payor"(requestItem)).npi(), ',')  + Ctx.NewLine +
  '    - "Performing Practitioner IDs from ServiceRequest"(requestItem)=' + Ctx.NewLine + Combine("Performing Practitioner IDs from ServiceRequest"(requestItem), ',')  + Ctx.NewLine +
  '    - "Performing Practitioners from Provider"(requestItem)=' + Ctx.NewLine + Combine((("Performing Practitioners from Provider"(requestItem)) Practitioner return Practitioner.id.value), ',')  + Ctx.NewLine +
  '    - "Requesting Practitioners from Provider NPI included in Requesting Practitioners from Payor NPI"=' + Ctx.NewLine + ToString("Requesting Practitioners from Provider NPI included in Requesting Practitioners from Payor NPI"(requestItem))  + Ctx.NewLine +
  '  - "Performing Provider Match"=' + Ctx.NewLine + ToString("Performing Provider Match"(requestItem))  + Ctx.NewLine

define function "Requesting PractitionerRoles from ServiceRequest Output"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  ("Requesting PractitionerRoles from ServiceRequest"(requestItem)) RequesterPractitionerRole
    return RequesterPractitionerRole.practitioner.reference.value
 
define function "Requesting Practitioners from Provider NPI included in Requesting Practitioners from Payor NPI"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  ("Requesting Practitioners from Provider"(requestItem)).npi() // X
    included in ("Requesting Practitioners from Payor"(requestItem)).npi() // Y

// CRD-3.1
define "Detail Text":
  'Provider Not in Network'

// CRD-3.1
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'conditional', 'auth-needed', 'auth-needed', "Detail Text", "Qualification", 'Warning')

define function "Is LOBMatch"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  "Requesting Organization Match"(requestItem)
    and "Performing Organization Match"(requestItem)

define function "Not LOBMatch"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  not ("Is LOBMatch"(requestItem))

define function "Is ProviderNpiMatch"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  // 1. The requesting provider must be in the payer system.
  // 2. AND All performing providers from the provider's system must match a performing provider from the payer's system. 
  //    NOTE: This step can be skipped if there are no performing providers. 
  "Requesting Provider Match"(requestItem)
    and "Performing Provider Match"(requestItem)

define function "Requesting Provider Match"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  if (not "All Requesting Practitioners Found"(requestItem)) then 
    false 
  else
    // 'included in': Returns true if every element in list X is also in list Y, using equality semantics
    (
      ("Requesting Practitioners from Provider"(requestItem)).npi() // X
        included in ("Requesting Practitioners from Payor"(requestItem)).npi() // Y
    ) and exists("Requesting Practitioners from Provider"(requestItem)) // NOTE: This step cannot be skipped if there is no requester provider.

define function "Performing Provider Match"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  if (not "All Performing Practitioners Found"(requestItem)) then 
    false 
  else
    // 'included in': Returns true if every element in list X is also in list Y, using equality semantics
    (
      ("Performing Practitioners from Provider"(requestItem)).npi() // X
        included in ("Performing Practitioners from Payor"(requestItem)).npi() // Y
    ) or not exists("Performing Practitioners from Provider"(requestItem)) // NOTE: This step can be skipped if there are no performing providers. 

define function "Requesting Organization Match"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  exists(("Matching Requesting Organizations by Name & Type or NPI"(requestItem)))

define function "Performing Organization Match"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  exists(("Matching Performing Organizations by Name & Type or NPI"(requestItem)))
    or not exists(("Performing Practitioners from Provider"(requestItem)))

define function "Not ProviderNpiMatch"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  not ("Is ProviderNpiMatch"(requestItem))

// TODO: Need to investigate how to handle a ServiceRequest.requester as an Organization
define function "Requesting PractitionerRoles from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Provider"."PractitionerRoles" PR
    with (Ctx.GetRequester(requestItem)) RequesterPractitioner
    such that RequesterPractitioner.reference.value ~ 'PractitionerRole/' + PR.id.value

define function "Requesting Practitioners from PractitionerRoles"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Provider"."Practitioners" P
    with ("Requesting PractitionerRoles from ServiceRequest"(requestItem)) RequesterPractitionerRole
    such that RequesterPractitionerRole.practitioner.reference.value ~ 'Practitioner/' + P.id.value

define function "Requesting Practitioners from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Provider"."Practitioners" P
    with (Ctx.GetRequester(requestItem)) RequesterPractitioner
    such that RequesterPractitioner.reference.value ~ 'Practitioner/' + P.id.value

define function "Requesting Practitioner IDs from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  (
    ("Requesting PractitionerRoles from ServiceRequest"(requestItem)) RequesterPractitionerRole
    return Last(Split(RequesterPractitionerRole.practitioner.reference.value, '/'))
  )
  union
  (
    (Ctx.GetRequester(requestItem)) RequesterPractitioner
      return if (PositionOf('Practitioner/', RequesterPractitioner.reference) >= 0)
        then Last(Split(RequesterPractitioner.reference.value, '/'))
        else null
  ) item where not IsNull(item)

define function "All Requesting Practitioners Found"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  IsTrue(
    "Requesting Practitioner IDs from ServiceRequest"(requestItem)
      included in (("Requesting Practitioners from Provider"(requestItem)) Practitioner return Practitioner.id.value)
  )

define function "Requesting Practitioners from Provider"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  ("Requesting Practitioners from ServiceRequest"(requestItem))
    union ("Requesting Practitioners from PractitionerRoles"(requestItem))

define function "Requesting Practitioners from Payor"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Payor"."Practitioners" Practitioner
    with ("Requesting Practitioners from Provider"(requestItem)) PractitionerRequester
    such that PractitionerRequester.getNpi() ~ Practitioner.getNpi()

define function "Requesting PractitionerRoles"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Payor"."PractitionerRoles" PractitionerRole
    with ("Requesting Practitioners from Payor"(requestItem)) RequesterPractitioner
    such that PractitionerRole.practitioner.reference.value ~ 'Practitioner/' + RequesterPractitioner.id.value

define function "Requesting Organizations associated with a PracitionerRole"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Payor"."Organizations" Organization
    with ("Requesting PractitionerRoles"(requestItem)) RequestPractRole
    such that RequestPractRole.organization.reference.value ~ 'Organization/' + Organization.id.value

define function "Requesting Organizations"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  "Requesting Organizations associated with a PracitionerRole"(requestItem)

define function "Matching Requesting Organizations by Name & Type or NPI"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
 ("Requesting Organizations"(requestItem)) RequestingOrganization
    with "Payor Organization from Provider Coverage for Patient" PayorOrg
    such that (
      RequestingOrganization.getNpi() ~ PayorOrg.getNpi()
      or (
        (RequestingOrganization.name ~ PayorOrg.name)
        and (RequestingOrganization.type ~ PayorOrg.type)
      )
    )
        // or (RequestingOrganization.name ~ PayorOrg.name and RequestingOrganization.type ~ PayorOrg.type)
        // or RequestingOrganization.getNpi() ~ PayorOrg.getNpi()

define function "Performing PractitionerRoles from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Provider"."PractitionerRoles" PR
    with (Ctx.GetPerformer(requestItem)) PerformerPractitioner
    such that PerformerPractitioner.reference.value ~ 'PractitionerRole/' + PR.id.value

define function "Performing Practitioners from PractitionerRoles"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Provider"."Practitioners" P
    with ("Performing PractitionerRoles from ServiceRequest"(requestItem)) PerformerPractitionerRole
    such that PerformerPractitionerRole.practitioner.reference.value ~ 'Practitioner/' + P.id.value

define function "Performing Practitioners from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Provider"."Practitioners" P
    with (Ctx.GetPerformer(requestItem)) PerformerPractitioner
    such that PerformerPractitioner.reference.value ~ 'Practitioner/' + P.id.value

define function "Performing Practitioners from Provider"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  ("Performing Practitioners from ServiceRequest"(requestItem))
    union ("Performing Practitioners from PractitionerRoles"(requestItem))

define function "Performing Practitioners from Payor"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Payor"."Practitioners" Practitioner
    with ("Performing Practitioners from Provider"(requestItem)) PractitionerPerformer
    such that PractitionerPerformer.getNpi() ~ Practitioner.getNpi()

define function "Performing PractitionerRoles from Payor"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Payor"."PractitionerRoles" PractitionerRole
    with ("Performing Practitioners from Payor"(requestItem)) Practitioner
    such that PractitionerRole.practitioner.reference.value ~ 'Practitioner/' + Practitioner.id.value

define function "Performing Practitioners via PracitionerRoles"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Provider"."Practitioners" Practitioner
    with ("Performing PractitionerRoles from Payor"(requestItem)) PractitionerRole
    such that PractitionerRole.practitioner.reference.value ~ 'Practitioner/' + Practitioner.id.value

define function "Performing Practitioner IDs from ServiceRequest"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  (
    ("Performing PractitionerRoles from ServiceRequest"(requestItem)) PerformerPractitionerRole
      return Last(Split(PerformerPractitionerRole.practitioner.reference.value, '/'))
  )
  union
  (
    (Ctx.GetPerformer(requestItem)) PerformerPractitioner
      return if (PositionOf('Practitioner/', PerformerPractitioner.reference) >= 0)
        then Last(Split(PerformerPractitioner.reference.value, '/'))
        else null
  ) item where not IsNull(item)

define function "All Performing Practitioners Found"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  IsTrue(
    "Performing Practitioner IDs from ServiceRequest"(requestItem)
      included in (("Performing Practitioners from Provider"(requestItem)) Practitioner return Practitioner.id.value)
  )

define function "Payor Organization via Performing PracitionerRole"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Payor"."Organizations" Organization
    with ("Performing PractitionerRoles from Payor"(requestItem)) PractitionerRole
    such that PractitionerRole.organization.reference.value ~ 'Organization/' + Organization.id.value

define function "Performing Organizations associated with a PracitionerRole"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  Ctx."Payor"."Organizations" Organization
  with ("Performing PractitionerRoles from Payor"(requestItem)) PractitionerRole
  such that PractitionerRole.organization.reference.value ~ 'Organization/' + Organization.id.value

define function "Performing Organizations"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  "Performing Organizations associated with a PracitionerRole"(requestItem)

define function "Matching Performing Organizations by Name & Type or NPI"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Task>):
  ("Performing Organizations"(requestItem)) PerformingOrganization
    with "Payor Organization from Provider Coverage for Patient" PayorOrg
    such that 
      PerformingOrganization.getNpi() ~ PayorOrg.getNpi()
      or (
        PerformingOrganization.name ~ PayorOrg.name 
        and PerformingOrganization.type ~ PayorOrg.type
      )
        // or (PerformingOrganization.name ~ PayorOrg.name and PerformingOrganization.type ~ PayorOrg.type)
        // or PerformingOrganization.getNpi() ~ PayorOrg.getNpi()

define "Payor References by Coverage.payor":
  flatten(Ctx."Provider"."Coverages" C return C.payor.reference.value)

define "Payor Organization from Provider Coverage for Patient":
  Ctx."Provider"."Organizations" O
    with "Payor References by Coverage.payor" R
    such that R = 'Organization/' + O.id.value