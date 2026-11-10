library CrdExtendedCoverageInfo version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include QuestionnaireRouter version '0.1.0' called QuestionnaireRouter
include ASLPResourceHelpers version '0.1.0' called RH

context Patient

define "PA Required Prefix":
  'Prior authorization is required for'

define "PA Required Detail Text":
  'Prior Authorization Required'

define "Submit PA Form Detail Text":
  'Submit Prior Authorization Form'

define "No PA Required Text":
  'Order is covered. No prior auth is required for this request'

define "Member Not Found Text":
  'The member cannot be found. You can submit a PA request as an exception.'

define "Member Not Found Detail Text":
  'Member Not Found'

define "Provider Not In Network Text":
  'Provider is not in the network. You can submit a PA request as an exception.'

define "Provider Not In Network Detail Text":
  'Provider Not in Network'

define "Line Of Business Mismatch Text":
  'Line of Business Mismatch. Prior authorization submission is required.'

define "Line Of Business Mismatch Detail Text":
  'Line Of Business Mismatch'
  
define "Unable To Process Text":
  'Unable to process due to incomplete/ambiguous information. Please submit a prior auth form.'

define "Info Needed Text":
  'info-needed'

define function ExtensionPriorAuthNeeded(coverageIdValue System.String, coveredValue System.String, priorAuthRequiredValue System.String, coverageAssertionIdValue System.String, requestRefString System.String, serviceRequestCode System.Code, detailCodeValue System.String, detailTextValue System.String, qualificationValue System.String, warningOrInfoValue System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-coverage-information' },
    "extension": (Flatten({ 
      // payer coverage
      { "CoverageExtension"(coverageIdValue) },

      // expiry date after which assertion is no longer valid 
      { "ExpiryDateExtension"(coverageIdValue) },

      // 'covered', 'not-covered', or 'conditional' (https://build.fhir.org/ig/HL7/davinci-crd/ValueSet-coverageInfo.html)
      { "CoveredExtension"(coveredValue) },

      // 'auth-needed', 'no-auth', or 'conditional' (https://build.fhir.org/ig/HL7/davinci-crd/ValueSet-coveragePaDetail.html)
      { "PriorAuthNeededExtension"(priorAuthRequiredValue) },

      // system generated id
      { "CoverageAssertionIdExtension"(coverageAssertionIdValue) },

      // today's date
      { "TodaysDateExtension"() },

      // may be omitted if no matching ValueSet code exists
      { "ReasonExtension"(qualificationValue, serviceRequestCode) },

      // Required to be populated whenever one or more of covered, pa-needed, or doc-needed is set to conditional
      "InfoNeeded"(detailTextValue, qualificationValue),

      // service request id
      { "DependencyExtension"(requestRefString) },

      // detail code, warning or info, and qualification
      // mandatory category for classification of coverage guidance items
      { "DetailExtension"(detailCodeValue, detailTextValue, qualificationValue, warningOrInfoValue) },

      // Indicates the service or procedure code under evaluation
      { "BillingCode"(serviceRequestCode) },

      // Always 'admin' and 'clinical'
      // 'admin', 'clinical', 'both', or 'conditional' (https://hl7.org/fhir/us/davinci-crd/ValueSet-AdditionalDocumentation.html)
      // "DocNeeded"('admin'),
      // "DocNeeded"('clinical'),
      "DocNeeded"(priorAuthRequiredValue),

      // Purpose of requested documentation
      { "DocPurpose"(priorAuthRequiredValue) },

      // questionnaire canonical extension based on the service request code
      // requires a valueset per canonical questionnaire
      { "QuestionnaireExtension"(priorAuthRequiredValue, serviceRequestCode, requestRefString) }

    })) Ext 
      where Ext is not null
  }

define function "CoverageExtension"(coverageIdValue System.String)
returns FHIR.Extension:
  // if IsNull(coverageIdValue) then null as FHIR.Extension
  // else
    FHIR.Extension {
      "url": FHIR.uri { "value": 'coverage' },
      "value": FHIR.Reference {
          "reference": FHIR.string { "value": 'Coverage/' + coverageIdValue }
      }
    }

