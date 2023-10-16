library CrdExtendedCoverageInfo

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

define function ExtensionPriorAuthNotNeeded(coverageId System.String, covered System.String, priorAuthRequired System.String, coverageAssertionId System.String, requestReferenceString System.String, serviceRequestCode System.Code, codeValue System.String, qualification System.String, warningOrInfo System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information' },
    "extension": ({ 
      // payer coverage
      "CoverageExtension"(coverageId),

      // 'covered', 'not-covered', or 'conditional' (https://build.fhir.org/ig/HL7/davinci-crd/ValueSet-coverageInfo.html)
      "CoveredExtension"(covered),

      // 'auth-needed', 'no-auth', or 'conditional' (https://build.fhir.org/ig/HL7/davinci-crd/ValueSet-coveragePaDetail.html)
      "PriorAuthNeededExtension"(priorAuthRequired),

      // system generated id
      "CoverageAssertionIdExtension"(coverageAssertionId),

      // today's date
      "TodaysDateExtension"(),

      // service request id
      "DependencyExtension"(requestReferenceString),

      // detail code, warning or info, and qualification
      "DetailExtension"(codeValue, qualification, warningOrInfo)
    }) Extension where not IsNull(Extension)
  }

define function ExtensionPriorAuthNeeded(coverageId System.String, covered System.String, priorAuthRequired System.String, coverageAssertionId System.String, requestReferenceString System.String, serviceRequestCode System.Code, codeValue System.String, qualification System.String, warningOrInfo System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information' },
    "extension": ({ 
      // payer coverage
      "CoverageExtension"(coverageId),

      // 'covered', 'not-covered', or 'conditional' (https://build.fhir.org/ig/HL7/davinci-crd/ValueSet-coverageInfo.html)
      "CoveredExtension"(covered),

      // 'auth-needed', 'no-auth', or 'conditional' (https://build.fhir.org/ig/HL7/davinci-crd/ValueSet-coveragePaDetail.html)
      "PriorAuthNeededExtension"(priorAuthRequired),

      // system generated id
      "CoverageAssertionIdExtension"(coverageAssertionId),

      // today's date
      "TodaysDateExtension"(),

      // TODO: need to figure out how to make this dynamic
      "QuestionnaireExtension"(serviceRequestCode),

      // service request id
      "DependencyExtension"(requestReferenceString),

      // detail code, warning or info, and qualification
      "DetailExtension"(codeValue, qualification, warningOrInfo)
    }) Extension where not IsNull(Extension)
  }

define function "CoverageExtension"(coverageId System.String)
returns FHIR.Extension:
  // TODO: verify this works
  if IsNull(coverageId) then null as FHIR.Extension
  else
    FHIR.Extension {
      "url": FHIR.uri { "value": 'coverage' },
      "value": FHIR.Reference {
        "reference": FHIR.string { "value": 'Coverage/' + coverageId }
      }
    }

define function "CoveredExtension"(covered System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'covered' },
    "value": FHIR.code { "value": covered }
  }

define function "PriorAuthNeededExtension"(priorAuthRequired System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'pa-needed' },
    "value": FHIR.code { "value": priorAuthRequired }
  }

define function "CoverageAssertionIdExtension"(coverageAssertionId System.String)
returns FHIR.Extension:
  // system generated id
  // TODO: figure out where this is coming from, or where generated
  FHIR.Extension {
    "url": FHIR.uri { "value": 'coverage-assertion-id' },
    "value": FHIR.string { "value": coverageAssertionId }
  }

define function "TodaysDateExtension"()
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'date' },
    "value": FHIR.date { "value": Today() }
  }

define function "QuestionnaireExtension"(procedureCode System.Code)
returns FHIR.Extension:
  // TODO: need to figure this out
  // Ideas: 
  // - ConceptMap for Service Code -> Questionnaire Canonical
  //   - ConceptMap would need to be part of the patient context somehow
  // - ValueSet of Service Codes per Questionnaire Canonical
  //   - CQL file to match ValueSets to Canonicals
  // - Related Context Retreive to get Questionnaire?
  //   - https://cql.hl7.org/03-developersguide.html#related-context-retrieves
  FHIR.Extension {
    "url": FHIR.uri { "value": 'questionnaire' },
    "value": FHIR.canonical { "value": 'http://example.org/sdh/dtr/aslp/Questionnaire/ASLPA1' } 
  }

// code = auth-needed|no-auth|gold-card|not-covered, warningOrInfo = Warning|info, qualification = {open text entry}
define function "DetailExtension"(codeValue System.String, qualification System.String, warningOrInfo System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'detail' },
    "extension": {
      if (codeValue = 'auth-needed') then "DetailCodeAuthRequired"()
      else if (codeValue = 'no-auth') then "DetailCodeAuthNotRequired"()
      else if (codeValue = 'gold-card') then "DetailCodeGoldCard"()
      else if (codeValue = 'not-covered') then "DetailCodeNoCoverage"()
      else "DetailCode"(codeValue, codeValue, codeValue),

      FHIR.Extension {
        "url": FHIR.uri { "value": 'value' },
        "value": FHIR.string { "value": warningOrInfo }
      },
      FHIR.Extension {
        "url": FHIR.uri { "value": 'qualification' },
        "value": FHIR.string { "value": qualification }
      }
    }
  }

define function "DetailCode"(system System.String, value System.String, displayText System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'code' },
    "value": FHIR.CodeableConcept { 
      "coding": {
        FHIR.Coding {
          system: FHIR.uri { "value": system },
          code: FHIR.code { "value": value },
          display: FHIR.string { "value": displayText }
        }
      },
      "text": FHIR.string { "value": displayText }
    }
  }

define function "DetailCodeAuthRequired"()
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'auth-needed', 'Prior Authorization Needed')

define function "DetailCodeAuthNotRequired"()
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'no-auth', 'No Prior Authorization')

define function "DetailCodeGoldCard"()
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'gold-card', 'Gold Card')

define function "DetailCodeNoCoverage"()
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'not-covered', 'Not covered')

define function "DependencyExtension"(requestReferenceString System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'dependency' },
    "value": FHIR.Reference {
      "reference": FHIR.string { "value": requestReferenceString }
    }
  }