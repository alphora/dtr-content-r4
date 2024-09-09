library ASLPPolicyScreening

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'
include ASLPPolicyCaseFeatures called PCF
 
codesystem "ICD10": 'http://hl7.org/fhir/sid/icd-10-cm' 
codesystem "LOINC": 'http://loinc.org'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
 
//valuesets not in repo
valueset "Excessive Daytime Sleepiness (Drowsiness) ValueSet": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1078.769'
//valueset "Sleepiness While Driving ValueSet": '' //can't find valueset or code
valueset "Sleep Apnea Disorders ValueSet": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1222.102' //does not have nocturnal but has insomnia
// valueset "Comorbid Medical Conditions ValueSet": '' //can't find valueset or code
// valueset "Safe Home Use ValueSet": '' //can't find valueset or code
// valueset "Physician Can Evaluate Results ValueSet": '' //can't find valueset or code

//Valuesets in repo
valueset "Home Sleep Study Devices": 'http://cts.nlm.nih.gov/fhir/ValueSet/HomeSleepStudyDevices'
valueset "Chronic Obstructive Lung Disease (COPD)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.6'
valueset "Asthma VS": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.362'
valueset "Forced Expiratory Volume in One Second (FEV1)Forced Vital Capacity (FVC) Measurement": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.124'
valueset "Past Medical History Condition Related to Need for Positive Airway Pressure Device": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.135'
valueset "Acute or Chronic Heart Failure Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.24'
valueset "Pulmonary Hypertension Disorder": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.93'
valueset "Heart Failure Diagnosis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1222.1543'
valueset "COVID19 SNOMED Value Set for Muscular Dystrophy": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.3616.200.110.102.6183'
valueset "Hypoventilation Disorder VS": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1219.121'
valueset "Moderate to Severe Pulmonary Disease VS": 'http://example.org/sdh/dtr/aslp/ValueSet/ModerateToSeverePulmonaryDisease'

//Can't find valuesets
code "Epworth Sleepiness Scale Code": '763254009' from "SNOMEDCT" display 'Epworth Sleepiness Scale'
code "Snoring code": 'R06.83' from "ICD10" display 'Snoring' //Can't find a code for loud snoring

context Patient

//use accelerator kit to produce these
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

define "Witnessed Loud Snoring":
  exists("Loud Intense Snoring")

define "Loud Intense Snoring":
  ([Condition: "Snoring code"]).active().confirmed()

define "Witnessed Nocturnal Apnea":
  exists("Nocturnal Apnea")

define "Nocturnal Apnea":
  ([Condition: "Sleep Apnea Disorders ValueSet"]).active().confirmed()

//Absence of comorbid conditions and criteria
define "Evidence of Comorbid Medical Conditions":
  "Qualifying Moderate To Severe Pulmonary Disease"
    union "Diagnosed COPD"
    union {"Most Recent FEV1"}
    union "Hypoventilation Disorder"
    union "Diagnosed Asthma"
    union "Neuromuscular Disease Diagnosis"
    union "Pulmonary Disease Diagnosis"
    union "Qualifying Cardiac Disease"

define "Has Comorbid Medical Conditions":
  "Has Moderate To Severe Pulmonary Disease"
    or "Neuromuscular Disease With Associated Pulmonary Disease"
    or "Has Cardiac Disease" 

define "Has No Comorbid Medical Conditions":
  not "Has Comorbid Medical Conditions"

//Pulmonary Disease
define "Has Moderate To Severe Pulmonary Disease":
  exists("Qualifying Moderate To Severe Pulmonary Disease")
    or ( 
      exists("Diagnosed COPD") 
        and ( ("Most Recent FEV1 < 60") or exists("Hypoventilation Disorder") ) 
      )
    or ("Has Diagnosed Asthma")

define "Qualifying Moderate To Severe Pulmonary Disease":
  ([Observation: "Moderate to Severe Pulmonary Disease VS"]).resulted() 

//COPD
define "Has Diagnosed COPD":
  "Moderate To Severe Pulmonary Disease Including COPD"

define "Moderate To Severe Pulmonary Disease Including COPD":
  "Has Moderate To Severe Pulmonary Disease"
    and (
      exists("Diagnosed COPD")
        and ( ("Most Recent FEV1 < 60") or exists("Hypoventilation Disorder") )
      )

define "Diagnosed COPD":
  ([Condition: "Chronic Obstructive Lung Disease (COPD)"]).active().confirmed()

define "Most Recent FEV1":
  PCF.MostRecent(
    ([Observation: "Forced Expiratory Volume in One Second (FEV1)Forced Vital Capacity (FVC) Measurement"]).resulted() 
  )

