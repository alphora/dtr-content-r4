library ASLPCrdMedicationRequestLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

// CRD-MedicationRequest
define "Title":
  'Prior Auth Evaluation'

// CRD-MedicationRequest
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission' 

// CRD-MedicationRequest
define "Detail Text 9":
  'Prior authorization requirement and coverage determination for medications are pending, subject to the medication coverage policy.'

// CRD-MedicationRequest
define "Qualification 9":
    'The requirement for prior authorization and coverage for medications are determined by the applicable policy.'

define "Detail Debugging":
  'Not yet implemented.'

define "Medication List":
    Combine(    
        ([MedicationRequest]).medication.coding.display,
        ', '
    )