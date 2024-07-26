library ASLPPolicyPAA

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'
include ASLPPolicyCaseFeatures called PCF
include ASLPPolicyConcepts called AC
include ASLPPolicyScreening called PS
include ASLPPolicyFacilityBasedPSG called FacilityPSG
 
context Patient

define "Most Recent Qualifying Patient Age":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Patient Age Assertion".coding)])

define "Qualifying Patient Age":
  if not "Most Recent Qualifying Patient Age" is null
    then "Most Recent Qualifying Patient Age"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Patient Age Assertion",
      PS."Patient Age >= 18",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-patientage-casefeature-definition',
      Patient,
      ''
    )

define "Is Qualifying Age Value":
  "Qualifying Patient Age".value.value as System.Boolean

define "Is Qualifying Age":
  IsTrue("Is Qualifying Age Value")

define "Not Within Qualifying Age":
  IsFalse("Is Qualifying Age Value")

define "Age Unknown":
  IsNull("Is Qualifying Age Value")


define "Most Recent Excessive Daytime Sleepiness Observation":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Excessive Daytime Sleepiness Assertion".coding)])

define "Qualified Excessive Daytime Sleepiness":
  if not "Most Recent Excessive Daytime Sleepiness Observation" is null 
    then "Most Recent Excessive Daytime Sleepiness Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Excessive Daytime Sleepiness Assertion",
      PS."Has Excessive Daytime Sleepiness",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-eds-screening-casefeature',
      PCF.MostRecent(PS."Excessive Daytime Sleepiness"),
      ''
    )

define "Has Excessive Daytime Sleepiness Value":
  "Qualified Excessive Daytime Sleepiness".value.value as System.Boolean

define "Has Excessive Daytime Sleepiness":
  IsTrue("Has Excessive Daytime Sleepiness Value")

define "No Excessive Daytime Sleepiness":
  IsFalse("Has Excessive Daytime Sleepiness Value")

define "Null Excessive Daytime Sleepiness":
  IsNull("Has Excessive Daytime Sleepiness Value")

//Additional EDS Criteria 
define "Has Additional Daytime Sleepiness Indicators Value":
  "Has ESS Score >= 10 Value"
    or "Has Excessive Sleepiness While Driving Value"
    or "Snores loudly/intensely Value"
    or "Has Nocturnal Apnea Value"

define "Has Additional Daytime Sleepiness Indicators":
  IsTrue("Has Additional Daytime Sleepiness Indicators Value")

define "Has No Additional Daytime Sleepiness Indicators":
  IsFalse("Has Additional Daytime Sleepiness Indicators Value")

define "Null Additional Daytime Sleepiness Indicators":
  IsNull("Has Additional Daytime Sleepiness Indicators Value")

//ESS
define "Most Recent Epworth Sleepiness Scale Observation":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Epworth Sleepiness Scale Assertion".coding)])

define "ESS Score >= 10":
  if not "Most Recent Epworth Sleepiness Scale Observation" is null
    then "Most Recent Epworth Sleepiness Scale Observation"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Epworth Sleepiness Scale Assertion",
      PS."Has ESS Score GTE 10",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-ess-screening-casefeature',
      PCF.MostRecent(PS."Epworth Sleepiness Scale Score >= 10"),
      ''
    )

define "Has ESS Score >= 10 Value":
  "ESS Score >= 10".value.value as System.Boolean

define "Has ESS Score >= 10":
  IsTrue("Has ESS Score >= 10 Value")

define "Does Not Have ESS Score >= 10":
  IsFalse("Has ESS Score >= 10 Value")

define "Null ESS Score":
  IsNull("Has ESS Score >= 10 Value")

//Excessive Sleepiness While Driving
define "Most Recent Excessive Sleepiness While Driving":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Excessive Sleepiness While Driving Assertion".coding)])

define "Qualifying Excessive Sleepiness While Driving":
  if not "Most Recent Excessive Sleepiness While Driving" is null
    then "Most Recent Excessive Sleepiness While Driving"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Excessive Sleepiness While Driving Assertion",
      PS."Has Excessive Sleepiness While Driving",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-sleepydriving-screening-casefeature'
    )

define "Has Excessive Sleepiness While Driving Value":
  "Qualifying Excessive Sleepiness While Driving".value.value as System.Boolean

define "Has Excessive Sleepiness While Driving":
  IsTrue("Has Excessive Sleepiness While Driving Value")

