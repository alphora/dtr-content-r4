library ASLPPolicyConcepts

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'
include ASLPPolicyCaseFeatures called PCF
include ASLPPolicyScreening called PS

codesystem "ASLP Policy Screening Codes": 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes'

//context???

define "Qualifying Patient Age Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Patient-Age' },
            display: string { value: 'Qualifying Patient Age' }
        }
    }
  }

define "Qualifying Excessive Daytime Sleepiness Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Excessive-Daytime-Sleepiness' },
            display: string { value: 'Qualifying Excessive Daytime Sleepiness' }
        }
    }
  }

define "Qualifying Epworth Sleepiness Scale Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Epworth-Sleepiness-Scale-Score' },
            display: string { value: 'ESS Score >= 10' }
        }
    }
  } //How do we account for value >= 10

define "Qualifying Excessive Sleepiness While Driving Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Excessive-Sleepiness-While-Driving' },
            display: string { value: 'Excessive Sleepiness While Driving' }
        }
    }
  }

define "Qualifying Loud Snoring Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Loud-Snoring' },
            display: string { value: 'Loud/Intense Snoring' }
        }
    }
  }

define "Qualifying Nocturnal Apnea Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Nocturnal-Apnea' },
            display: string { value: 'Nocturnal Apnea' }
        }
    }
  }

define "Qualifying Absence Of Comorbid Medical Conditions Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Absence-Of-Comorbid-Conditions' },
            display: string { value: 'Qualifying Absence Of Comorbid Medical Conditions' }
        }
    }
  }

define "Qualifying Moderate To Severe Pulmonary Disease Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Moderate-To-Severe-Pulmonary-Disease' },
            display: string { value: 'Qualifying Moderate To Severe Pulmonary Disease' }
        }
    }
  }

define "Qualifying Moderate To Severe Pulmonary Disease Assertion Including COPD Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Moderate-To-Severe-Pulmonary-Disease-Including-COPD' },
            display: string { value: 'Qualifying Moderate To Severe Pulmonary Disease Including COPD' }
        }
    }
  }

define "Qualifying Moderate To Severe Pulmonary Disease Assertion Including Asthma Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Moderate-To-Severe-Pulmonary-Disease-Including-Asthma' },
            display: string { value: 'Qualifying Moderate To Severe Pulmonary Disease Including Asthma' }
        }
    }
  }

define "Qualifying Neuromuscular Disease With Associated Pulmonary Disease Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Neuromuscular-Disease-With-Pulmonary-Disease' },
            display: string { value: 'Qualifying Neuromuscular Disease With Associated Pulmonary Disease' }
        }
    }
  }

define "Qualifying Cardiac Disease Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Cardiac-Disease' },
            display: string { value: 'Qualifying Cardiac Disease' }
        }
    }
  }

define "Uses A Qualified Device Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Uses-Qualified-Device' },
            display: string { value: 'Uses A Qualified Device' }
        }
    }
  }

define "Safe Equipment Use At Home Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Safe-Equipment-Use-At-Home' },
            display: string { value: 'Safe Equipment Use At Home' }
        }
    }
  }

define "Physician Evaluated Results Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Physician-Evaluate-Results' },
            display: string { value: 'Physician Evaluated Results' }
        }
    }
  }

define "Diagnostic testing prior to planned HGNS implantation for an individual with a known diagnosis of OSA Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/fbpsg-paa-screening-codes' },
            code: code { value: 'diagnostic-test-prior-to-HGNS-with-OSA' },
            display: string { value: 'Diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS) implantation for an individual with a known diagnosis of OSA' }
        }
    }
  }

define "History of or clinical features associated with Central Sleep Apnea Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/fbpsg-paa-screening-codes' },
            code: code { value: 'history-of-or-clinical-features–associated–with-CSA' },
            display: string { value: 'History of or clinical features associated with central sleep apnea (CSA)' }
            }
    }
  }

define "History of or clinical features associated with narcolepsy when a MSLT is planned Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/fbpsg-paa-screening-codes' },
            code: code { value: 'history-of-or-clinical-features–associated–with-narcolepsy-when-a-MSLT-is-planned' },
            display: string { value: 'History of or clinical features associated with narcolepsy when a MSLT is planned' }
        }
    }
  }

define "History of or clinical features associated with obesity hypoventilation syndrome (OHS) Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/fbpsg-paa-screening-codes' },
            code: code { value: 'history-of-or-clinical-features–associated–with-OHS' },
            display: string { value: 'History of or clinical features associated with obesity hypoventilation syndrome (OHS)' }
        }
    }
  }

define "History of traumatic brain injury (TBI) with EDS Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/fbpsg-paa-screening-codes' },
            code: code { value: 'history-of-TBI-with-EDS' },
            display: string { value: 'History of traumatic brain injury (TBI) with EDS' }
        }
    }
  }

define "Idiopathic central nervous system hypersomnia Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/fbpsg-paa-screening-codes' },
            code: code { value: 'idiopathic-CNS-hypersomnia-when-a-MSLT-is-planned' },
            display: string { value: 'Idiopathic central nervous system hypersomnia when a MSLT is planned' }
        }
    }
  }

define "Individual (or caregiver) lacks cognitive function, dexterity or mobility to use PM equipment safely at home Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/fbpsg-paa-screening-codes' },
            code: code { value: 'not-safe-equipment-use-at-home' },
            display: string { value: 'Individual (or caregiver) lacks cognitive function, dexterity or mobility to use PM equipment safely at home' }
        }
    }
  }

define "Mission critical profession Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/fbpsg-paa-screening-codes' },
            code: code { value: 'mission-critical-profession' },
            display: string { value: 'Mission critical profession' }
        }
    }
  }
