library ASLPCrdOrderGoldStatusLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

// CRD-4
define "Title":
  'Provider is Gold Carded'

// CRD-4
define "Description":
  '- Ordering Provider has Gold Card status for this service.' + Ctx."NewLine" +
  '- Provider Order ' + Ctx."Service Request Item ID" + '.' + Ctx.NewLine +
  '- Prior Auth is Not Required.'

// CRD-4
define "Qualification":
  'Ordering Practitioner has been granted \'gold card\' status with this payer/coverage type.'

// CRD-4
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('covered', 'no-auth', 'gold-card', "Qualification", 'info')

define "Is OrderGoldStatus":
  // TODO: Remove this in production environment
  Ctx."Provider"."Patient".id.value ~ 'crd-4-gold-card'

define "Not OrderGoldStatus":
  not ("Is OrderGoldStatus")