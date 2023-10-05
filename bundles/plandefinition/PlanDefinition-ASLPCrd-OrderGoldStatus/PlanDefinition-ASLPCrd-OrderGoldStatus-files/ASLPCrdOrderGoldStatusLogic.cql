library ASLPCrdOrderGoldStatusLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

context Patient

// CRD-4
define "Title":
  'Provider is Gold Carded'

// CRD-4
define "Description":
  '- Ordering Provider has Gold Card status for this service.' + Ctx."NewLine" +
  '- Provider Order [' + Ctx."Service Request Item Code".code + ']' + Ctx.NewLine +
  '- Prior Auth is Not Required.'

// CRD-4
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNotNeeded"('covered', "Title")

define "Is OrderGoldStatus":
  false

define "Not OrderGoldStatus":
  not ("Is OrderGoldStatus")