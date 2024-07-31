// Alias: $plan-definition-type = http://terminology.hl7.org/CodeSystem/plan-definition-type
// Alias: $usage-context-type = http://terminology.hl7.org/CodeSystem/usage-context-type
// Alias: $activity-codes = http://fhir.org/guides/nachc/hiv-cds/CodeSystem/activity-codes
// Alias: $iso3166-1-3 = http://hl7.org/fhir/ValueSet/iso3166-1-3

// Instance: ASLPContext
// InstanceOf: Library
// * status = #draft
// * type = #logic-library

// Instance: ASLPCrdMultipleRequestLogic
// InstanceOf: Library
// * status = #draft
// * type = #logic-library

// Instance: ASLPCrdMemberEligibleLogic
// InstanceOf: Library
// * status = #draft
// * type = #logic-library

// Instance: ASLPCrdProviderNpiMatchLogic
// InstanceOf: Library
// * status = #draft
// * type = #logic-library

// Instance: ASLPCrdOrderLOBMatchLogic
// InstanceOf: Library
// * status = #draft
// * type = #logic-library

// Instance: ASLPCrdOrderGoldStatusLogic
// InstanceOf: Library
// * status = #draft
// * type = #logic-library

// Instance: ASLPCrdRoutineLogic
// InstanceOf: Library
// * status = #draft
// * type = #logic-library

// Instance: ASLPCrdOnPriorAuthListLogic
// InstanceOf: Library
// * status = #draft
// * type = #logic-library

// RuleSet: CpgCommonProperties
// * extension[+]
//   * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
//   * valueCode = #computable
// * identifier[+]
//   * use = #official
//   * value = "generate-crd-example"
// * version = "1.0.0"
// * status = #draft
// * experimental = true
// * useContext
//   * code = $usage-context-type#task "Workflow Task"
//   // TODO: this should be an argument or part of a different ruleset
//   * valueCodeableConcept = $activity-codes#ASLP.A1 "Adult Sleep Studies"
// * publisher = "Smile Digital Health"
// * jurisdiction
//   * coding[+]
//     * version = "4.0.1"
//     * system = $iso3166-1-3
//     * code = #USA
//     * display = "United States of America"
// * usage = "This is to be used in conjunction with a patient-facing FHIR application."

// RuleSet: CpgIdentifier(name)
// * name = "{name}"
// * url = Canonical({name})
// * purpose = "Purpose for {name}"
// * description = "Description for {name}"

// RuleSet: ActionTrigger(name)
// * trigger
//   * type = #named-event
//   * name = "{name}"

// RuleSet: ActionConditionCql(expression)
// * condition
//   * kind = #applicability
//   * expression
//     * language = #text/cql-identifier
//     * expression = {expression}

// RuleSet: ExpressionCql(expression)
// * expression
//   * language = #text/cql-identifier
//   * expression = {expression}

// // Instance: ASLPCrd-Crd-2-Stub
// // InstanceOf: CPGComputableActivityDefinition
// // Usage: #example
// // * insert CpgCommonProperties
// // * insert CpgIdentifier(ASLPCrd-Crd-2-Stub)

// // //* library[+] = Canonical(ASLPCrd)

// // * kind = #CommunicationRequest
// // * profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-communicationrequest"
// // * description = """
// //   The member cannot be found.
// //   PA is required.
// //   You can submit a PA request as an exception.
// //   CRD link to the form
// //   Reference ID
// //   Session exits
// //   """

// // Instance: ASLPCrd-Crd-3-1-Stub
// // InstanceOf: CPGComputableActivityDefinition
// // Usage: #example
// // * insert CpgCommonProperties
// // * insert CpgIdentifier(ASLPCrd-Crd-3-1-Stub)

// // * kind = #CommunicationRequest
// // * profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-communicationrequest"
// // * description = """
// //   Provider is not in the network.
// //   PA is required.
// //   You can submit a PA request as an exception.
// //   CRD link to the form
// //   Reference ID
// //   Session exits
// //   """

// // Instance: ASLPCrd-Crd-3-2-Stub
// // InstanceOf: CPGComputableActivityDefinition
// // Usage: #example
// // * insert CpgCommonProperties
// // * insert CpgIdentifier(ASLPCrd-Crd-3-2-Stub)

// // * kind = #CommunicationRequest
// // * profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-communicationrequest"
// // * description = """
// //   Additional requirements disclosure (if any).
// //   PA is required.
// //   CRD link to the form
// //   Reference ID
// //   Session exits
// //   """

// // Instance: ASLPCrd-Crd-4-Stub
// // InstanceOf: CPGComputableActivityDefinition
// // Usage: #example
// // * insert CpgCommonProperties
// // * insert CpgIdentifier(ASLPCrd-Crd-4-Stub)

// // * kind = #CommunicationRequest
// // * profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-communicationrequest"
// // * description = """
// //   Provider is Gold Card.
// //   PA is not required for this service.
// //   Reference ID
// //   Session exits
// //   """

