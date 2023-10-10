library CrdExtendedCoverageInfo version '0.1.0'

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include USCoreCommon version '0.1.0'
include FHIRHelpers version '4.1.000'

context Patient

define function ExtensionPriorAuthNotNeeded(coverageId System.String, covered System.String, coverageAssertionId System.String, requestReferenceString System.String, qualification System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information' },
    "extension": ({ 
      // payer coverage
      "CoverageExtension"(coverageId),

      // 'covered', 'not-covered', or 'conditional' (https://build.fhir.org/ig/HL7/davinci-crd/ValueSet-coverageInfo.html)
      "CoveredExtension"(covered),

      // system generated id
      // TODO: figure out where this is coming from, or where generated
      "CoverageAssertionIdExtension"(coverageAssertionId),

      // today's date
      "TodaysDateExtension"(),

      // service request id
      "DependencyExtension"(requestReferenceString)
    }) Extension where not IsNull(Extension)
  }

define function ExtensionPriorAuthNeeded(coverageId System.String, covered System.String, coverageAssertionId System.String, requestReferenceString System.String, serviceRequestCode System.Code, qualification System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information' },
    "extension": ({ 
      // payer coverage
      "CoverageExtension"(coverageId),

      // 'covered', 'not-covered', or 'conditional' (https://build.fhir.org/ig/HL7/davinci-crd/ValueSet-coverageInfo.html)
      "CoveredExtension"(covered),

      // system generated id
      // TODO: figure out where this is coming from, or where generated
      "CoverageAssertionIdExtension"(coverageAssertionId),

      // today's date
      "TodaysDateExtension"(),

      // TODO: need to figure this out
      "QuestionnaireExtension"(serviceRequestCode),

      // TODO: update once Prior Auth team ready
      "DetailExtension"(qualification),

      // service request id
      "DependencyExtension"(requestReferenceString)
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
    "value": FHIR.Reference {
      "reference": FHIR.code { "value": covered }
    }
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

define function "DetailExtension"(qualification System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'detail' },
    "extension": {
      FHIR.Extension {
        "url": FHIR.uri { "value": 'code' },
        "value": FHIR.CodeableConcept { 
          "coding": {
            FHIR.Coding {
              system: FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp' },
              code: FHIR.code { "value": 'to-endpoint' },
              display: FHIR.string { "value": 'Send information to endpoint' }
            }
          },
          "text": FHIR.string { "value": 'Send information to endpoint' }
        }
      },
      FHIR.Extension {
        "url": FHIR.uri { "value": 'value' },
        "value": FHIR.string { "value": 'Warning' }
      },
      FHIR.Extension {
        "url": FHIR.uri { "value": 'qualification' },
        "value": FHIR.string { "value": qualification }
      }
    }
  }

define function "DependencyExtension"(requestReferenceString System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'dependency' },
    "value": FHIR.Reference {
      "reference": FHIR.code { "value": requestReferenceString }
    }
  }