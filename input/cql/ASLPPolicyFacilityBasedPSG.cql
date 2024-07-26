library ASLPPolicyFacilityBasedPSG

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'
include ASLPPolicyCaseFeatures called PCF
 
codesystem "ICD10": 'http://hl7.org/fhir/sid/icd-10-cm' 
codesystem "LOINC": 'http://loinc.org'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
 
valueset "Excessive Daytime Sleepiness (Drowsiness) ValueSet": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1078.769'
valueset "Sleep Apnea": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1222.102' 

code "Epworth Sleepiness Scale Code": '763254009' from "SNOMEDCT" display 'Epworth Sleepiness Scale'
code "Snoring": 'R06.83' from "ICD10" display 'Snoring' 
code "Periodic Limb Movement Disorder": 'G47.61' from "ICD10" display 'Periodic Limb Movement Disorder'

context Patient

define "Patient Age":
  AgeInYearsAt(Now()) 

define "Patient Age >= 18":
  AgeInYearsAt(Now()) >= 18

//Excessive Daytime Sleepiness criteria
define "Excessive Daytime Sleepiness criteria":
  ("Has Excessive Daytime Sleepiness")
    and (
        ("Has ESS Score GTE 10")
        or ("Has Excessive Sleepiness While Driving")
        or exists("Loud Intense Snoring")
        or exists("Nocturnal Apnea")
    )

define "Excessive Daytime Sleepiness":
  ([Condition: "Excessive Daytime Sleepiness (Drowsiness) ValueSet"]).active().confirmed() 

define "Has Excessive Daytime Sleepiness":
  exists("Excessive Daytime Sleepiness")

define "Epworth Sleepiness Scale":
  ([Observation: "Epworth Sleepiness Scale Code"]).resulted() 

define "Epworth Sleepiness Scale Score >= 10":
  "Epworth Sleepiness Scale" O
    where O.value > 10

define "Has ESS Score GTE 10":
  exists("Epworth Sleepiness Scale Score >= 10")

define "Has Excessive Sleepiness While Driving":
  null as System.Boolean

define "Loud Intense Snoring":
  ([Condition: "Snoring"]).active().confirmed()

define "Nocturnal Apnea":
  ([Condition: "Sleep Apnea"]).active().confirmed()

//Presence of any one of following medical conditions
define "Presence of Applicable Medical Condition":
  "Diagnostic testing prior to planned HGNS implantation and diagnosis of OSA"
    union "Central Sleep Apnea (CSA)"
    union "Narcolepsy When MSLT Is Planned"
    union "Qualifying Obesity Hypoventilation Syndrome (OHS)"
    union "History of Traumatic Brain Injury (TBI) with Excessive Daytime Sleepiness (EDS)"
    union "Idiopathic Central Nervous System Hyperinsomnia When MSLT Is Planned"
    union "Has Mission Critical Profession"
    union "Moderate to Severe Pulmonary Disease"
    union "Neuromuscular Disease With Associated Pulmonary Disease"
    union "Unusual or Atypical Parasomnias"
    union "Paroxysmal Arousals or Other Sleep Disruptions Thought to be Seizure Related"
    union "Periodic Limb Movement Disorder"
    union "Cardiac Disease"

