library ASLPCrdMemberEligibleLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include FHIRHelpers version '4.1.000'

context Patient

define "Is MemberEligible":
  "Last Name Match" and "DOB Match"

define "Not MemberEligible":
  not ("Is MemberEligible")

// TODO: ensure that only one matching last name is required
// Compares the two lists of Family Name strings, and returns true if at least one Family Name matches
define "Last Name Match":
  exists(Ctx."Payor"."Patient".name.family intersect Ctx."Provider"."Patient".name.family)

define "DOB Match":
  IsTrue(
    (days between Ctx."Payor"."Patient".birthDate and Ctx."Provider"."Patient".birthDate) = 0
  )
