library ASLPCrdOrderLOBMatchLogic

using FHIR version '4.0.1'

include ASLPContext called Ctx
include FHIRHelpers version '4.1.000'

context Patient

define "Is OrderLOBMatch":
  exists("Matching Organizations by Name")

define "Not OrderLOBMatch":
  not ("Is OrderLOBMatch")

define "Payor References by Coverage":
  flatten(Ctx."Provider"."Coverages" C return C.payor.reference.value)

define "Provider Payor Organizations by Coverage":
  Ctx."Provider"."Organizations" O
    with "Payor References by Coverage" Reference
    such that EndsWith(Reference, O.id.value)

define "Payor Organizations":
  Ctx."Payor".Organizations

define "Matching Organizations by Name":
  "Provider Payor Organizations by Coverage" ProviderPayorOrg
    with "Payor Organizations" PayorOrg
    such that ProviderPayorOrg.name ~ PayorOrg.name
      // TODO: validate this with Andre
      or ProviderPayorOrg.name in PayorOrg.alias
      or PayorOrg.name in ProviderPayorOrg.alias