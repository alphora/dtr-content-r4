library ASLPCrdMultipleRequestLogic

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include ASLPContext called Ctx
include ASLPCrdMemberEligibleLogic called MemberEligible
include ASLPCrdOrderLOBMatchLogic called OrderLOBMatch
include ASLPCrdProviderNpiMatchLogic called NpiMatch
include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient
        
// CRD Matrix of values
define "CRD Matrix":
  {
    "CRD-2": {
      "ID": 'CRD-2',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": 'Member Not Found', 
      "DetailQualification": 'The member cannot be found. You can submit a PA request as an exception.',
      "DetailValue": 'Warning'
    },
    "CRD-3.2": { 
      "ID": 'CRD-3.2',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": 'Line Of Business Mismatch', 
      "DetailQualification": 'Line of Business MisMatch. Prior authorization submission is required.',
      "DetailValue": 'Warning'
    },
    "CRD-3.1": { 
      "ID": 'CRD-3.1',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": 'Provider Not in Network', 
      "DetailQualification": 'Provider is not in the network. You can submit a PA request as an exception.',
      "DetailValue": 'Warning'
    },
    /* 
    
    */
    "CRD-NotYetImplemented": { 
      "ID": 'CRD-NotYetImplemented',
      "Covered": 'conditional', 
      "PriorAuthNeeded": 'auth-needed', 
      "DetailCode": 'auth-needed', 
      "DetailText": 'Undefined', 
      "DetailQualification": 'Placeholder',
      "DetailValue": 'Warning'
    } 
  }

// CRD Static text
define "Title":
  'Prior Auth Evaluation'

// CRD Static text
define "Description":
  'Information related to whether a service is covered, not covered or requires prior auth submission'

// CRD Coverage Extensions
define "CoverageExtensionList":
  Ctx."Service Request Item List" RequestItem
    return all
      //RequestItem.id.value
      (GetCrdResult(RequestItem)).ID
      //"GetCoverageExtension"(RequestItem, GetCrdResult(RequestItem))

// CRD Logic tree
define function GetCrdResult(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>)
returns Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailValue" System.String}:
  if (MemberEligible."Not MemberEligible") then
    "CRD Matrix"."CRD-2"
  else if (OrderLOBMatch."Not OrderLOBMatch") then
    "CRD Matrix"."CRD-3.2"
  else if (NpiMatch."Not ProviderNpiMatch"(requestItem)) then
    "CRD Matrix"."CRD-3.1"
  else
    "CRD Matrix"."CRD-NotYetImplemented"

define function "GetCoverageExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest>, item Tuple{"ID" System.String, "Covered" System.String, "PriorAuthNeeded" System.String, "DetailCode" System.String, "DetailText" System.String, "DetailQualification" System.String, "DetailValue" System.String})
returns FHIR.Extension:
  Ctx."ExtensionPriorAuthNeeded"(
    requestItem,
    item."Covered", 
    item."PriorAuthNeeded", 
    item."DetailCode", 
    item."DetailText", 
    item."DetailQualification", 
    item."DetailValue"
  )