define "Does Not Have Excessive Sleepiness While Driving":  
  IsFalse("Has Excessive Sleepiness While Driving Value")

define "Null Excessive Sleepiness While Driving":
  IsNull("Has Excessive Sleepiness While Driving Value")

//Loud Snoring
define "Most Recent Loud Snoring Observation":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Loud Snoring Assertion".coding)])

define "Loud/Intense Snoring":
  if not "Most Recent Loud Snoring Observation" is null
    then "Most Recent Loud Snoring Observation"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Loud Snoring Assertion",
      PS."Witnessed Loud Snoring",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-loudsnoring-screening-casefeature',
      PCF.MostRecent(PS."Loud Intense Snoring"),
      ''
    )

define "Snores loudly/intensely Value":
  "Loud/Intense Snoring".value.value as System.Boolean

define "Snores loudly/intensely":
  IsTrue("Snores loudly/intensely Value")

define "Does Not Snore Loudly/Intensely":
  IsFalse("Snores loudly/intensely Value")

define "Null Snoring Volume/Intensity":
  IsNull("Snores loudly/intensely Value")

//Nocturnal Apnea
define "Most Recent Nocturnal Apnea Observation":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Nocturnal Apnea Assertion".coding)])

define "Nocturnal Apnea":
  if not "Most Recent Nocturnal Apnea Observation" is null
    then "Most Recent Nocturnal Apnea Observation"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Nocturnal Apnea Assertion",
      PS."Witnessed Nocturnal Apnea",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-apnea-screening-casefeature',
      PCF.MostRecent(PS."Nocturnal Apnea"),
      ''
    )

define "Has Nocturnal Apnea Value":
  "Nocturnal Apnea".value.value as System.Boolean

define "Has Nocturnal Apnea":
  IsTrue("Has Nocturnal Apnea Value")

define "Does Not have nocturnal apnea":
  IsFalse("Has Nocturnal Apnea Value")

define "Null Apnea":
  IsNull("Has Nocturnal Apnea Value")


//RE-EXAMINE IF THIS IS OK/WORKS
// define "Most Recent Absence Of Comorbid Medical Conditions Observation":
//   PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Absence Of Comorbid Medical Conditions Assertion".coding)])

// define "Qualifying Absence Of Comorbid Medical Conditions":
//   if not "Most Recent Absence Of Comorbid Medical Conditions Observation" is null
//     then "Most Recent Absence Of Comorbid Medical Conditions Observation"
//   else 
//     PCF.CaseFeatureObservation(
//       AC."Qualifying Absence Of Comorbid Medical Conditions Assertion",
//       "Has Absence Of Applicable Comorbid Medical Conditions",
//       'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-comorbid-screening-casefeature',
//       PS."Evidence of Comorbid Medical Conditions", 
//       ''
//     )

// define "Has Absence Of Comorbid Medical Conditions":
//   "Has Absence Of Applicable Comorbid Medical Conditions" as System.Boolean

// define "Presence Of Comorbid Medical Conditions":
//   not "Has Absence Of Comorbid Medical Conditions"

// define "Null Presence of Comorbid Medical Conditions":
//   "Has Absence Of Comorbid Medical Conditions" is null

//Eligible Comorbid Medical Conditions Criteria
define "Has Applicable Comorbid Medical Conditions Value":
  ("Has Neuromuscular Disease With Associated Pulmonary Disease Value"
    or "Has Cardiac Disease Value"
    or "Has Moderate To Severe Pulmonary Disease Value")

define "Has Applicable Comorbid Medical Conditions":
  IsTrue("Has Applicable Comorbid Medical Conditions Value")

define "Has Absence Of Applicable Comorbid Medical Conditions":
  IsFalse("Has Applicable Comorbid Medical Conditions Value")

define "Null Applicable Comorbid Medical Conditions":
  IsNull("Has Applicable Comorbid Medical Conditions Value")

//Pulmonary Disease
define "Most Recent Moderate To Severe Pulmonary Disease":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Moderate To Severe Pulmonary Disease Assertion".coding)])

define "Qualifying Moderate To Severe Pulmonary Disease":
  if not "Most Recent Moderate To Severe Pulmonary Disease" is null
    then "Most Recent Moderate To Severe Pulmonary Disease"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Moderate To Severe Pulmonary Disease Assertion",
      PS."Has Moderate To Severe Pulmonary Disease", //Is this right? or should it be obs of only pulmonary disease??
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-moderatepulmonary-screening-casefeature',
      PCF.MostRecent(PS."Qualifying Moderate To Severe Pulmonary Disease"),
      ''
    )

