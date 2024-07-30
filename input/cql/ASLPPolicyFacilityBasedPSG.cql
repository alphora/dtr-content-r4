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
valueset "Chronic Obstructive Lung Disease (COPD)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.6'
valueset "Forced Expiratory Volume in One Second (FEV1)Forced Vital Capacity (FVC) Measurement": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.124'
valueset "Hypoventilation Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.121'
valueset "Arterial Blood Gases PaCO2": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.3616.200.110.102.5002'
valueset "Uncontrolled or severe asthma": 'http://cts.nlm.nih.gov/fhir/ValueSet/1.3.6.1.4.1.6997.4.1.2.268.13.34951.1.11.1.999.263'

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
code "Idiopathic hypersomnia associated with long sleep time (disorder)": '442416002' from SNOMEDCT display 'Idiopathic hypersomnia associated with long sleep time (disorder)'
code "Oversleeps (disorder)": '248261008' from SNOMEDCT display 'Oversleeps (disorder)'
code "Somnolence": 'R40.0' from ICD10 display 'Somnolence'
code "Sleep drunkenness (disorder)": '192003008' from SNOMEDCT display 'Sleep drunkenness (disorder)'
code "Difficulty using domestic equipment (finding)": '285859009' from SNOMEDCT display 'Difficulty using domestic equipment (finding)'
code "Impaired cognition (finding)": '386806002' from SNOMEDCT display 'Impaired cognition (finding)'
code "Poor manual dexterity (finding)": '306741005' from SNOMEDCT display 'Poor manual dexterity (finding)'
code "Impaired mobility (finding)": '82971005' from SNOMEDCT display 'Impaired mobility (finding)'
code "Airplane pilot (occupation)": '159248008' from SNOMEDCT display 'Airplane pilot (occupation)'
code "Bus/coach driver (occupation)": '266064005' from SNOMEDCT display 'Bus/coach driver (occupation)'
code "Truck and van driver (local transport) (occupation)": '72004008' from SNOMEDCT display 'Truck and van driver (local transport) (occupation)'
code "Truck and van driver (long-distance transport) (occupation)": '87447002' from SNOMEDCT display 'Truck and van driver (long-distance transport) (occupation)'
code "Military personnel (occupation)": '302314004' from SNOMEDCT display 'Military personnel (occupation)'
code "Healthcare professional (occupation)": '223366009' from SNOMEDCT display 'Healthcare professional (occupation)'
code "Security/protective services (occupation)": '265981008' from SNOMEDCT display 'Security/protective services (occupation)'
code "Disorder of lung (disorder)": '19829001' from SNOMEDCT display 'Disorder of lung (disorder)'
code "Symptom moderate (finding)": '162469005' from SNOMEDCT display 'Symptom moderate (finding)'
code "Symptom severe (finding)": '162470006' from SNOMEDCT display 'Symptom severe (finding)'
code "Home oxygen supply (finding)": '268512000' from SNOMEDCT display 'Home oxygen supply (finding)'
code "Asthma disturbing sleep (finding)": '170631002' from SNOMEDCT display 'Asthma disturbing sleep (finding)'
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
    or "Has Idiopathic Central Nervous System Hypersomnia When MSLT is Planned"
    or "Lacks Cognitive Function, Dexterity, or Mobility for Safe Use of Equipment"
    or "Has Mission Critical Profession"
    or "Has Moderate to Severe Pulmonary Disease"
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

//Idiopathic Central Nervous System Hypersomnia when MSLT is planned
define "Has Idiopathic Central Nervous System Hypersomnia When MSLT is Planned":
    exists(
        (([Condition: "Idiopathic hypersomnia associated with long sleep time (disorder)"]).active().confirmed()
        union ([Condition: "Oversleeps (disorder)"]).active().confirmed()
        union ([Condition: "Somnolence"]).active().confirmed()
        union ([Condition: "Sleep drunkenness (disorder)"]).active().confirmed()
        ) Hypersomnia
            where exists([Appointment]) Appt
                where Appt.status = 'booked'
                and Appt.start after Hypersomnia.onset
            and exists(Appt.serviceType.coding) C
                where C.display = 'Multiple sleep latency test (procedure)'
                or C.code = '252731002'
    ) 

//Lack of cognitive function, dexterity, or mobility to use portable monitor (PM) equipment safely at home
define "Lacks Cognitive Function, Dexterity, or Mobility for Safe Use of Equipment":
    exists("Qualifying Impairment for Safe Use of Equipment")

define "Qualifying Impairment for Safe Use of Equipment":
    ([Observation: "Impaired cognition (finding)"])
    union ([Observation: "Poor manual dexterity (finding)"])
    union ([Observation: "Impaired mobility (finding)"])
    union ([Observation: "Difficulty using domestic equipment (finding)"]) 

//Mission critical profession
define "Has Mission Critical Profession":
    exists("Qualifying Mission Critical Profession")

define "Qualifying Mission Critical Profession": 
    ([Observation: "Airplane pilot (occupation)"])
    union ([Observation: "Bus/coach driver (occupation)"])
    union ([Observation: "Truck and van driver (local transport) (occupation)"])
    union ([Observation: "Truck and van driver (long-distance transport) (occupation)"])
    union ([Observation: "Military personnel (occupation)"])
    union ([Observation: "Healthcare professional (occupation)"])
    union ([Observation: "Security/protective services (occupation)"])

//Moderate to severe pulmonary disease
define "Has Moderate To Severe Pulmonary Disease":
  exists("Qualifying Moderate To Severe Pulmonary Disease")

define "Qualifying Moderate To Severe Pulmonary Disease":
    "Moderate to Severe Lung Disorder"
    union "COPD With FEV1 < 60, Home Oxygen Use, Or Hypoventilation"
    union "Nocturnal or Uncontrolled Asthma"

define "Moderate to Severe Lung Disorder":
    (([Condition: "Disorder of lung (disorder)"]).active().confirmed()) PulmonaryDisease
        where exists(PulmonaryDisease.severity.coding) severity
            where severity.code = '162469005'
                or severity.display = 'Symptom moderate (finding)'
                or severity.code = '162470006'
                or severity.display = 'Symptom severe (finding)'

define "COPD With FEV1 < 60, Home Oxygen Use, Or Hypoventilation":
    (([Condition: "Chronic Obstructive Lung Disease (COPD)"]).active().confirmed()) COPD
        where "Most Recent FEV1 < 60"
            or exists([DeviceRequest: "Home oxygen supply (finding)"])
            or exists([Condition: "Hypoventilation Disorder"]) 
            or exists(([Observation: "Arterial Blood Gases PaCO2"]) CO2
                where CO2.value >= 45 
                    and CO2.value.unit = 'mmHg'
            )

define "Most Recent FEV1":
    PCF.MostRecent(
        ([Observation: "Forced Expiratory Volume in One Second (FEV1)Forced Vital Capacity (FVC) Measurement"])
    )

define "Most Recent FEV1 < 60":
    "Most Recent FEV1".value < 60 '%'

define "Nocturnal or Uncontrolled Asthma":
    ([Condition: "Uncontrolled or severe asthma"])
    union ([Condition: "Asthma disturbing sleep (finding)"])