define function "ExpiryDateExtension"(coverageIdValue System.String)
returns FHIR.Extension:
   if IsNull("ExpiryDate"(coverageIdValue)) then
    null as FHIR.Extension
  else
    FHIR.Extension {
      "url": FHIR.uri { "value": 'expiry-date' },
      "value": FHIR.date { "value": "ExpiryDate"(coverageIdValue) }
    }

define function "ExpiryDate"(coverageIdValue System.String)
returns System.Date:
  if IsNull(coverageIdValue) or coverageIdValue = '' then null
  else 
    First(
      from [Coverage] C
        where C.id.value = coverageIdValue
          and C.period.end is not null
        return date from FHIRHelpers.ToDateTime(C.period.end)
    )

define function "CoveredExtension"(coveredValue System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'covered' },
    "value": FHIR.code { "value": if IsNull(coveredValue) or coveredValue = '' then 'conditional' else coveredValue }
  }

define function "PriorAuthNeededExtension"(priorAuthRequiredValue System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'pa-needed' },
    "value": FHIR.code { "value": if IsNull(priorAuthRequiredValue) or priorAuthRequiredValue = '' then 'conditional' else priorAuthRequiredValue }
  }

define function "CoverageAssertionIdExtension"(coverageAssertionIdValue System.String)
returns FHIR.Extension:
  // system generated id, either sent by payor or generated by shim
  FHIR.Extension {
    "url": FHIR.uri { "value": 'coverage-assertion-id' },
    "value": FHIR.string { "value": if IsNull(coverageAssertionIdValue) or (coverageAssertionIdValue = '') then 'N/A' else coverageAssertionIdValue }
  }

define function "TodaysDateExtension"()
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'date' },
    "value": FHIR.date { "value": Today() }
  }

define function "ReasonExtension"(qualificationValue System.String, serviceRequestCode System.Code)
returns FHIR.Extension:
  if IsNull(qualificationValue) 
  or StartsWith(qualificationValue, "PA Required Prefix")
  or qualificationValue = "No PA Required Text" then 
    FHIR.Extension {
      "url": FHIR.uri { "value": 'reason' },
      "value": FHIR.CodeableConcept { 
        "coding": {
          FHIR.Coding {
            system: FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp'},
            code: FHIR.code { "value": 'no-reason' },
            display:   FHIR.string { value: 'No reason' }
          }
        },
        "text": FHIR.string { value: 'No reason' }
      }
    }
  else
    FHIR.Extension {
      "url": FHIR.uri { "value": 'reason' },
      "value": FHIR.CodeableConcept { 
        "coding": {
          FHIR.Coding {
            system: FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp'},
            code: FHIR.code { "value": "GetReasonCode"(qualificationValue) },
            display: FHIR.string { "value": "GetReasonDisplay"(qualificationValue) }
          }
        },
        "text": FHIR.string { "value": "GetReasonText"(qualificationValue, serviceRequestCode) } 
      }
    }

define function "GetReasonCode"(qualificationValue System.String)
returns System.String:
  if qualificationValue = "Member Not Found Text" then 
    'no-member-found'
  else if qualificationValue = "Provider Not In Network Text" then 
    'auth-out-network'
  else 
    'coverage-not-found'

define function "GetReasonDisplay"(qualificationValue System.String)
returns System.String:
  if qualificationValue = "Member Not Found Text" then 
    'Member not found'
  else if qualificationValue = "Provider Not In Network Text" then 
    'Authorization needed out-of-network'
  else 
    'Coverage not found'

define function "GetReasonText"(qualificationValue System.String, serviceRequestCode System.Code)
returns System.String:
  if qualificationValue = "Member Not Found Text" then 
    'Member Not Found. You can submit a PA request as an exception.'
  else if qualificationValue = "Provider Not In Network Text" then 
    'Provider is not in the network. You can submit a PA request as an exception.'
  else if qualificationValue = "Line Of Business Mismatch Text" then 
    'Line of Business Mismatch. Prior authorization submission is required.'
  else if qualificationValue = "Unable To Process Text" 
    or StartsWith(qualificationValue, 'Unable to process due to incomplete') then
      'Unable to process due to incomplete/ambiguous information. Please submit a prior auth form.'
  else 
    Coalesce(
      serviceRequestCode.display,
      'The requested item'
    ) + ' is not a recognized procedure.'
    
