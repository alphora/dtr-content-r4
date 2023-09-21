library ASLPCrdProviderNpiMatchLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

context Patient

define "Is ProviderNpiMatch":
  "Requesting Practitioners NPIs Match"
    and "Performing Practitioners NPIs Match"

define "Requesting Practitioners NPIs Match":
  exists("Requesting Practitioners NPIs")
    and "Requesting Practitioners NPIs" included in "Payor Practitioners NPIs"

define "Performing Practitioners NPIs Match":
  "Performing Practitioners NPIs" included in "Payor Practitioners NPIs"

define "Not ProviderNpiMatch":
  not ("Is ProviderNpiMatch")

define "Payor Practitioners NPIs":
  Ctx."Payor"."Practitioners" PP
    return Ctx.GetNPI(PP)

// TODO: update this to include ServiceRequest.requester -> PractitionerRole -> Practitioner?
define "Requesting Practitioners":
  Ctx."Provider"."Practitioners" Practitioner
    with ({ Ctx."Service Request Item".requester }) RequesterPractitioner
    such that RequesterPractitioner.reference.getId() ~ Practitioner.id.value

define "Requesting Practitioners NPIs":
  "Requesting Practitioners" RP
    return Ctx.GetNPI(RP)
    
// TODO: update this to include ServiceRequest.performer -> PractitionerRole -> Practitioner?
define "Performing Practitioners":
  Ctx."Provider"."Practitioners" Practitioner
    with Ctx."Service Request Item".performer PractitionerPerformer
    such that PractitionerPerformer.reference.getId() ~ Practitioner.id.value

define "Performing Practitioners NPIs":
  "Performing Practitioners" RP
    return Ctx.GetNPI(RP)