library ASLPCrdMemberEligibleLogic

using FHIR version '4.0.1'

include ASLPContext called Ctx
include FHIRHelpers version '4.1.000'

context Patient

define "Is MemberEligible":
  "Last Name Match" and "DOB Match"

define "Not MemberEligible":
  not ("Is MemberEligible")

define "Last Name Match":
  exists(Ctx."Payor"."Patient".name.family intersect Ctx."Provider"."Patient".name.family)

define "DOB Match":
  IsTrue(
    (days between Ctx."Payor"."Patient".birthDate and Ctx."Provider"."Patient".birthDate) = 0
  )
