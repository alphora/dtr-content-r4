library ASLPCrdOnPriorAuthListLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

valueset "Prior Auth Required for Procedure Valueset": 'http://terminology.smilecdr.com/cs/priorauth'

context Patient

// CRD-6
define "Title-NotFound":
  'Code not found'

// CRD-6
define "Description-NotFound":
  '[' + Ctx."Service Request Item Code".code + '] is not a recognized procedure electronically.' + Ctx."NewLine" +
  '- Please contact the payer for further information.'

// CRD-6
define "CoverageExtension-NotFound":
  Ctx."ExtensionPriorAuthNotNeeded"('not-covered', "Title")

// CRD-5
define "Title":
  'Prior Authorization Required'

// CRD-5
define "Description":
  '- Prior authorization is required for [' + Ctx."Service Request Item Code".code + '].' + Ctx."NewLine" +
  // TODO: To discuss this option:
  '- To discuss this option: Prior authorization is required for Provider Order [' + Ctx."Service Request Item Code".code + ']'

// CRD-5
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('conditional', "Title")

define "Is OnPriorAuthList":
  exists("Prior Auth Required Service Requests")

define "Not OnPriorAuthList":
  not ("Is OnPriorAuthList")

define "Prior Auth Required Service Requests":
  ({ Ctx."Service Request Item" }) R
    where R.code in "Prior Auth Required for Procedure Valueset"