// // Instance: ASLPCrd-Crd-7-Stub
// // InstanceOf: CPGComputableActivityDefinition
// // Usage: #example
// // * insert CpgCommonProperties
// // * insert CpgIdentifier(ASLPCrd-Crd-7-Stub)

// // * kind = #CommunicationRequest
// // * profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-communicationrequest"
// // * description = """
// //   Routine service code.
// //   PA is not required for this service.
// //   Bypass to order, scheduling, or referral
// //   """

// // Instance: ASLPCrd-Crd-6-Stub
// // InstanceOf: CPGComputableActivityDefinition
// // Usage: #example
// // * insert CpgCommonProperties
// // * insert CpgIdentifier(ASLPCrd-Crd-6-Stub)

// // * kind = #CommunicationRequest
// // * profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-communicationrequest"
// // * description = """
// //   Code not found please contact the payer for further information.
// //   Reference ID
// //   Session exits
// //   """

// // Instance: ASLPCrd-Crd-5-Stub
// // InstanceOf: CPGComputableActivityDefinition
// // Usage: #example
// // * insert CpgCommonProperties
// // * insert CpgIdentifier(ASLPCrd-Crd-5-Stub)

// // * kind = #CommunicationRequest
// // * profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-communicationrequest"
// // * description = """
// //   Prior authorization is required.
// //   [Additional requiremets/disclaimer.]
// //   CRD link to the form
// //   Reference ID
// //   Session exits
// //   """

// Instance: ASLPCrd-CdsHook
// InstanceOf: CPGComputablePlanDefinition
// Usage: #example
// * insert CpgCommonProperties
// * insert CpgIdentifier(ASLPCrd-CdsHook)

// * type = $plan-definition-type#eca-rule "ECA Rule"
// // required by _refresh.sh
// * library[+] = Canonical(ASLPContext)

// // Define more specific Purpose/Description
// * purpose = "The purpose of this is to test the system to make sure we have complete end-to-end functionality"
// * description = "Test the system to make sure we have complete end-to-end functionality"

// * action[+]
//   * insert ActionTrigger(order-sign)
//   // Multiple Request (ServiceRequest, DeviceRequest, NutritionOrder)
//   * definitionCanonical = Canonical(ASLPCrd-MultipleRequest)
//   // Single Request
//   //* definitionCanonical = Canonical(ASLPCrd-MemberEligible)

// Instance: ASLPCrd-MultipleRequest
// InstanceOf: CPGComputablePlanDefinition
// Usage: #example
// * insert CpgCommonProperties
// * insert CpgIdentifier(ASLPCrd-MultipleRequest)

// * type = $plan-definition-type#eca-rule "ECA Rule"
// * library[+] = Canonical(ASLPCrdMultipleRequestLogic)

// * action[+]
//   * title = "Prior Auth Evaluation"
//   * description = "Information related to whether a service is covered, not covered or requires prior auth submission"
//   * dynamicValue[+]
//     * path = "title"
//     * insert ExpressionCql("Title")
//   * dynamicValue[+]
//     * path = "description"
//     * insert ExpressionCql("Description")
//   * dynamicValue[+]
//     * path = "extension"
//     * insert ExpressionCql("CoverageExtensionList")

// Instance: ASLPCrd-MemberEligible
// InstanceOf: CPGComputablePlanDefinition
// Usage: #example
// * insert CpgCommonProperties
// * insert CpgIdentifier(ASLPCrd-MemberEligible)

// * type = $plan-definition-type#eca-rule "ECA Rule"
// * library[+] = Canonical(ASLPCrdMemberEligibleLogic)

// * action[+]
//   * insert ActionConditionCql("Is MemberEligible")
//   * title = "Member Eligible"
//   * description = "Member Eligible"
//   * definitionCanonical = Canonical(ASLPCrd-OrderLOBMatch)
// * action[+]
//   * insert ActionConditionCql("Not MemberEligible")
//   * title = "Not Member Eligible"
//   * description = "Not Member Eligible"
//   * dynamicValue[+]
//     * path = "title"
//     * insert ExpressionCql("Title")
//   * dynamicValue[+]
//     * path = "description"
//     * insert ExpressionCql("Description")
//   * dynamicValue[+]
//     * path = "extension"
//     * insert ExpressionCql("CoverageExtension")

// Instance: ASLPCrd-ProviderNpiMatch
// InstanceOf: CPGComputablePlanDefinition
// Usage: #example
// * insert CpgCommonProperties
// * insert CpgIdentifier(ASLPCrd-ProviderNpiMatch)

// * type = $plan-definition-type#eca-rule "ECA Rule"
// * library[+] = Canonical(ASLPCrdProviderNpiMatchLogic)

