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
  'Prior Auth Evaluation'

// CRD-4
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

// CRD-4
define "Detail Text":
  'Provider is Gold Carded'

// CRD-4
define "Qualification":
  'Ordering Practitioner has been granted \'gold card\' status with this payer/coverage type. Prior Auth is Not Required.'

// CRD-4
define "Detail Debugging":
  'Not yet implemented.'

// CRD-4
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'covered', 'no-auth', 'gold-card', "Detail Text", "Qualification", 'info')

define "Is OrderGoldStatus":
  false
  // TODO: Remove this in production environment
  //EndsWith(Ctx."Provider"."Patient".id.value, 'gold-card')

define "Not OrderGoldStatus":
  not ("Is OrderGoldStatus")