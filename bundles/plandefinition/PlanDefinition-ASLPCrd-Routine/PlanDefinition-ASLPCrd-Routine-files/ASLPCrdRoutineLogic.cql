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
  'Prior Auth Evaluation'

// CRD-7
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission' 

// CRD-7
define "Qualification":
  'Order is covered. No prior auth is required for ' + Ctx."Service Request Item Code".display + '.'

// CRD-7
define "Detail Text":
  'Prior Authorization Not Required'

// CRD-7
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('covered', 'no-auth', 'no-auth', "Detail Text", "Qualification", 'info')

define "Is Routine":
  exists("Routine Service Requests")

define "Not Routine":
  not ("Is Routine")

define "Routine Service Requests":
  ({ Ctx."Service Request Item" }) R
    where R.code in "Routine Procedure Valueset"