// * action[+]
//   * insert ActionConditionCql("Is ProviderNpiMatch")
//   * title = "Provider Npi Match"
//   * description = "Provider Npi Match"
//   * definitionCanonical = Canonical(ASLPCrd-OrderGoldStatus)
// * action[+]
//   * insert ActionConditionCql("Not ProviderNpiMatch")
//   * title = "Not Provider Npi Match"
//   * description = "Not Provider Npi Match"
//   * dynamicValue[+]
//     * path = "title"
//     * insert ExpressionCql("Title")
//   * dynamicValue[+]
//     * path = "description"
//     * insert ExpressionCql("Description")
//   * dynamicValue[+]
//     * path = "extension"
//     * insert ExpressionCql("CoverageExtension")

// Instance: ASLPCrd-OrderLOBMatch
// InstanceOf: CPGComputablePlanDefinition
// Usage: #example
// * insert CpgCommonProperties
// * insert CpgIdentifier(ASLPCrd-OrderLOBMatch)

// * type = $plan-definition-type#eca-rule "ECA Rule"
// * library[+] = Canonical(ASLPCrdOrderLOBMatchLogic)

// * action[+]
//   * insert ActionConditionCql("Is OrderLOBMatch")
//   * title = "Order LOB Match"
//   * description = "Order LOB Match"
//   * definitionCanonical = Canonical(ASLPCrd-ProviderNpiMatch)
// * action[+]
//   * insert ActionConditionCql("Not OrderLOBMatch")
//   * title = "Not Order LOB Match"
//   * description = "Not Order LOB Match"
//   * dynamicValue[+]
//     * path = "title"
//     * insert ExpressionCql("Title")
//   * dynamicValue[+]
//     * path = "description"
//     * insert ExpressionCql("Description")
//   * dynamicValue[+]
//     * path = "extension"
//     * insert ExpressionCql("CoverageExtension")

// Instance: ASLPCrd-OrderGoldStatus
// InstanceOf: CPGComputablePlanDefinition
// Usage: #example
// * insert CpgCommonProperties
// * insert CpgIdentifier(ASLPCrd-OrderGoldStatus)

// * type = $plan-definition-type#eca-rule "ECA Rule"
// * library[+] = Canonical(ASLPCrdOrderGoldStatusLogic)

// * action[+]
//   * insert ActionConditionCql("Is OrderGoldStatus")
//   * title = "Order Gold Status"
//   * description = "Order Gold Status"
//   * dynamicValue[+]
//     * path = "title"
//     * insert ExpressionCql("Title")
//   * dynamicValue[+]
//     * path = "description"
//     * insert ExpressionCql("Description")
//   * dynamicValue[+]
//     * path = "extension"
//     * insert ExpressionCql("CoverageExtension")
// * action[+]
//   * insert ActionConditionCql("Not OrderGoldStatus")
//   * title = "Not Order Gold Status"
//   * description = "Not Order Gold Status"
//   * definitionCanonical = Canonical(ASLPCrd-Routine)

// Instance: ASLPCrd-Routine
// InstanceOf: CPGComputablePlanDefinition
// Usage: #example
// * insert CpgCommonProperties
// * insert CpgIdentifier(ASLPCrd-Routine)

// * type = $plan-definition-type#eca-rule "ECA Rule"
// * library[+] = Canonical(ASLPCrdRoutineLogic)

// * action[+]
//   * insert ActionConditionCql("Is Routine")
//   * title = "Routine"
//   * description = "Routine"
//   * dynamicValue[+]
//     * path = "title"
//     * insert ExpressionCql("Title")
//   * dynamicValue[+]
//     * path = "description"
//     * insert ExpressionCql("Description")
//   * dynamicValue[+]
//     * path = "extension"
//     * insert ExpressionCql("CoverageExtension")
// * action[+]
//   * insert ActionConditionCql("Not Routine")
//   * title = "Not Routine"
//   * description = "Not Routine"
//   * definitionCanonical = Canonical(ASLPCrd-OnPriorAuthList)

// Instance: ASLPCrd-OnPriorAuthList
// InstanceOf: CPGComputablePlanDefinition
// Usage: #example
// * insert CpgCommonProperties
// * insert CpgIdentifier(ASLPCrd-OnPriorAuthList)

// * type = $plan-definition-type#eca-rule "ECA Rule"
// * library[+] = Canonical(ASLPCrdOnPriorAuthListLogic)

// * action[+]
//   * insert ActionConditionCql("Is OnPriorAuthList")
//   * title = "On Prior Auth List"
//   * description = "On Prior Auth List"
//   * dynamicValue[+]
//     * path = "title"
//     * insert ExpressionCql("Title")
//   * dynamicValue[+]
//     * path = "description"
//     * insert ExpressionCql("Description")
//   * dynamicValue[+]
//     * path = "extension"
//     * insert ExpressionCql("CoverageExtension")
// * action[+]
//   * insert ActionConditionCql("Not OnPriorAuthList")
//   * title = "Not On Prior Auth List"
//   * description = "Not On Prior Auth List"
//   * dynamicValue[+]
//     * path = "title"
//     * insert ExpressionCql("Title-NotFound")
//   * dynamicValue[+]
//     * path = "description"
//     * insert ExpressionCql("Description-NotFound")
//   * dynamicValue[+]
//     * path = "extension"
//     * insert ExpressionCql("CoverageExtension-NotFound")