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
valueset "Obesity": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1235.417' 
valueset "Hypothyroidism": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1178.6'
valueset "Narcolepsy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1222.1510'

code "Obstructive Sleep Apnea of Adult (Disorder)": '1101000119103' from SNOMEDCT display 'Obstructive Sleep Apnea of Adult (Disorder)'
code "Stimulation of hypoglossal nerve for sleep apnea (procedure)": '868249004' from SNOMEDCT display 'Stimulation of hypoglossal nerve for sleep apnea (procedure)'
code "Diagnostic": 'D0120-D0999' from CDT display 'Diagnostic'
code "Epworth Sleepiness Scale Code": '763254009' from "SNOMEDCT" display 'Epworth Sleepiness Scale'
code "Snoring": 'R06.83' from "ICD10" display 'Snoring' 
code "Central sleep apnea syndrome (disorder)": '27405005' from "SNOMEDCT" display 'Central sleep apnea syndrome (disorder)'
code "Multiple sleep latency test (procedure)": '252731002' from "SNOMEDCT" display 'Multiple sleep latency test (procedure)'
code "Narcolepsy with cataplexy": 'G47.411' from ICD10 display 'Narcolepsy with cataplexy'
code "Hypnagogic hallucinations (finding)": '44780000' from SNOMEDCT display 'Hypnagogic hallucinations (finding)'
code "Excessive daytime sleepiness with sleep paralysis (disorder)": '230492006' from SNOMEDCT display 'Excessive daytime sleepiness with sleep paralysis (disorder)'
code "Alveolar hypoventilation (finding)": '15993004' from SNOMEDCT display 'Alveolar hypoventilation (finding)'
code "Neurogenic muscle weakness, ataxia and retinitis pigmentosa (disorder)": '237984008' from SNOMEDCT display 'Neurogenic muscle weakness, ataxia and retinitis pigmentosa (disorder)'
code "Disorder of pleura AND/OR pleural cavity (disorder)": '233635001' from SNOMEDCT display 'Disorder of pleura AND/OR pleural cavity (disorder)' 
code "Disorder of respiratory system (disorder)": '50043002' from SNOMEDCT display 'Disorder of respiratory system (disorder)'
code "Disorder of skeletal system (disorder)": '88230002' from SNOMEDCT display 'Disorder of skeletal system (disorder)'
code "Traumatic brain injury (disorder)": '127295002' from SNOMEDCT display 'Traumatic brain injury (disorder)'
code "Hypersomnia (disorder)": '77692006' from SNOMEDCT display 'Hypersomnia (disorder)'
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
  "Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA"
    or "Has Central Sleep Apnea (CSA)"
    or "Has Qualifying Feature Associated With Narcolepsy When MSLT is Planned"
    or "Has Obesity Hypoventilation Syndrome (OHS)"
    or "Has History of Traumatic Brain Injury (TBI) with Excessive Daytime Sleepiness (EDS)"
    or "Idiopathic Central Nervous System Hyperinsomnia When MSLT is Planned"
    or "Lacks Cognitive Function, Dexterity, or Mobility for Safe Use of Equipment"
    or "Has Mission Critical Profession"
    or "Moderate to Severe Pulmonary Disease"
    or "Neuromuscular Disease With Associated Pulmonary Disease"
    or "Unusual or Atypical Parasomnias"
    or "Paroxysmal Arousals or Other Sleep Disruptions Thought to be Seizure Related"
    or "Periodic Limb Movement Disorder"
    or "Cardiac Disease"

//Diagnostic testing 
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

//Central Sleep Apnea (CSA)
define "Has Central Sleep Apnea (CSA)":
    exists("Qualifying Central Sleep Apnea")

define "Qualifying Central Sleep Apnea":
    ([Condition: "Central sleep apnea syndrome (disorder)"]).active().confirmed()

//Features associated with narcolepsy (moderate to severe daytime sleepiness associated with cataplexy, hypnagogic hallucinations, or sleep paralysis) when MSLT is planned
define "Has Qualifying Feature Associated With Narcolepsy When MSLT is Planned":
    exists(
        (([Condition: "Narcolepsy with cataplexy"]).active().confirmed()
        union ([Condition: "Hypnagogic hallucinations (finding)"]).active().confirmed()
        union ([Condition: "Excessive daytime sleepiness with sleep paralysis (disorder)"]).active().confirmed()
        ) Narcolepsyfeature
            where exists([Appointment]) Appt
                where Appt.status = 'booked'
                and Appt.start after Narcolepsyfeature.onset
            and exists(Appt.serviceType.coding) C
                where C.display = 'Multiple sleep latency test (procedure)'
                or C.code = '252731002'
    ) 
     
//Obesity Hypoventilation Syndrome (OHS)
define "Has Obesity Hypoventilation Syndrome (OHS)":
    "Qualifying Obesity Hypoventilation Syndrome (OHS)"

define "Qualifying Obesity Hypoventilation Syndrome (OHS)":
    exists([Observation: "Obesity"])
        and exists ([Observation: "Alveolar hypoventilation (finding)"])
            and not exists(
                ([Condition: "Hypothyroidism"]).active().confirmed()
                    union ([Condition: "Neurogenic muscle weakness, ataxia and retinitis pigmentosa (disorder)"]).active().confirmed()
                    union ([Condition: "Disorder of pleura AND/OR pleural cavity (disorder)"]).active().confirmed()
                    union ([Condition: "Disorder of respiratory system (disorder)"]).active().confirmed()
                    union ([Condition: "Disorder of skeletal system (disorder)"]).active().confirmed()
            )

//Traumatic Brain Injury (TBI) with EDS
define "Has History of Traumatic Brain Injury (TBI) with Excessive Daytime Sleepiness (EDS)":
    exists([Condition: "Traumatic brain injury (disorder)"]).active().confirmed()) TBI
        where TBI.onset before Now()
            and exists(
                ([Condition: "Excessive Daytime Sleepiness (Drowsiness) ValueSet"]).active().confirmed()
                union ([Condition: "Narcolepsy"]).active().confirmed()
                union ([Condition: "Hypersomnia (disorder)"]).active().confirmed()
            ) EDS
                where EDS.onset after TBI.onset