library ASLPCrdOnPriorAuthListLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

valueset "Prior Auth Required for Procedure Valueset": 'http://terminology.smilecdr.com/cs/priorauth'

context Patient

// CRD-6
define "Title-NotFound":
  "Title"
  
// CRD-6
define "Description-NotFound":
  "Description"

// CRD-6
define "Qualification-NotFound":
  Ctx."Service Request Item Code".display + ' is not a recognized procedure electronically. Please contact the payer for further information.'
  
// CRD-6
define "Detail Text-NotFound":
  'Code Not Found'

// CRD-6
define "CoverageExtension-NotFound":
  Ctx."ExtensionPriorAuthNeeded"('not-covered', 'conditional', 'not-covered', "Detail Text-NotFound", "Qualification-NotFound", 'Warning')

// CRD-5
define "Title":
  'Prior Auth Evaluation'

// CRD-5
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission' 

// CRD-5
define "Detail Text":
  'Prior Authorization Required'

// CRD-5
define "Qualification":
  'Prior authorization is required for ' + Ctx."Service Request Item Code".display

// CRD-5
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('conditional', 'auth-needed', 'auth-needed', "Detail Text", "Qualification", 'Warning')

define "Is OnPriorAuthList":
  exists("Prior Auth Required Service Requests")

define "Not OnPriorAuthList":
  not ("Is OnPriorAuthList")

define "Prior Auth Required Service Requests":
  ({ Ctx."Service Request Item" }) R
    where (Ctx.GetCode(R)) in "Prior Auth Required for Procedure Valueset"