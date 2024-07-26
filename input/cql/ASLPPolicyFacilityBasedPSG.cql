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
codesystem "CDT": 'http://www.ada.org/cdt'
 
valueset "Excessive Daytime Sleepiness (Drowsiness) ValueSet": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1078.769'
valueset "Sleep Apnea": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1222.102' 

code "Obstructive Sleep Apnea of Adult (Disorder)": '1101000119103' from SNOMEDCT display 'Obstructive Sleep Apnea of Adult (Disorder)'
code "Stimulation of hypoglossal nerve for sleep apnea (procedure)": '868249004' from SNOMEDCT display 'Stimulation of hypoglossal nerve for sleep apnea (procedure)'
code "Diagnostic": 'D0120-D0999' from CDT display 'Diagnostic'
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
  ("Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA"
    or "Central Sleep Apnea (CSA)"
    or "Narcolepsy When MSLT is Planned"
    or "Qualifying Obesity Hypoventilation Syndrome (OHS)"
    or "History of Traumatic Brain Injury (TBI) with Excessive Daytime Sleepiness (EDS)"
    or "Idiopathic Central Nervous System Hyperinsomnia When MSLT is Planned"
    or "Has Mission Critical Profession"
    or "Moderate to Severe Pulmonary Disease"
    or "Neuromuscular Disease With Associated Pulmonary Disease"
    or "Unusual or Atypical Parasomnias"
    or "Paroxysmal Arousals or Other Sleep Disruptions Thought to be Seizure Related"
    or "Periodic Limb Movement Disorder"
    or "Cardiac Disease"
  )

define "Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
    exists("Qualifying Diagnosis of Obstructive Sleep Apnea (OSA)") 
        and exists("Planned Hypoglossal Nerve Stimulator (HGNS) Implantation") HGNS
            where exists(["DiagnosticReport": "Diagnostic"] D
                where D.effective before HGNS.performed)

define "Qualifying Diagnosis of Obstructive Sleep Apnea (OSA)":
    ([Condition: "Obstructive Sleep Apnea of Adult (Disorder)"]).active().confirmed()

define "Planned Hypoglossal Nerve Stimulator (HGNS) Implantation":
    ([Procedure: "Stimulation of hypoglossal nerve for sleep apnea (procedure)"]) HGNS 
        where HGNS.status = 'not-done'