define "Has Moderate To Severe Pulmonary Disease Value":
  "Qualifying Moderate To Severe Pulmonary Disease".value.value as System.Boolean

define "Has Moderate To Severe Pulmonary Disease":
  IsTrue("Has Moderate To Severe Pulmonary Disease Value")

define "No Moderate To Severe Pulmonary Disease":
  IsFalse("Has Moderate To Severe Pulmonary Disease Value")

define "Null Pulmonary Disease":
  IsNull("Has Moderate To Severe Pulmonary Disease Value")

// define "Has Moderate To Severe Pulmonary Disease Including COPD or Asthma":
//   "Has Moderate To Severe Pulmonary Disease Including COPD"
//     or "Has Moderate To Severe Pulmonary Disease Including Asthma"

//Do I still need the COPD and the asthma part??
// define "Most Recent Pulmonary Disease Including COPD":
//   PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Moderate To Severe Pulmonary Disease Assertion Including COPD Assertion".coding)])

// define "Qualifying Moderate To Severe Pulmonary Disease Including COPD":
//   if not "Most Recent Pulmonary Disease Including COPD" is null
//     then "Most Recent Pulmonary Disease Including COPD"
//   else 
//     PCF.CaseFeatureObservation(
//       AC."Qualifying Moderate To Severe Pulmonary Disease Assertion Including COPD Assertion",
//       PS."Has Diagnosed COPD",
//       'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-pulmonarywithcopd-screening-casefeature',
//       PCF.MostRecent(PS."Diagnosed COPD"),
//       ''
//     )

// define "Has Moderate To Severe Pulmonary Disease Including COPD":
//   "Qualifying Moderate To Severe Pulmonary Disease Including COPD".value.value as System.Boolean

// define "No Moderate To Severe Pulmonary Disease Including COPD":
//   not "Has Moderate To Severe Pulmonary Disease Including COPD"

// define "Null Pulmonary Disease Including COPD":
//   "Has Moderate To Severe Pulmonary Disease Including COPD" is null

// //Do I still need the COPD and the asthma part??
// define "Most Recent Pulmonary Disease Including Asthma":
//   PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Moderate To Severe Pulmonary Disease Assertion Including Asthma Assertion".coding)])

// define "Qualifying Moderate To Severe Pulmonary Disease Including Asthma":
//   if not "Most Recent Pulmonary Disease Including Asthma" is null
//     then "Most Recent Pulmonary Disease Including Asthma"
//   else
//     PCF.CaseFeatureObservation(
//       AC."Qualifying Moderate To Severe Pulmonary Disease Assertion Including Asthma Assertion",
//       PS."Has Diagnosed Asthma",
//       'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-pulmonarywithasthma-screening-casefeature',
//       PCF.MostRecent(PS."Diagnosed Asthma"),
//       ''
//     )

// define "Has Moderate To Severe Pulmonary Disease Including Asthma":
//   "Most Recent Pulmonary Disease Including Asthma".value.value as System.Boolean

// define "No Moderate To Severe Pulmonary Disease Including Asthma":
//   not "Has Moderate To Severe Pulmonary Disease Including Asthma"

// define "Null Pulmonary Disease Including Asthma":
//   "Has Moderate To Severe Pulmonary Disease Including Asthma" is null

//Neuromuscular Disease
define "Most Recent Neuromuscular Disease With Pulmonary Disease":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Neuromuscular Disease With Associated Pulmonary Disease Assertion".coding)])

define "Qualifying Neuromuscular Disease With Associated Pulmonary Disease":
  if not "Most Recent Neuromuscular Disease With Pulmonary Disease" is null
    then "Most Recent Neuromuscular Disease With Pulmonary Disease"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Neuromuscular Disease With Associated Pulmonary Disease Assertion",
      PS."Neuromuscular Disease With Associated Pulmonary Disease",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscular-screening-casefeature',
      PCF.MostRecent(PS."Neuromuscular Disease Diagnosis"),
      ''
    )

define "Has Neuromuscular Disease With Associated Pulmonary Disease Value":
  "Qualifying Neuromuscular Disease With Associated Pulmonary Disease".value.value as System.Boolean

define "Has Neuromuscular Disease With Associated Pulmonary Disease":
  IsTrue("Has Neuromuscular Disease With Associated Pulmonary Disease Value")

define "No Neuromuscular Disease With Associated Pulmonary Disease":
  IsFalse("Has Neuromuscular Disease With Associated Pulmonary Disease Value")

