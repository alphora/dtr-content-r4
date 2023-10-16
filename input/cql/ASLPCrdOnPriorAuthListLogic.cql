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
  'Code not found'

// CRD-6
define "Description-NotFound":
  '' + Ctx."Service Request Item Code".display + ' is not a recognized procedure electronically.' + Ctx."NewLine" +
  '- Please contact the payer for further information.'

// CRD-6
define "Qualification-NotFound":
  'No coverage determination as code could not be found electronically in payer database; please reach out to Payer directly.'

// CRD-6
define "CoverageExtension-NotFound":
  Ctx."ExtensionPriorAuthNeeded"('not-covered', 'conditional', 'not-covered', "Qualification-NotFound", 'Warning')

// CRD-5
define "Title":
  'Prior Authorization Required'

// CRD-5
define "Description":
  '- Prior authorization is required for ' + Ctx."Service Request Item Code".display + '.' + Ctx."NewLine" +
  // TODO: To discuss this option:
  '- To discuss this option: Prior authorization is required for Provider Order ' + Ctx."Service Request Item ID" + '.'

// CRD-5
define "Qualification":
  'Prior auth is required for: ' + Ctx."Service Request Item ID"

// CRD-5
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('conditional', 'auth-needed', 'auth-needed', "Qualification", 'Warning')

define "Is OnPriorAuthList":
  exists("Prior Auth Required Service Requests")

define "Not OnPriorAuthList":
  not ("Is OnPriorAuthList")

define "Prior Auth Required Service Requests":
  ({ Ctx."Service Request Item" }) R
    where R.code in "Prior Auth Required for Procedure Valueset"