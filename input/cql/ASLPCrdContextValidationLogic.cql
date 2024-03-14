library ASLPCrdContextValidationLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

// CRD-8
define "Title":
  'Prior Auth Evaluation'

// CRD-8
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

// CRD-8 // detail.code.text
define "Detail Text 8":
  'Submit Prior Authorization Form'

// CRD-8 // detail.qualification
define "Qualification 8":
  'Unable to process due to incomplete/ambiguous information. Please submit a prior auth form.'

// CRD-8.1 // detail.code.text
define "Detail Text 8.1":
  'Error has occurred. No order found.'

// CRD-8.1 // detail.qualification
define "Qualification 8.1":
  'Error has occurred. No order found. Please contact your system administrator.'

// CRD-8.3 // detail.code.text
define "Detail Text 8.3":
  'Unable to Process Request electronically.'

// CRD-8.3 // detail.qualification
define "Qualification 8.3":
  'Unable to Process Request electronically. Please contact the payer.'

// CRD-8
define "Detail Debugging":
  'Not yet implemented.'

define "Insufficient or Ambiguous High":
  true

define "DomainResource is Empty":
  true

define "Received Provider Data Cannot be Processed":
  true