define "Null Nueromuscular Disease":
  IsNull("Has Neuromuscular Disease With Associated Pulmonary Disease Value")

//Cardiac Disease
define "Most Recent Cardiac Disease Observation":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Cardiac Disease Assertion".coding)])

define "Qualifying Cardiac Disease":
  if not "Most Recent Cardiac Disease Observation" is null
    then "Most Recent Cardiac Disease Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Cardiac Disease Assertion",
      PS."Has Cardiac Disease",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature',
      PCF.MostRecent(PS."Qualifying Cardiac Disease"),
      ''
    )

define "Has Cardiac Disease Value":
  "Qualifying Cardiac Disease".value.value as System.Boolean

define "Has Cardiac Disease":
  IsTrue("Has Cardiac Disease Value")

define "No Cardiac Disease":
  IsFalse("Has Cardiac Disease Value")

define "Null Cardiac Disease":
  IsNull("Has Cardiac Disease Value")


//Home Observation Criteria:
//Qualified Device
define "Most Recent Qualified Device Observation":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Uses A Qualified Device Assertion".coding)])

define "Uses A Qualified Device":
  if not "Most Recent Qualified Device Observation" is null
    then "Most Recent Qualified Device Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Uses A Qualified Device Assertion",
      PS."Qualified Device Observation",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-qualifieddevice-screening-casefeature',
      PCF.MostRecent(PS."Qualified Device Request"),
      ''
    )

define "Patient Uses Qualified Device Value":
  "Uses A Qualified Device".value.value as System.Boolean

define "Patient Uses Qualified Device":
  IsTrue("Patient Uses Qualified Device Value")

define "Does Not Use Qualified Device":
  IsFalse("Patient Uses Qualified Device Value")

define "Unknown Device Used":
  IsNull("Patient Uses Qualified Device Value")

//Safe home use
define "Most Recent Safe Use Of Equipment At Home Observation":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Safe Equipment Use At Home Assertion".coding)])

define "Safe Equipment Use At Home":
  if not "Most Recent Safe Use Of Equipment At Home Observation" is null
    then "Most Recent Safe Use Of Equipment At Home Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Safe Equipment Use At Home Assertion",
      PS."Safe Use Of Equipment At Home Observation",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-safehomeuse-screening-casefeature'
    )

define "Can Safely Use Equipment At Home Value":
  "Safe Equipment Use At Home".value.value as System.Boolean

define "Can Safely Use Equipment At Home":
  IsTrue("Can Safely Use Equipment At Home Value")

define "Can Not Safely Use Equipment At Home":
  IsFalse("Can Safely Use Equipment At Home Value")

define "Unknown Ability To Use Equipment At Home":
  IsNull("Can Safely Use Equipment At Home Value")

//Physician Evaluated Results
define "Most Recent Physician Evaluated Observation":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Physician Evaluated Results Assertion".coding)])

define "Physician Evaluated Results":
  if not "Most Recent Physician Evaluated Observation" is null
    then "Most Recent Physician Evaluated Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Physician Evaluated Results Assertion",
      PS."Physician Evaluated Results Observation",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-physicianevaluated-screening-casefeature'
    )

define "Ability To Have Physician Evaluate Results Value":
  "Physician Evaluated Results".value.value as System.Boolean

define "Ability To Have Physician Evaluate Results":
  IsTrue("Ability To Have Physician Evaluate Results Value")

define "Unable To Have Physician Evaluate Results":
  IsFalse("Ability To Have Physician Evaluate Results Value")

define "Unknown Ability To Have Physician Evaluate Results":
  IsNull("Ability To Have Physician Evaluate Results Value")



//Facility-Based Polysomnogram (PSG)
  //Criteria to meet any one of following medical conditions:
define "Has Applicable Medical Condition For Facility-Based PSG Value":
  "Has Diagnostic Testing Prior to Planned HGNS Implantation Value"
    or "Has Central Sleep Apnea (CSA)"
    or "Has Narcolepsy When MSLT is Planned"
    or "Has Obesity Hypoventilation Syndrome (OHS)"
    or "Has History of Traumatic Brain Injury (TBI) with Excessive Daytime Sleepiness (EDS)"
    or "Has Idiopathic Central Nervous System Hyperinsomnia When MSLT is Planned"
    or "Has a Mission Critical Profession"
    or "Has Moderate To Severe Pulmonary Disease Value"
    or "Has Neuromuscular Disease With Associated Pulmonary Disease Value"
    or "Has Unusual or Atypical Parasomnias"
    or "Has Paroxysmal Arousals or Other Sleep Disruptions Thought to be Seizure Related"
    or "Has Periodic Limb Movement Disorder"
    or "Has Cardiac Disease Value"

