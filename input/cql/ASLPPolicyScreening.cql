library ASLPPolicyScreening

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'
include ASLPPolicyCaseFeatures called PCF
 
codesystem "ICD10": 'http://hl7.org/fhir/sid/icd-10-cm'  
codesystem "ConditionClinicalStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-clinical'
codesystem "ConditionVerificationStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-ver-status'
codesystem "LOINC": 'http://loinc.org'
codesystem "SNOMEDCT": 'http://snomed.info/sct'
 
valueset "Excessive Daytime Sleepiness ValueSet": ' '
valueset "Epworth Sleepiness Scale ValueSet": ' '
valueset "Sleepiness While Driving ValueSet": ''
valueset "Loud and Intense Snoring ValueSet": ''
valueset "Nocturnal Apnea ValueSet": ''
valueset "Comorbid Medical Conditions ValueSet": ''
valueset "Neuromuscular Disease ValueSet": ''
valueset "Moderate to Severe Pulmonary Disease ValueSet": ''
valueset "Pulmonary Disease Including COPD ValueSet": ''
valueset "Pulmonary Disease Including Asthma ValueSet": ''
valueset "Cardiac Disease ValueSet": ''
valueset "Eligible Devices ValueSet": ' '
valueset "Safe Home Use ValueSet": ''
valueset "Physician Can Evaluate Results ValueSet": ''


code "Excessive Daytime Sleepiness code": 'G47.10' from "ICD10" display 'Excessive Daytime Sleepiness'
code "Epworth Sleepiness Scale Code": '763254009' from "SNOMEDCT" display 'Epworth Sleepiness Scale'
code "Loud Snoring code": 'R06.83' from "ICD10" display 'Loud/Intense Snoring'
code "Witnessed Nocturnal Apnea code": 'G47.3' from "ICD10" display 'Witnessed nocturnal apnea, choking and/or gasping'
code "active": 'active' from "ConditionClinicalStatusCodes"
code "confirmed": 'confirmed' from ConditionVerificationStatusCodes
code "Carbon Dioxide [Partial Pressure] In Exhaled Gas": '1989-1' from "LOINC" display 'Carbon Dioxide [Partial Pressure] In Exhaled Gas'
code "Chronic obstructive pulmonary disease": 'LA28200-6' from "LOINC"
code "FEV1": '20150-9' from "LOINC" display 'forced expiratory volume in one second'
code "Pulmonary function test panel": '81458-2' from "LOINC"
code "Asthma": 'J45' from "ICD10"
code "Asthma/chronic obstructive lung disease or chronic lung disease in last 7 days": '54822-2' from "LOINC" //IDK if I should use this one or just asthma^
code "Neuromuscular Diseases": 'G70.9' from "ICD10" display 'Myoneural disorder'
code "Cardiac Disease": '45641-8' from "LOINC" display 'Congestive heart failure [Minimum Data Set]'

context Patient

//use accelerator kit to produce these
define "Patient Age":
  AgeInYearsAt(Now()) 

define "Patient Age >= 18":
  AgeInYearsAt(Now()) >= 18

//Excessive Daytime Sleepiness criteria
define "Excessive Daytime Sleepiness criteria":
  ("Excessive Daytime Sleepiness Observation")
    and (
        ("ESS Score >= 10")
        or exists("Excessive Sleepiness While Driving")
        or exists("Loud Intense Snoring")
        or exists("Nocturnal Apnea")
    )

define "Excessive Daytime Sleepiness":
  [Observation: "Excessive Daytime Sleepiness code"] O 
    where O.status = 'corrected'

define "Excessive Daytime Sleepiness Observation":
  exists("Excessive Daytime Sleepiness")

define "Epworth Sleepiness Scale":
  [Observation: "Epworth Sleepiness Scale Code"] O 
    where O.status = 'corrected'

define "Epworth Sleepiness Scale Score >= 10":
  "Epworth Sleepiness Scale" O
    where O.value > 10

define "ESS Score >= 10":
  exists("Epworth Sleepiness Scale Score >= 10")

define "Excessive Sleepiness While Driving":
  [Observation: "Sleepiness While Driving ValueSet"] O 
    where O.status = 'corrected'

define "Excessive Sleepiness While Driving Observation":
  exists("Excessive Sleepiness While Driving")

define "Witnessed Loud Snoring":
  exists("Loud Intense Snoring")

