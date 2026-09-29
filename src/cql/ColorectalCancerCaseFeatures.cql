library ColorectalCancerCaseFeatures

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include FHIRCommon version '1.1.000' called FC
include ColorectalCancerConcepts called Concepts
include ColorectalCancerRecommendation called Recommendation
include CaseFeatureCommon called CFC

context Patient

define "Most Recent Coverage Reference":
  CFC.ReferenceTo(CFC.MostRecent(Recommendation."Coverage Concern"))

define "Most Recent Coverage Concern":
  CFC.MostRecent([Observation: Concepts."Coverage Concern"])

define "Coverage Concern":
  if not "Most Recent Coverage Concern" is null then
    "Most Recent Coverage Concern"
  else
    CFC.CaseFeatureObservation(
      Concepts."Coverage Concern Assertion",
      not exists(Recommendation."Coverage Concern"),
      'http://example.org/sdh/demo/StructureDefinition/coverage-concern-casefeature-definition',
      CFC.MostRecent(Recommendation."Coverage Concern"),
      ''
    )

define "Has Coverage Concern":
  "Coverage Concern".value

define "No Coverage Concern":
  not "Has Coverage Concern"

define "Most Recent Sedation Concern":
  CFC.MostRecent([Observation: Concepts."Sedation Concern"])

define "Sedation Concern":
  if not "Most Recent Sedation Concern" is null then
    "Most Recent Sedation Concern"
  else
    CFC.CaseFeatureObservation(
      Concepts."Sedation Concern Assertion",
      exists(Recommendation."Sedation Concern"),
      'http://example.org/sdh/demo/StructureDefinition/sedation-concern-casefeature-definition',
      CFC.MostRecent(Recommendation."Sedation Concern"),
      CFC.CodingEvidence(CFC.MostRecent(Recommendation."Sedation Concern").code)
    )

define "Has Sedation Concern":
  "Sedation Concern".value

define "No Sedation Concern":
  not "Has Sedation Concern"

define "Most Recent Colonoscopy Complication":
  CFC.MostRecent([Observation: Concepts."Colonoscopy Complication"])

define "Colonoscopy Complications":
  if not "Most Recent Colonoscopy Complication" is null then
    "Most Recent Colonoscopy Complication"
  else
    CFC.CaseFeatureObservation(
      Concepts."Colonoscopy Complication Assertion",
      exists(Recommendation."Colon Invasive Procedure Complications"),
      'http://example.org/sdh/demo/StructureDefinition/colonoscopy-complication-casefeature-definition',
      CFC.MostRecent(Recommendation."Colon Invasive Procedure Complications"),
      CFC.CodingEvidence(CFC.MostRecent(Recommendation."Colon Invasive Procedure Complications").code)
    )

define "Has Colonoscopy Complications":
  "Colonoscopy Complications".value

define "No Colonoscopy Complications":
  not "Has Colonoscopy Complications"

define "Most Recent Sigmoidoscopy Complication":
  CFC.MostRecent([Observation: Concepts."Sigmoidoscopy Complication"])

define "Sigmoidoscopy Complications":
  if not "Most Recent Sigmoidoscopy Complication" is null then
    "Most Recent Sigmoidoscopy Complication"
  else
    CFC.CaseFeatureObservation(
      Concepts."Sigmoidoscopy Complication Assertion",
      exists(Recommendation."Colon Invasive Procedure Complications"),
      'http://example.org/sdh/demo/StructureDefinition/sigmoidoscopy-complication-casefeature-definition',
      CFC.MostRecent(Recommendation."Colon Invasive Procedure Complications"),
      CFC.CodingEvidence(CFC.MostRecent(Recommendation."Colon Invasive Procedure Complications").code)
    )

define "Has Sigmoidoscopy Complications":
  "Sigmoidoscopy Complications".value

define "No Sigmoidoscopy Complications":
  not "Has Sigmoidoscopy Complications"

define "Coverage Concern Description":
  if "Has Coverage Concern" then
    'No insurance and cost is a great concern'
  else
    'Has insurance and cost is not a great concern'

//TODO: add user asserted
//naive implementation to test the concept
define "Sedation Concern Description":
  if "Has Sedation Concern" then
    'Sedation concern' + CFC.ProvenanceAsString("Sedation Concern")
  else
    'No known medical conditions that present a concern with sedation'

//TODO: add user asserted
//naive implementation to test the concept
define "Colon Invasive Procedure Complications Description":
  if "Has Colonoscopy Complications" or "Has Sigmoidoscopy Complications" then
    'Invasive procedure concern' + 
      Coalesce(
        CFC.ProvenanceAsString("Colonoscopy Complications"), 
        CFC.ProvenanceAsString("Sigmoidoscopy Complications")
      )    
  else
    'No known medical conditions that present a concern with an invasive procedure'

define "Rationale":
  if Recommendation."Inclusion Criteria" then
