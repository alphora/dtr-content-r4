library ASLPCrdMemberEligibleLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

// CRD-2
define "Title":
  'Member Not Found'

// CRD-2
define "Description":
  '- The member cannot be found.' + Ctx."NewLine" +
  '- You can submit a PA request as an exception.'

// CRD-2
define "Qualification":
  'Prior auth is required for: ' + Ctx."Service Request Item ID"

// CRD-2
define "CoverageExtension":
  Ctx."ExtensionPriorAuthNeeded"('conditional', 'auth-needed', 'auth-needed', "Qualification", 'Warning')

define "Is MemberEligible":
  "Last Name Match" and "DOB Match"

define "Not MemberEligible":
  not ("Is MemberEligible")

// Compares the two lists of Family Name strings, and returns true if at least one Family Name matches
define "Last Name Match":
  // New logic - Any last name intersection 
  exists(Ctx."Payor"."Patient".name.family intersect Ctx."Provider"."Patient".name.family)
  // Current logic, for reference only - CRD250
  // Ctx."Provider"."Patient".name[0].family ~ Ctx."Payor"."Patient".name[0].family

define "DOB Match":
  IsTrue(
    (days between Ctx."Payor"."Patient".birthDate and Ctx."Provider"."Patient".birthDate) = 0
  )
