library ColorectalCancerConcepts

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include FHIRCommon version '1.1.000' called FC

//NOTE: this file is POC.  Needs to be refactored along with ColorectalCancerRecommendation.
//see https://github.com/cqframework/ecqm-content-r4-2021/blob/cpg-cql/input/cql/
// and https://github.com/cqframework/cqf-ccc/blob/master/input/cql/

codesystem "ScreeningCodes": 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes'

code "Coverage Concern": 'coverage-concern' from "ScreeningCodes"
code "Sedation Concern": 'sedation-concern' from "ScreeningCodes"
code "Sigmoidoscopy Complication": 'sigmoidoscopy-complication' from "ScreeningCodes"
code "Colonoscopy Complication": 'colonoscopy-complication' from "ScreeningCodes"
code "Qualifying Patient Age": 'ccs-qualifying-age' from "ScreeningCodes"
code "Total Colectomy Performed": 'total-colectomy-performed' from "ScreeningCodes"
code "Has Malignant Neoplasm": 'has-malignant-neoplasm' from "ScreeningCodes"
code "Qualifying Colorectal Screening Performed": 'colorectal-screening-performed' from "ScreeningCodes"

//TODO: add user asserted
define "Coverage Concern Assertion":
  CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes' },
            code: code { value: 'coverage-concern' },
            display: string { value: 'Coverage Concern' }
        }
    }
  }

define "Sedation Concern Assertion":
  CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes' },
            code: code { value: 'sedation-concern' },
            display: string { value: 'Sedation Concern' }
        }
    }
  }

define "Sigmoidoscopy Complication Assertion":
  CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes' },
            code: code { value: 'sigmoidoscopy-complication' },
            display: string { value: 'Sigmoidoscopy Complication' }
        }
    }
  }


define "Colonoscopy Complication Assertion":
  CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes' },
            code: code { value: 'colonoscopy-complication' },
            display: string { value: 'Colonoscopy Complication' }
        }
    }
  }

  define "Qualifying Patient Age Assertion":
  CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes' },
            code: code { value: 'ccs-qualifying-age' },
            display: string { value: 'CCS Qualifying Patient Age' }
        }
    }
  }

  define "Total Colectomy Performed Assertion":
  CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes' },
            code: code { value: 'total-colectomy-performed' },
            display: string { value: 'Total Colectomy Performed' }
        }
    }
  }
  
  define "Has Malignant Neoplasm Assertion":
  CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes' },
            code: code { value: 'has-malignant-neoplasm' },
            display: string { value: 'Has Malignant Neoplasm' }
        }
    }
  }

define "Qualifying Colorectal Screening Performed Assertion":
  CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/cc-screening-codes' },
            code: code { value: 'colorectal-screening-performed' },
            display: string { value: 'Qualifying Colorectal Screening Performed' }
        }
    }
  }