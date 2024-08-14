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
valueset "Parkinson's disease (Disorders)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1146.1048'
valueset "Spina Bifida (Disorders)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1146.2122'
valueset "Guillain Barré syndrome (Disorders)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1146.666'
valueset "Poliomyelitis (Disorders)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1146.124'
valueset "Neuromuscular Disease": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1029.306'
valueset "Chronic Heart Failure (CHF)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1235.246'
valueset "LVEF Assessment": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.258'
valueset "Pulmonary Hypertension Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.93'
valueset "Cardiac Arrhythmias": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1251.24'

code "Difficulty driving a car (finding)": '300638003' from SNOMEDCT display 'Difficulty driving a car (finding)'
code "Obstructive Sleep Apnea of Adult (Disorder)": '1101000119103' from SNOMEDCT display 'Obstructive Sleep Apnea of Adult (Disorder)'
code "Stimulation of hypoglossal nerve for sleep apnea (procedure)": '868249004' from SNOMEDCT display 'Stimulation of hypoglossal nerve for sleep apnea (procedure)'
code "Diagnostic": 'D0120-D0999' from CDT display 'Diagnostic'
code "Epworth Sleepiness Scale Code": '763254009' from "SNOMEDCT" display 'Epworth Sleepiness Scale'
code "Snoring": 'R06.83' from "ICD10" display 'Snoring' 
code "Central sleep apnea syndrome (disorder)": '27405005' from "SNOMEDCT" display 'Central sleep apnea syndrome (disorder)'
code "Central sleep apnea co-occurrent with Cheyne Stokes respiration (disorder)": '724506009' from SNOMEDCT display 'Central sleep apnea co-occurrent with Cheyne Stokes respiration (disorder)'
code "Central sleep apnea caused by high altitude (disorder)": '91441000119109' from SNOMEDCT display 'Central sleep apnea caused by high altitude (disorder)'
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
code "Amyotrophic lateral sclerosis (disorder)": '86044005' from SNOMEDCT display 'Amyotrophic lateral sclerosis (disorder)'
code "Multiple sclerosis (disorder)": '24700007' from SNOMEDCT display 'Multiple sclerosis (disorder)'
code "Myotonic dystrophy (disorder)": '1177122009' from SNOMEDCT display 'Myotonic dystrophy (disorder)'
code "Respiratory distress (finding)": '271825005' from SNOMEDCT display 'Respiratory distress (finding)'
code "History of cerebrovascular accident with residual deficit (situation)": '440140008' from SNOMEDCT display 'History of cerebrovascular accident with residual deficit (situation)'
code "Epilepsy control poor (finding)": '314828009' from SNOMEDCT display 'Epilepsy control poor (finding)'
code "Duchenne muscular dystrophy (disorder)": '76670001' from SNOMEDCT display 'Duchenne muscular dystrophy (disorder)'
code "Spinal muscular atrophy (disorder)": '5262007' from SNOMEDCT display 'Spinal muscular atrophy (disorder)'
code "Myasthenia gravis (disorder)": '91637004' from SNOMEDCT display 'Myasthenia gravis (disorder)'
code "Friedreich ataxia (disorder)": '10394003' from SNOMEDCT display 'Friedreich ataxia (disorder)'
code "Autosomal recessive muscular dystrophy with limb girdle distribution (disorder)": '240054004' from SNOMEDCT display 'Autosomal recessive muscular dystrophy with limb girdle distribution (disorder)'
code "Parasomnia (disorder)": '58690002' from SNOMEDCT display 'Parasomnia (disorder)'
code "Confusional arousal disorder (disorder)": '441830002' from SNOMEDCT display 'Confusional arousal disorder (disorder)'
code "Nocturnal epilepsy (disorder)": '230445007' from SNOMEDCT display 'Nocturnal epilepsy (disorder)'
code "Sleep-related dissociative disorder (disorder)": '429571005' from SNOMEDCT display 'Sleep-related dissociative disorder (disorder)'
code "REM sleep behavior disorder": 'G47.52' from ICD10 display 'REM sleep behavior disorder'
code "Paroxysmal nocturnal dyspnea (finding)": '55442000' from SNOMEDCT display 'Paroxysmal nocturnal dyspnea (finding)'
code "Benign Rolandic epilepsy (disorder)": '' from SNOMEDCT display 'Benign Rolandic epilepsy (disorder)'
code "Frontal lobe epilepsy (disorder)": 'Frontal lobe epilepsy (disorder)' from SNOMEDCT display 'Frontal lobe epilepsy (disorder)'
code "Temporal lobe epilepsy (disorder)": '193000002' from SNOMEDCT display 'Temporal lobe epilepsy (disorder)'
code "Lennox-Gastaut syndrome (disorder)": '230418006' from SNOMEDCT display 'Lennox-Gastaut syndrome (disorder)'
code "Juvenile myoclonic epilepsy (disorder)": '6204001' from SNOMEDCT display 'Juvenile myoclonic epilepsy (disorder)'
code "Periodic limb movement disorder": 'G47.61' from ICD10 display 'Periodic limb movement disorder'
code "Complies with diagnostic test protocol (finding)": '1145284009' from SNOMEDCT display 'Complies with diagnostic test protocol (finding)'

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
  exists([Condition: "Difficulty driving a car (finding)"])

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
    or "Has Moderate To Severe Pulmonary Disease"
    or "Has Neuromuscular Disease With Associated Pulmonary Disease"
    or "Has Parasomnia"
    or "Has Paroxysmal Arousal or Other Sleep Disruptions Thought to be Seizure Related"
    or "Has Periodic Limb Movement Disorder (PLMD)"
    or "Has Cardiac Disease"

