library ASLPCrdRoutineLogic

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'

context Patient

define "Is Routine":
  false

define "Not Routine":
  not ("Is Routine")