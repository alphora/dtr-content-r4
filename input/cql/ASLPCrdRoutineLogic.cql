library ASLPCrdRoutineLogic

using FHIR version '4.0.1'

include ASLPContext called Ctx
include FHIRHelpers version '4.1.000'

context Patient

define "Is Routine":
  false

define "Not Routine":
  not ("Is Routine")