define "Has Applicable Medical Condition For Facility-Based PSG":
  IsTrue("Has Applicable Medical Condition For Facility-Based PSG Value")

define "Has No Applicable Medical Condition For Facility-Based PSG":
  IsFalse("Has Applicable Medical Condition For Facility-Based PSG Value")

define "Null Applicable Medical Condition For Facility-Based PSG":
  IsNull("Has Applicable Medical Condition For Facility-Based PSG Value")


//Diagnostic testing with diagnosis of OSA
define "Most Recent Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
  PCF.MostRecent([Observation: FHIRHelpers.ToCode(singleton from AC."Qualifying Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA Assertion".coding)])

define "Qualifying Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
  if not "Most Recent Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA" is null
    then "Most Recent Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA Assertion",
      FacilityPSG."Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-diagnostictesting-screening-casefeature'
    )

define "Has Diagnostic Testing Prior to Planned HGNS Implantation Value":
  "Qualifying Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA".value.value as System.Boolean

define "Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
  IsTrue("Has Diagnostic Testing Prior to Planned HGNS Implantation Value")

define "No Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
  IsFalse("Has Diagnostic Testing Prior to Planned HGNS Implantation Value")

define "Null Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
  IsNull("Has Diagnostic Testing Prior to Planned HGNS Implantation Value")

//Central Sleep Apnea (CSA)
define "Most Recent Central Sleep Apnea Diagnosis":
  PCF.MostRecent([Condition: FHIRHelpers.ToCode(singleton from AC."Central Sleep Apnea (CSA) Assertion".coding)])

define "Qualifying Central Sleep Apnea":
  if not "Most Recent Central Sleep Apnea Diagnosis" is null
    then "Most Recent Central Sleep Apnea Diagnosis"
  else
    PCF.CaseFeatureObservation(
      AC."Central Sleep Apnea (CSA) Assertion",
      FacilityPSG."Has Central Sleep Apnea (CSA)",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-csa-screening-casefeature',
      PCF.MostRecent(FacilityPSG."Qualifying Central Sleep Apnea"),
      ''
    )

define "Has Central Sleep Apnea (CSA) Value":
  "Qualifying Central Sleep Apnea".value.value as System.Boolean

define "Has Central Sleep Apnea (CSA)":
  IsTrue("Has Central Sleep Apnea (CSA) Value")

define "No Central Sleep Apnea (CSA)":
  IsFalse("Has Central Sleep Apnea (CSA) Value")

define "Null Central Sleep Apnea (CSA)":
  IsNull("Has Central Sleep Apnea (CSA) Value")



//Approval Logic
define "LineBreak": 
  '\r\n'

//Not Approved Response
define "Not Approved Detail": 
  ' Prior Authorization DENIED.'
    + "LineBreak" + 'Reasoning:'
    + Coalesce(
      if "Not Within Qualifying Age" then "LineBreak" + '- Individual is not within the qualifying age.' else null,
      "Not Approved EDS",
      "Not Approved Absence of Comorbid Conditions",
      "Not Approved Home Criteria"
    )

define "Not Approved EDS":
  if "No Excessive Daytime Sleepiness" 
    then "LineBreak" + '- Individual does not have excessive daytime sleepiness.'
  else
    if "Has Excessive Daytime Sleepiness" and "Has No Additional Daytime Sleepiness Indicators" 
      then "LineBreak" + '- Individual has none of the following additional daytime sleepiness indicators: ESS score of 10 or greater, excessive sleepiness while driving, snore loudly/intensely, witnessed nocturnal apnea, choking and/or gasping'
  else
   null

define "Not Approved Absence of Comorbid Conditions": 
  if "Has Applicable Comorbid Medical Conditions"//"Has Moderate To Severe Pulmonary Disease" or "Has Neuromuscular Disease With Associated Pulmonary Disease" or "Has Cardiac Disease"
    then "LineBreak" + '- Individual has one or more of the following eligible comorbid conditions: Moderate to severe pulmonary disease including COPD or Asthma, Neuromuscular disease with associated pulmonary disease, Cardiac Disease'
  else 
    null

