library ASLPCrdMemberEligibleLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext version '0.1.0' called Ctx
include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

context Patient

define "Is MemberEligible":
  "Last Name Match" and "DOB Match"

define "Not MemberEligible":
  not ("Is MemberEligible")

define "CoverageExtension":
  Ctx."ExtensionPriorAuthNotNeeded"(First(Ctx."Provider"."Coverages").id)

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
