library ASLPCrdOrderLOBMatchLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

// CRD-3.2
define "Title":
  'Prior Auth Evaluation'

// CRD-3.2
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

// CRD-3.2
define "Qualification":
  'Line of Business MisMatch. Prior authorization submission is required.'

// CRD-3.2
define "Detail Debugging":
  '"Is OrderLOBMatch"=' + Ctx.NewLine + ToString("Is OrderLOBMatch")  + Ctx.NewLine +
  '  - "Matching Organizations by Name".npi()=' + Ctx.NewLine + Combine("Matching Organizations by Name".npi(), ',')  + Ctx.NewLine +
  '  - "Provider References by Coverage.payor"=' + Ctx.NewLine + Combine("Provider References by Coverage.payor", ',')  + Ctx.NewLine +
  '  - "Provider Organizations by Coverage.payor".npi()=' + Ctx.NewLine + Combine("Provider Organizations by Coverage.payor".npi(), ',')  + Ctx.NewLine +
  '  - "Payor Organizations by Coverage.payor".npi()=' + Ctx.NewLine + Combine("Payor Organizations by Coverage.payor".npi(), ',')  + Ctx.NewLine

// CRD-3.2
define "Detail Text":
  'Line Of Business Mismatch'

// CRD-3.2
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'conditional', 'auth-needed', 'auth-needed', "Detail Text", "Qualification", 'Warning')

define "Is OrderLOBMatch":
  exists("Matching Organizations by Name")

define "Not OrderLOBMatch":
  not ("Is OrderLOBMatch")

define "Provider References by Coverage.payor":
  flatten(Ctx."Provider"."Coverages" C return C.payor.reference.value)

define "Provider Organizations by Coverage.payor":
  Ctx."Provider"."Organizations" O
    with "Provider References by Coverage.payor" R
    such that R.getId() = O.id.value

define "Payor References by Coverage.payor":
  flatten(Ctx."Payor"."Coverages" C return C.payor.reference.value)

define "Payor Organizations by Coverage.payor":
  Ctx."Payor"."Organizations" O
    with "Payor References by Coverage.payor" R
    such that R.getId() = O.id.value

define "Matching Organizations by Name":
  "Provider Organizations by Coverage.payor" ProviderPayorOrg
    with "Payor Organizations by Coverage.payor" PayorOrg
    such that 
      ProviderPayorOrg.name ~ PayorOrg.name
      // NOTE: Do not allow matching on Organization.alias
      // NOTE: Could refine more when we have a Payor integration
      /*
        or ProviderPayorOrg.name in PayorOrg.alias
        or PayorOrg.name in ProviderPayorOrg.alias
        or exists(PayorOrg.alias intersect ProviderPayorOrg.alias)
      */