'CARE GAP REASON: No qualifying Colorectal Cancer Screening has been performed.'
+ '<br /><br />- ' + "Coverage Concern Description" + ' <a href=https://projectathon.smilecdr.com/fhir_request/DocumentReference/ccs-coverage-concern>[1]</a>'
+ '<br />- ' + "Sedation Concern Description" + ' <a href=https://projectathon.smilecdr.com/fhir_request/DocumentReference/ccs-sedation-concern>[2]</a>'
+ '<br />- ' + "Colon Invasive Procedure Complications Description" + ' <a href=https://projectathon.smilecdr.com/fhir_request/DocumentReference/ccs-invasive-procedure-concern>[3]</a>'
  else null

define "Prior Authorization Coverage":
  Extension {
    url: uri { value: 'coverage' },
    value: CFC.ReferenceTo(CFC.MostRecent(Recommendation."Coverage Concern")) 
  }
 
define "Prior Authorization Covered Colonoscopy":
  Extension {
    url: uri { value: 'covered' },
    value: code { value: 'covered' }
  }

define "Prior Authorization Needed Colonoscopy":
  Extension {
    url: uri { value: 'pa-needed' },
    value: code { value: 'auth-needed' }
  }

define "Prior Authorization Detail Colonoscopy":
  Extension {
    url: uri { value: 'detail' },
    extension: { 
      Extension {
        url: uri { value: 'code' },
        value: 
          CodeableConcept {
            coding: {
              Coding {
                  system: uri { value: 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp' },
                  code: code { value: 'auth-needed' },
                  display: string { value: 'Prior Authorization Needed' }
              }
            },
            text: string { value: 'Prior Authorization Required' }
          }
      },
      Extension {
        url: uri { value: 'value' },
        value: string { value: 'Warning' }
      },
      Extension {
        url: uri { value: 'qualification' },
        value: string { value: 'Prior authorization is required for colonoscopy' }
      }
    }
  }

define "Prior Authorization Coding Colonoscopy":
  Extension {
    url: uri { value: 'billingCode' },
    value: 
      Coding {
        system: uri { value: 'http://snomed.info/sct' },
        code: code { value: '73761001' },
        display: string { value: 'Colonoscopy (procedure)' }
      }
  }

define "Prior Authorization Coding FITDNA":
  Extension {
    url: uri { value: 'billingCode' },
    value: 
      Coding {
        system: uri { value: 'http://snomed.info/sct' },
        code: code { value: '457591000124105' },
        display: string { value: 'Stool DNA-based colorectal cancer screening (procedure)' }
      }
  }
  
define "Prior Authorization Covered FlexSig":
  Extension {
    url: uri { value: 'covered' },
    value: code { value: 'covered' }
  }

define "Prior Authorization Needed FlexSig":
  Extension {
    url: uri { value: 'pa-needed' },
    value: code { value: 'auth-needed' }
  }

define "Prior Authorization Detail FlexSig":
  Extension {
    url: uri { value: 'detail' },
    extension: { 
      Extension {
        url: uri { value: 'code' },
        value: 
          CodeableConcept {
            coding: {
              Coding {
                  system: uri { value: 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp' },
                  code: code { value: 'auth-needed' },
                  display: string { value: 'Prior Authorization Needed' }
              }
            },
            text: string { value: 'Prior Authorization Required' }
          }
      },
      Extension {
        url: uri { value: 'value' },
        value: string { value: 'Warning' }
      },
      Extension {
        url: uri { value: 'qualification' },
        value: string { value: 'Prior authorization is required for Flexible fiberoptic sigmoidoscopy' }
      }
    }
  }

define "Prior Authorization Coding FlexSig":
  Extension {
    url: uri { value: 'billingCode' },
    value: 
      Coding {
        system: uri { value: 'http://snomed.info/sct' },
        code: code { value: '44441009' },
        display: string { value: 'Flexible fiberoptic sigmoidoscopy (procedure)' }
      }
  }

define "Prior Authorization Covered CTColonography":
  Extension {
    url: uri { value: 'covered' },
    value: code { value: 'covered' }
  }

define "Prior Authorization Needed CTColonography":
  Extension {
    url: uri { value: 'pa-needed' },
    value: code { value: 'auth-needed' }
  }

define "Prior Authorization Detail CTColonography":
  Extension {
    url: uri { value: 'detail' },
    extension: { 
      Extension {
        url: uri { value: 'code' },
        value: 
          CodeableConcept {
            coding: {
              Coding {
                  system: uri { value: 'http://hl7.org/fhir/us/davinci-crd/CodeSystem/temp' },
                  code: code { value: 'auth-needed' },
                  display: string { value: 'Prior Authorization Needed' }
              }
            },
            text: string { value: 'Prior Authorization Required' }
          }
      },
      Extension {
        url: uri { value: 'value' },
        value: string { value: 'Warning' }
      },
      Extension {
        url: uri { value: 'qualification' },
        value: string { value: 'Prior authorization is required for virtual computed tomography colonoscopy' }
      }
    }
  }

define "Prior Authorization Coding CTColonography":
  Extension {
    url: uri { value: 'billingCode' },
    value: 
      Coding {
        system: uri { value: 'http://snomed.info/sct' },
        code: code { value: '418714002' },
        display: string { value: 'Virtual computed tomography colonoscopy (procedure)' }
      }
  }