define "Loud Intense Snoring":
  [Condition: "Loud Snoring code"]  C 
    where C.clinicalStatus = "active"
      and C.verificationStatus = "confirmed"

define "Witnessed Nocturnal Apnea":
  exists("Nocturnal Apnea")

define "Nocturnal Apnea":
  [Condition: "Witnessed Nocturnal Apnea code"] C 
    where C.clinicalStatus = "active"
      and C.verificationStatus = "confirmed"

//Absence of comorbid conditions and criteria
define "Has Comorbid Medical Conditions":
  [Condition: "Comorbid Medical Conditions ValueSet"] C
    where C.clinicalStatus = "active"
      and C.verificationStatus = "confirmed"

define "Qualifying Comorbid Medical Conditions":
  [Observation: "Comorbid Medical Conditions ValueSet"] O 
    where O.status = 'corrected'

define "Absence of Comorbid Medical Conditions":
  not exists("Qualifying Comorbid Medical Conditions")
    or not exists("Has Comorbid Medical Conditions") //Should we use the observation or condition??


define "Qualifying Absence Of Comorbid Medical Conditions":
  "Absence of Comorbid Medical Conditions"
    and (
        ("Has Moderate To Severe Pulmonary Disease")
        or exists("Neuromuscular Disease With Associated Pulmonary Disease")
        or exists("Qualifying Cardiac Disease")
    )


define "Has Moderate To Severe Pulmonary Disease":
  exists("Qualifying Moderate To Severe Pulmonary Disease")
    and (
        exists("Moderate To Severe Pulmonary Disease Including COPD")
        or exists("Moderate To Severe Pulmonary Disease Including Asthma")
    ) 

define "Qualifying Moderate To Severe Pulmonary Disease":
  [Observation: "Pulmonary function test panel"] O 
    where O.status = 'corrected'
    //O.code ~ "Pulmonary function test panel" or O.code = "Chronic obstructive pulmonary disease" ; should this be used instead??

define "Pulmonary Disease Including COPD":
  exists("Moderate To Severe Pulmonary Disease Including COPD")

define "Moderate To Severe Pulmonary Disease Including COPD":
  [Observation: "Chronic obstructive pulmonary disease"] O 
    where exists(
        O.component c where(
            c.code ~ "FEV1"
            and c.value <= 60
            and c.value.unit = '%'
        )
        and (
            c.code ~ "Carbon Dioxide [Partial Pressure] In Exhaled Gas"
            and c.value >= 45
            and c.value.unit = 'mm[Hg]'
        )
      )
    and O.status = 'corrected'

define "Pulmonary Disease Including Asthma":
  exists("Moderate To Severe Pulmonary Disease Including Asthma")

define "Moderate To Severe Pulmonary Disease Including Asthma":
  [Observation: "Chronic obstructive pulmonary disease"] O 
    where exists(
        O.component c where(
            c.code ~ "Asthma"
        )
    )
    and O.status = 'corrected'

define "Qualified Neuromuscular Disease With Associated Pulmonary Disease":
  exists("Neuromuscular Disease With Associated Pulmonary Disease")

define "Qualifying Neuromuscular Disease":
  [Observation: "Neuromuscular Diseases"] O 
    where O.status = 'corrected'

define "Neuromuscular Disease With Associated Pulmonary Disease":
  [Observation: "Chronic obstructive pulmonary disease"] O 
    where exists(
        O.component c where(
            c.code ~ "Neuromuscular Diseases"
        )
    )
    and O.status = 'corrected'

define "Cardiac Disease Observation":
  exists("Qualifying Cardiac Disease")

define "Qualifying Cardiac Disease":
  [Observation: "Cardiac Disease"] O 
    where O.status = 'corrected'

define "Qualified Device Observation":
  exists("Qualified Device")

//Do we want device or device req??
define "Qualified Device Request":
  [DeviceRequest: "Eligible Devices ValueSet"] DevReq 
    where DevReq.status = 'active'

define "Qualified Device": 
  [Device: "Eligible Devices ValueSet"] DR 
    where DR.status = 'active'

define "Safe Use Of Equipment At Home Observation":
  exists("Can Safely Use Equipment At Home")

define "Can Safely Use Equipment At Home":
  [Observation: "Safe Home Use ValueSet"] O 
    where O.status = 'corrected'

define "Physician Evaluated Results Observation":
  exists("Physician Evaluated Results")

define "Physician Evaluated Results":
  [Observation: "Physician Can Evaluate Results ValueSet"] O 
    where O.status = 'corrected'