define "Most Recent FEV1 < 60":
  "Most Recent FEV1".value <= 60 '%'

define "Hypoventilation Disorder":
  ([Condition: "Hypoventilation Disorder VS"]).active().confirmed()

//Asthma
define "Moderate To Severe Pulmonary Disease Including Asthma":
  "Has Moderate To Severe Pulmonary Disease"
    and "Has Diagnosed Asthma"

define "Has Diagnosed Asthma": //rename
  exists("Diagnosed Asthma")

define "Diagnosed Asthma": //Moderate to severe with asthma
  ([Condition: "Asthma VS"]).active().confirmed()

//Neuromuscular
// define "Qualified Neuromuscular Disease With Associated Pulmonary Disease":
//   exists("Neuromuscular Disease With Associated Pulmonary Disease")

define "Neuromuscular Disease With Associated Pulmonary Disease":
  exists("Neuromuscular Disease Diagnosis")
    or exists("Pulmonary Disease Diagnosis")

define "Neuromuscular Disease Diagnosis":
  ([Condition: "COVID19 SNOMED Value Set for Muscular Dystrophy"]).active().confirmed()

define "Pulmonary Disease Diagnosis":
  ([Condition: "Pulmonary Hypertension Disorder"]).active().confirmed()

//cardiac disease
define "Has Cardiac Disease":
  exists("Qualifying Cardiac Disease")

define "Qualifying Cardiac Disease":
  ([Condition: "Heart Failure Diagnosis"]).active().confirmed()

//qualified device
define "Qualified Device Observation":
  exists("Qualified Device Request")

define "Qualified Device Request":
  [DeviceRequest: "Home Sleep Study Devices"] DevReq 
    where DevReq.status = 'active'
      and DevReq.intent = 'order'


//safe home use
define "Safe Use Of Equipment At Home Observation":
  null as System.Boolean

//physician evaluation
define "Physician Evaluated Results Observation":
  null as System.Boolean

define "Qualifying Diagnosis of Obstructive Sleep Apnea (OSA)":
  (([Condition: Cx."Mild OSA"]).active().confirmed()) OSA
    where exists(OSA.severity.coding) severity
            where severity.code ~ '255604002'
                or severity.display ~ 'Mild'

//Diagnostic Testing Prior to Planned HGNS Implantation
define "Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
  exists ( "Has BMI less than 35 kg/m2" ) //https://resources.massgeneralbrighamhealthplan.org/medicalpolicy/SleepStudies.pdf
    and exists ( "DISE performed" )
    and exists ( "Qualifying Diagnosis of Obstructive Sleep Apnea (OSA)" )
    and exists ( "Planned Hypoglossal Nerve Stimulator (HGNS) Implantation" )

define "Has BMI less than 35 kg/m2":
  ([Observation: Cx."BMI Less than 35"]).resulted()

define "DISE performed":
  ([Procedure: Cx."DISE"]) DISE
    where DISE.status ~ 'completed'

define "Planned Hypoglossal Nerve Stimulator (HGNS) Implantation":
    ([Procedure: Cx."HGNS implantation"]) HGNS 
        where HGNS.status ~ 'not-done'
        or HGNS.status ~ 'preparation'
        or HGNS.status ~ 'on-hold'

//CSA
define "Has Central Sleep Apnea":
  exists("Qualifying Central Sleep Apnea")

define "Qualifying Central Sleep Apnea":
  ([Condition: Cx."Central sleep apnea"]).active().confirmed()

define "Qualifying Narcolepsy":
  ([Condition: Cx."Narcolepsy"]).active().confirmed()

define "Planned Multiple sleep latency test (MSLT)":
  ([Procedure: Cx."MSLT"]) MSLT 
      where MSLT.status ~ 'not-done'
      or MSLT.status ~ 'preparation'
      or MSLT.status ~ 'on-hold'

define "Qualifying Obesity Hypoventilation Syndrome":
  ([Condition: Cx."OHS"]).active().confirmed()

define "Qualifying Idiopathic Central Nervous System Hypersomnia":
  ([Condition: Cx."Idiopathic CNS Hypersomnia"]).active().confirmed()

define "Qualifying Impairment for Safe Use of Equipment":
  ([Observation: Cx."Impairment"]).resulted()

define "Qualifying Mission Critical Profession": 
  ([Observation: Cx."Profession"]).resulted()

define "Qualifying Parasomnias":
  ([Condition: Cx."Parasomnias"]).active().confirmed()

define "Qualifying Sleep Disruptions Thought to be Seizure Related":
  ([Condition: Cx."Sleep disruptions due to seizure"]).active().confirmed()

define "Qualifying Periodic Limb Movement Disorder":
  ([Condition: Cx."PLMD"]).active().confirmed()