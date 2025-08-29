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
  'Prior Auth Evaluation'

// CRD-2
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

// CRD-2
define "Detail Text":
  'Member Not Found'

// CRD-2
define "Qualification":
  'The member cannot be found. You can submit a PA request as an exception.'

// CRD-2
define "Detail Debugging":
  'Ctx."Payor"."Patient".id=' + Ctx."Payor"."Patient".id + Ctx.NewLine +
  'Ctx."Payor"."Patient".birthDate=' + ToString(Ctx."Payor"."Patient".birthDate.value) + Ctx.NewLine +
  'Ctx."Payor"."Patient".name.family=' + Combine(Ctx."Payor"."Patient".name.family, '|') + Ctx.NewLine +
  'Ctx."Provider"."Patient".id=' + Ctx."Provider"."Patient".id + Ctx.NewLine +
  'Ctx."Provider"."Patient".birthDate=' + ToString(Ctx."Provider"."Patient".birthDate.value) + Ctx.NewLine +
  'Ctx."Provider"."Patient".name.family=' + Combine(Ctx."Provider"."Patient".name.family, '|') + Ctx.NewLine 

// CRD-2
define function "CoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.CommunicationRequest, FHIR.VisionPrescription>):
  Ctx."ExtensionPriorAuthNeeded"(requestItem, 'conditional', 'auth-needed', 'auth-needed', "Detail Text", "Qualification", 'Warning')

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
