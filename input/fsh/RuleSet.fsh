RuleSet: CommonextensionsStrucutureDefinition
* ^meta.profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-publishablecasefeature"
* ^extension[0].url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
* ^extension[=].valueCode = #shareable
* ^extension[+].url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
* ^extension[=].valueCode = #computable
* ^extension[+].url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
* ^extension[=].valueCode = #executable
* ^extension[+].url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
* ^extension[=].valueCode = #publishable
* ^extension[+].url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeRepresentationLevel"
* ^extension[=].valueCode = #structured
* ^extension[+].url = "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-softwaresystem"
* ^extension[=].valueReference = Reference(Device/cqf-tooling)
* ^extension[+].url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-featureExpression"
* ^extension[=].valueExpression.language = #text/cql-identifier
* ^extension[=].valueExpression.expression = "Diagnostic test prior to HGNS"
* ^extension[=].valueExpression.reference = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"
* ^version = "1.0.0"
* ^status = #draft
* ^experimental = false
* ^useContext.code = $usage-context-type#task "Workflow Task"
* . ^mustSupport = false
* code 1..1 MS
* code only CodeableConcept