// define function ToFHIRstring(c System.Code)
// returns FHIR.string:
//   if IsNull(c) then 
//     null as FHIR.string
//   else 
//     FHIR.string { value: c.display }

define "InfoNeededValues1":
  {'performer', 'location', 'timeframe'}

define "InfoNeededValues2":
  {'performer', 'location', 'timeframe', 'detail-code'}

define "InfoNeededNullValues":
  {'no-info-needed', 'no-info-needed'}

define function "InfoNeededExtension"(infoValue System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": "Info Needed Text" },
    "value": FHIR.code { "value": infoValue }
  } 

define function "InfoNeeded"(detailTextValue System.String, qualificationValue System.String)
returns List<FHIR.Extension>:
  if detailTextValue = "Member Not Found Detail Text"
    or qualificationValue = "Member Not Found Text" then
    { "InfoNeededExtension"('OTH') }
  else if detailTextValue = "Provider Not In Network Detail Text"
     or qualificationValue = "Provider Not In Network Text" then
    { "InfoNeededExtension"('performer') }
  else if detailTextValue = "Line Of Business Mismatch Detail Text" then
    { "InfoNeededExtension"('OTH') }
  else if detailTextValue = "PA Required Detail Text" then
    "InfoNeededValues1" V 
    return "InfoNeededExtension"(V)
  else if detailTextValue = "Submit PA Form Detail Text" then
    "InfoNeededValues2" V 
    return "InfoNeededExtension"(V)
  else
    "InfoNeededNullValues" V 
    return "InfoNeededExtension"(V)

define function "QuestionnaireExtension"(priorAuthRequiredValue System.String, procedureCode System.Code, requestRefString System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'questionnaire' },
    "value": FHIR.canonical {
      "value":
        case
          when priorAuthRequiredValue in { 'auth-needed', 'conditional' } then
            Coalesce(
              QuestionnaireRouter.GetAdaptiveQuestionnairePlanDefinition(procedureCode),
              'http://example.org/fhir/PlanDefinition/questionnaire-not-found'
            )
          else if StartsWith(requestRefString, 'CommunicationRequest/') then
            'http://example.org/fhir/PlanDefinition/not-applicable' 
          else 
            'http://example.org/fhir/PlanDefinition/not-applicable'
        end
    }
  }

// code = auth-needed|no-auth|gold-card|not-covered, warningOrInfo = Warning|info, qualification = {open text entry}
define function "DetailExtension"(detailCodeValue System.String, detailTextValue System.String, qualificationValue System.String, warningOrInfoValue System.String)
returns FHIR.Extension:
  FHIR.Extension {
    "url": FHIR.uri { "value": 'detail' },
    "extension": {
      if qualificationValue = "No PA Required Text" then 
        FHIR.Extension {
          "url": FHIR.uri { "value": 'category' },
          "value": FHIR.code { "value": 'cat-decisional' }
        }
      else 
        FHIR.Extension {
          "url": FHIR.uri { "value": 'category' },
          "value": FHIR.code { "value": 'cat-limitation' }
        },
      
      if (detailCodeValue = 'auth-needed') then "DetailCodeAuthRequired"(detailTextValue)
      else if (detailCodeValue = 'no-auth') then "DetailCodeAuthNotRequired"(detailTextValue)
      else if (detailCodeValue = 'gold-card') then "DetailCodeGoldCard"(detailTextValue)
      else if (detailCodeValue = 'not-covered') then "DetailCodeNoCoverage"(detailTextValue)
      else if (detailCodeValue = 'coverage-info') then "DetailCodeCoverageInfo"(detailTextValue)
      else "DetailCode"(
        'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 
        if IsNull(detailCodeValue) or detailCodeValue = '' then 'coverage-info' else detailCodeValue, 
        'Unknown display', 
        if IsNull(detailTextValue) or detailTextValue = '' then 'N/A' else detailTextValue
      ),
      // else "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', codeValue, 'Unknown display', detailText),

      FHIR.Extension {
        "url": FHIR.uri { "value": 'value' },
        // "value": FHIR.string { "value": warningOrInfo }
        "value": FHIR.string { "value": if IsNull(warningOrInfoValue) or warningOrInfoValue = '' then 'info' else warningOrInfoValue }
      },

      FHIR.Extension {
        "url": FHIR.uri { "value": 'qualification' },
        // "value": FHIR.string { "value": qualification }
        "value": FHIR.string { "value": if IsNull(qualificationValue) or qualificationValue = '' then 'N/A' else qualificationValue }
      }
    }
  }

