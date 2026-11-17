library ASLPCrdEvaluationLogic version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

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
        (([MedicationRequest]).medication).coding.display,
        ', '
    )