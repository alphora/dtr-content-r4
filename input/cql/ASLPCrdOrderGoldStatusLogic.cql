library ASLPCrdOrderGoldStatusLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext version '0.1.0' called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

context Patient

define "Is OrderGoldStatus":
  false

define "Not OrderGoldStatus":
  not ("Is OrderGoldStatus")