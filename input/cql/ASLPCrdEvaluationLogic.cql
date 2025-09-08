library ASLPCrdEvaluationLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

define "Title":
  'Prior Auth Evaluation'

define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission' 

define "Detail Text 9":
  'Prior authorization may be required based on the patient`s coverage policy.'

define "Qualification 9":
  'Authorization and coverage depend on the applicable policy. Additional information may be needed to confirm requirements.'

define "Detail Debugging":
  'Not yet implemented.'

define "Medication List":
    Combine(    
        ([MedicationRequest]).medication.coding.display,
        ', '
    )