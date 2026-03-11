library ASLPCrdOrderGoldStatusLogic version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include ASLPContext version '0.1.0' called Ctx
include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

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
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.Appointment>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'covered', 'no-auth', 'gold-card', "Detail Text", "Qualification", 'info')

define "Is OrderGoldStatus":
  false
  // TODO: Remove this in production environment
  //EndsWith(Ctx."Provider"."Patient".id.value, 'gold-card')

define "Not OrderGoldStatus":
  not ("Is OrderGoldStatus")