define function "DetailCode"(system System.String, value System.String, displayText System.String, text System.String)
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
      "text": FHIR.string { "value": text }
    }
  }

define function "DetailCodeAuthRequired"(displayText System.String)
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'auth-needed', 'Prior Authorization Needed', displayText)

define function "DetailCodeAuthNotRequired"(displayText System.String)
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'no-auth', 'No Prior Authorization', displayText)

define function "DetailCodeGoldCard"(displayText System.String)
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'gold-card', 'Gold Card', displayText)

define function "DetailCodeNoCoverage"(displayText System.String)
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'not-covered', 'Not covered', displayText)

define function "DetailCodeCoverageInfo"(displayText System.String)
returns FHIR.Extension:
  "DetailCode"('http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp', 'coverage-info', 'Coverage Information', displayText)

define function "DependencyExtension"(requestRefString System.String)
returns FHIR.Extension:
  // if IsNull(requestReferenceString) then null as FHIR.Extension
  // else
    FHIR.Extension {
      "url": FHIR.uri { "value": 'dependency' },
      "value": FHIR.Reference {
        // "reference": FHIR.string { "value": requestReferenceString }
          "reference": FHIR.string { 
              "value": 
                  if IsNull(requestRefString) or requestRefString = '' then 'N/A'
                  else requestRefString
            }
      }
    }

define function "DocNeeded"(priorAuthRequiredValue System.String)
returns List<FHIR.Extension>:
  if ("PriorAuthNeededExtension"(priorAuthRequiredValue).value as FHIR.code).value in { 'no-auth', 'conditional' } then
    "Doc Needed Values Null" V
    return 
      FHIR.Extension {
        "url": FHIR.uri { "value": 'doc-needed' },
        "value": FHIR.code { "value": V }
      }
  else
    "Doc Needed Values" V
    return 
      FHIR.Extension {
        "url": FHIR.uri { "value": 'doc-needed' },
        "value": FHIR.code { "value": V }
      }

define "Doc Needed Values":
  {'admin', 'clinical'}

define "Doc Needed Values Null":
  {'no-doc-needed', 'no-doc-needed'}

define function "DocPurpose"(priorAuthRequiredValue System.String)
returns FHIR.Extension:
  if ("PriorAuthNeededExtension"(priorAuthRequiredValue).value as FHIR.code).value = 'auth-needed' then
    FHIR.Extension {
      "url": FHIR.uri { "value": 'doc-purpose' },
      "value": FHIR.code { "value": 'withpa' }
    }
  else 
    FHIR.Extension {
      "url": FHIR.uri { "value": 'doc-purpose' },
      "value": FHIR.code { "value": 'no-doc-purpose' }
    }

define function "BillingCode"(serviceRequestCode System.Code)
returns FHIR.Extension:
  FHIR.Extension {
    url: FHIR.uri { "value": 'billingCode' },
    value: FHIR.Coding {
        system: FHIR.uri { value: "BillingCodeSystem"(serviceRequestCode) },
        code: FHIR.code { value: serviceRequestCode.code },
        display: FHIR.string { value: serviceRequestCode.display }
      }
  }

define function "BillingCodeSystem"(c System.Code)
returns System.String:
  if IsNull(c) then null
  else if c.system in { 'http://www.ama-assn.org/go/cpt', 'urn:oid:2.16.840.1.113883.6.12' } then
    'http://www.ama-assn.org/go/cpt'
  else if c.system in { 'http://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets', 'https://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets', 'urn:oid:2.16.840.1.113883.6.285' } then
    'http://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets'
  else null