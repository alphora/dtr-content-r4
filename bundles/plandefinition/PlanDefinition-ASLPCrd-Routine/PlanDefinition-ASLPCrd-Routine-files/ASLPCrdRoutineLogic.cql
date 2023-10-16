library ASLPCrdRoutineLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

valueset "Routine Procedure Valueset": 'http://terminology.smilecdr.com/cs/routine'

context Patient

// CRD-7
define "Title":
  'Prior Authorization Not Required'

// CRD-7
define "Description":
  '- Order is covered.' + Ctx."NewLine" +
  '- No prior auth is required for: ' + Ctx."Service Request Item Code".code + '.'

// CRD-7
define "Qualification":
  'Prior auth is not required for: ' + Ctx."Service Request Item ID"

// CRD-7
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('covered', 'no-auth', 'no-auth', "Qualification", 'info')

define "Is Routine":
  exists("Routine Service Requests")

define "Not Routine":
  not ("Is Routine")

define "Routine Service Requests":
  ({ Ctx."Service Request Item" }) R
    where R.code in "Routine Procedure Valueset"