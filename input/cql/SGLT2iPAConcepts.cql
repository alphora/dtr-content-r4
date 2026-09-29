library SGLT2iPAConcepts version '1.0.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1' called FHIRHelpers
include FHIRCommon version '1.1.000' called FC

codesystem "ScreeningCodes": 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes'

// code "Qualifying Diagnosis of Diabetes": 'qualifying-diabetes-diagnosis' from "ScreeningCodes"
// code "Most Recent A1c > 8": 'most-recent-a1c->-8' from "ScreeningCodes"
// code "Evidence Of CKD": 'evidence-of-ckd' from "ScreeningCodes"

context Patient 

define "Qualifying Diagnosis of Diabetes Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'qualifying-diabetes-diagnosis' },
            display: string { value: 'Qualifying Diagnosis of Diabetes' }
        }
    }
  }

define "Most Recent A1c > 8 Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'most-recent-a1c->-8' },
            display: string { value: 'Most Recent A1c > 8' }
        }
    }
  }

define "Evidence Of CKD Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'evidence-of-ckd' },
            display: string { value: 'Evidence Of CKD' }
        }
    }
  }

define "Qualifying Two eGFR < 90 With Dates 3 Months Apart Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'qualifying-two-egfr-less-than-90' },
            display: string { value: 'Qualifying Two eGFR < 90 With Dates 3 Months Apart' }
        }
    }
  }

define "Qualifying Two uACR > 30 With Dates 3 Months Apart Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'qualifying-two-uacr-greater-than-30' },
            display: string { value: 'Qualifying Two uACR > 30 With Dates 3 Months Apart' }
        }
    }
  }

define "Qualifying CKD Diagnosis Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'qualifying-ckd-diagnosis' },
            display: string { value: 'Qualifying CKD Diagnosis' }
        }
    }
  }

define "Qualifying Most Recent eGFR < 90 Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'qualifying-most-recent-egfr-less-than-90' },
            display: string { value: 'Qualifying Most Recent eGFR < 90' }
        }
    }
  }

define "Qualifying Most Recent uACR > 30 Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'qualifying-most-recent-uacr-greater-than-30' },
            display: string { value: 'Qualifying Most Recent uACR > 30' }
        }
    }
  }

define "Qualifying Dialysis Procedure Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/demo/CodeSystem/diabetes-sglt2i-screening-codes' },
            code: code { value: 'qualifying-dialysis-procedure' },
            display: string { value: 'Qualifying Dialysis Procedure' }
        }
    }
  }