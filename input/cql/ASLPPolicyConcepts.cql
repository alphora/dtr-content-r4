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

define "Qualifying Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Diagnostic-Testing-Prior-To-HGNS-Implantation-With-Diagnosis-of-OSA' },
            display: string { value: 'Diagnostic Testing Prior To HGNS Implantation With Diagnosis of OSA' }
        }
    }
  }

define "Qualifying Central Sleep Apnea (CSA) Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Central-Sleep-Apnea-CSA' },
            display: string { value: 'Central Sleep Apnea' }
        }
    }
  }

define "Qualifying Features Associated With Narcolepsy When a MSLT is Planned Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Features-Associated-With-Narcolepsy' },
            display: string { value: 'Qualifying Features Associated With Narcolepsy' }
        }
    }
  }

define "Qualifying Obesity Hypoventilation Syndrome (OHS) Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Obesity-Hypoventilation-Syndrome-OHS' },
            display: string { value: 'Qualifying Obesity Hypoventilation Syndrome (OHS)' }
        }
    }
  }

define "Qualifying Traumatic Brain Injury (TBI) with EDS Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Traumatic-Brain-Injury-TBI-with-EDS' },
            display: string { value: 'Qualifying Traumatic Brain Injury (TBI) with EDS' }
        }
    }
  }

define "Qualifying Idiopathic Central Nervous System Hypersomnia Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Idiopathic-Central-Nervous-System-Hypersomnia' },
            display: string { value: 'Qualifying Idiopathic Central Nervous System Hypersomnia' }
        }
    }
  }

define "Qualifying Impairment Affecting Safe Equipment Use At Home Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Impairment-Affecting-Safe-Equipment-Use-At-Home' },
            display: string { value: 'Qualifying Impairment Affecting Safe Equipment Use At Home' }
        }
    }
  }

define "Qualifying Mission Critical Profession Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Mission-Critical-Profession' },
            display: string { value: 'Qualifying Mission Critical Profession' }
        }
    }
  }

define "Qualifying Parasomnia Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Parasomnia' },
            display: string { value: 'Qualifying Parasomnia' }
        }
    }
  }

define "Qualifying Paroxysmal Arousals Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Paroxysmal-Arousals' },
            display: string { value: 'Qualifying Paroxysmal Arousals' }
        }
    }
  }

define "Qualifying Periodic Limb Movement Disorder (PLMD) Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Periodic-Limb-Movement-Disorde-PLMD' },
            display: string { value: 'Qualifying Periodic Limb Movement Disorder (PLMD)' }
        }
    }
  }

define "Qualifying Sleep Study Procedure Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Sleep-Study-Procedure' },
            display: string { value: 'Qualifying Sleep Study Procedure' }
        }
    }
  }

define "Qualifying Other Procedure Assertion":
  FHIR.CodeableConcept {
    coding: {
        Coding {
            system: uri { value: 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-paa-screening-codes' },
            code: code { value: 'Qualifying-Other-Procedure' },
            display: string { value: 'Qualifying Other Procedure' }
        }
    }
  }