//Diagnostic testing 
define "Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
    exists([Observation: "Complies with diagnostic test protocol (finding)"])
        and exists("Qualifying Diagnosis of Obstructive Sleep Apnea (OSA)") OSA
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
    union ([Condition: "Central sleep apnea co-occurrent with Cheyne Stokes respiration (disorder)"]).active().confirmed()
    union ([Condition: "Central sleep apnea caused by high altitude (disorder)"]).active().confirmed()

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
    exists(([Condition: "Traumatic brain injury (disorder)"]).active().confirmed()) TBI
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
            and exists(Appt.reasonCode.coding) C
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
            or exists([Condition: "Hypoventilation Disorder"]).active().confirmed()
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
    ([Condition: "Uncontrolled or severe asthma"]).active().confirmed()
    union ([Condition: "Asthma disturbing sleep (finding)"]).active().confirmed()


//Neuromuscular disease with associated pulmonary disease including, but not limited to: amyotrophic lateral sclerosis, multiple sclerosis, myotonic dystrophy, Parkinson's, previous stroke with residual respiratory effects, spina bifida, or uncontrolled epilepsy
define "Has Neuromuscular Disease With Associated Pulmonary Disease":
    exists("Neuromuscular Disease Diagnosis With Associated Pulmonary Disease")

define "Neuromuscular Disease Diagnosis With Associated Pulmonary Disease":
    "Neuromuscular Disease With Associated Pulmonary Disease"
    union ([Condition: "Amyotrophic lateral sclerosis (disorder)"]).active().confirmed()
    union ([Condition: "Multiple sclerosis (disorder)"]).active().confirmed()
    union ([Condition: "Myotonic dystrophy (disorder)"]).active().confirmed()
    union ([Condition: "Parkinson's disease (Disorders)"]).active().confirmed()
    union "Previous Stroke With Residual Respiratory Effects"
    union ([Condition: "Spina Bifida (Disorders)"]).active().confirmed()
    union ([Condition: "Epilepsy control poor (finding)"]).active().confirmed()
    union ([Condition: "Duchenne muscular dystrophy (disorder)"]).active().confirmed()
    union ([Condition: "Spinal muscular atrophy (disorder)"]).active().confirmed()
    union ([Condition: "Myasthenia gravis (disorder)"]).active().confirmed()
    union ([Condition: "Guillain Barré syndrome (Disorders)"]).active().confirmed()
    union ([Condition: "Poliomyelitis (Disorders)"]).active().confirmed()
    union ([Condition: "Friedreich ataxia (disorder)"]).active().confirmed()
    union ([Condition: "Autosomal recessive muscular dystrophy with limb girdle distribution (disorder)"]).active().confirmed()

define "Neuromuscular Disease With Associated Pulmonary Disease":
    (([Condition: "Neuromuscular Disease"]).active().confirmed()) Neuromuscular
        where exists(([Condition: "Disorder of lung (disorder)"]).active().confirmed()) Pulmonary
            where Pulmonary.onset after Neuromuscular.onset

define "Previous Stroke With Residual Respiratory Effects":
    (([Condition: "History of cerebrovascular accident with residual deficit (situation)"]).active().confirmed()) Stroke
        where exists(([Condition: "Respiratory distress (finding)"]).active().confirmed()) R
            where R.onset after Stroke.onset

//Parasomnias
define "Has Parasomnia":
    exists("Qualifying Parasomnias")

define "Qualifying Parasomnias":
    ([Condition: "Parasomnia (disorder)"]).active().confirmed()
    union ([Condition: "Confusional arousal disorder (disorder)"]).active().confirmed()
    union ([Condition: "Nocturnal epilepsy (disorder)"]).active().confirmed()
    union ([Condition: "Sleep-related dissociative disorder (disorder)"]).active().confirmed()
    union ([Condition: "REM sleep behavior disorder"]).active().confirmed()

//Paroxysmal arousals or other sleep disruptions thought to be seizure related
define "Has Paroxysmal Arousal or Other Sleep Disruptions Thought to be Seizure Related":
    exists("Qualifying Paroxysmal Arousal or Other Sleep Disruptions Thought to be Seizure Related")

define "Qualifying Paroxysmal Arousal or Other Sleep Disruptions Thought to be Seizure Related":
    ([Condition: "Nocturnal epilepsy (disorder)"]).active().confirmed()

//Periodic Limb Movement Disorder (PLMD)
define "Has Periodic Limb Movement Disorder (PLMD)":
    exists("Qualifying Periodic Limb Movement Disorder")

define "Qualifying Periodic Limb Movement Disorder":
    ([Condition: "Periodic limb movement disorder"]).active().confirmed()

//cardiac disease
define "Has Cardiac Disease":
    exists("Qualifying Cardiac Disease")
        or exists("LVEF < 45 Observed")

define "Qualifying Cardiac Disease":
  ([Condition: "Chronic Heart Failure (CHF)"]).active().confirmed()
  union ([Condition: "Pulmonary Hypertension Disorder"]).active().confirmed()
  union ([Condition: "Cardiac Arrhythmias"])

define "LVEF < 45 Observed":
    ([Observation: "LVEF Assessment"]) LVEF
        where LVEF.value < 45 '%'