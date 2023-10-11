library ASLPCrdOnPriorAuthListLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext version '0.1.0' called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

valueset "Prior Auth Required for Procedure Valueset": 'http://terminology.smilecdr.com/cs/priorauth'

context Patient

define "Is OnPriorAuthList":
  exists("Prior Auth Required Service Requests")

define "Not OnPriorAuthList":
  not ("Is OnPriorAuthList")

define "Prior Auth Required Service Requests":
  ({ Ctx."Service Request Item" }) R
    where R.code in "Prior Auth Required for Procedure Valueset"