define "Not Approved Home Criteria":
  Coalesce(
    if "Does Not Use Qualified Device" then "LineBreak" + '- Individual does not use Type II, Type III, Type IV or PAT PM device' else null,
    if "Can Not Safely Use Equipment At Home" then "LineBreak" + '- Individual or caregiver does not have appropriate cognitive function, dexterity and mobility to use equipment safely at home' else null,
    if "Unable To Have Physician Evaluate Results" then "LineBreak" + ' - Individual is unable to have physician evaluate results of home sleep tests' else null
  )


//Not Approved Null Response
define "Temporarily Not Approved":
  'Prior Authorization PENDING.'
    + "LineBreak" + 'Reasoning:'
    + Coalesce(
      if "Age Unknown" then 'Please enter the following: Patient Age' else null, 
      "Null EDS",
      "Null Comorbid Medical Conditions",
      "Null Home Criteria"
    )

define "Null EDS":
  if "Null Excessive Daytime Sleepiness" 
    then "LineBreak" + ' - Please enter the following: Excessive Daytime Sleepiness' 
  else 
    if "Null Additional Daytime Sleepiness Indicators"
      then "LineBreak" + 'Please enter the following: Additional Sleepiness Indicators' 
      + (if "Null ESS Score" then "LineBreak" + ' - Please enter the following: Epworth Sleepiness Scale' 
      else if "Null Excessive Sleepiness While Driving" then "LineBreak" + ' - Please enter the following: Excessive Sleepiness While driving'
      else if "Null Snoring Volume/Intensity" then "LineBreak" + ' - Please enter the following: Loud/Intense Snoring'
      else if "Null Apnea" then "LineBreak" + ' - Please enter the following: Nocturnal apnea' else null)
  else 
    null

define "Null Comorbid Medical Conditions":
  if "Null Applicable Comorbid Medical Conditions"
      then Coalesce(
        if "Null Pulmonary Disease" then "LineBreak" + ' - Please enter the following: Pulmonary Disease' else null,
        if "Null Nueromuscular Disease" then "LineBreak" + ' - Please enter the following: Neuromuscular Disease With Associated Pulmonary Disease' else null,
        if "Null Cardiac Disease" then "LineBreak" + ' - Please enter the following: Cardiac Disease' else null
      )
  else
    null

define "Null Home Criteria":
  Coalesce(
    if "Unknown Device Used" then "LineBreak" + ' - Please enter the following: Use Of Type II, Type III, Type IV or PAT PM Device' else null,
    if "Unknown Ability To Use Equipment At Home" then "LineBreak" + ' - Please enter the following: Individual Or Caregiver Use Of Equipment Safely At Home' else null,
    if "Unknown Ability To Have Physician Evaluate Results" then "LineBreak" + ' - Please enter the following: Ability To Have Physician Evaluate Home Testing Results' else null
  )



//Approved Response
define "Approved Detail":
  'Prior Authorization APPROVED.'
    + "LineBreak" + 'Reasoning:'
    + "Approved Age"
    + "Approved EDS"
    + "Approved Comorbid Conditions Absence"
    + "Approved Qualified Device"
    + "Approved Home Use"
    + "Approved Physician Evaluated Results"

define "Approved Age":
  if "Is Qualifying Age"
    then "LineBreak" + '- Is qualifying age'
  else 
    null

define "Approved EDS":
  if "Has Excessive Daytime Sleepiness" and "Has Additional Daytime Sleepiness Indicators"
    then "LineBreak" + '- Individual has Excessive Daytime Sleepiness and one of the following additional indicators: ESS score of 10 or greater, excessive sleepiness while driving, snore loudly/intensely, witnessed nocturnal apnea, choking and/or gasping'
  else
    null

define "Approved Comorbid Conditions Absence":
  if "Has Absence Of Applicable Comorbid Medical Conditions"
    then "LineBreak" + '- Individual has an absence of the following eligible comorbid conditions: Moderate to severe pulmonary disease including COPD or Asthma, Neuromuscular disease with associated pulmonary disease, Cardiac Disease'
  else 
    null

define "Approved Qualified Device":
  if "Patient Uses Qualified Device"
    then "LineBreak" + '- Individual uses a qualified device'
  else 
    null

define "Approved Home Use":
  if "Can Safely Use Equipment At Home"
    then "LineBreak" + '- Individual or caregiver can use equipment safely at home'
  else 
    null

define "Approved Physician Evaluated Results":
  if "Ability To Have Physician Evaluate Results"
    then "LineBreak" + '- Individual can have physician evaluate home testing results'
  else 
    null
