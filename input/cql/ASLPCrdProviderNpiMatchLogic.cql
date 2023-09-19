library ASLPCrdProviderNpiMatchLogic

using FHIR version '4.0.1'

include ASLPContext called Ctx
include FHIRHelpers version '4.1.000'

context Patient

define "Is ProviderNpiMatch":
  "Requesting Practitioners NPIs" included in "Payor Practitioners NPIs"

define "Not ProviderNpiMatch":
  not ("Is ProviderNpiMatch")

define "Requesting Practitioners":
  Ctx."Provider"."Practitioners" P
    where exists(Ctx."Service Request".requester.reference R where EndsWith(R, P.id.value))

define "Requesting Practitioners NPIs":
  "Requesting Practitioners" RP
    return Ctx.GetNPI(RP)

define "Payor Practitioners NPIs":
  Ctx."Payor"."Practitioners" PP
    return Ctx.GetNPI(PP)