library ASLPCrdRoutineLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

valueset "Routine Procedure Valueset": 'http://terminology.smilecdr.com/cs/routine'

context Patient

define "Is Routine":
  exists("Routine Service Requests")

define "Not Routine":
  not ("Is Routine")

define "Routine Service Requests":
  ({ Ctx."Service Request Item" }) R
    where R.code in "Routine Procedure Valueset"