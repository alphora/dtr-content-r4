library ASLPPolicyPAA

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'
include ASLPPolicyCaseFeatures called PCF
include ASLPPolicyConcepts called AC
include ASLPPolicyScreening called PS

context Patient

define "Most Recent Qualifying Patient Age":
  PCF.MostRecent([Observation: AC."Qualifying Patient Age Assertion"])

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

define "Is Qualifying Age":
  "Qualifying Patient Age".value.value as System.Boolean

define "Not Within Qualifying Age":
  not "Is Qualifying Age"

define "Age Unknown":
  "Qualifying Patient Age" is null

define "Most Recent Excessive Daytime Sleepiness Observation":
  PCF.MostRecent([Observation: AC."Qualifying Excessive Daytime Sleepiness Assertion"])

define "Qualified Excessive Daytime Sleepiness":
  if not "Most Recent Excessive Daytime Sleepiness Observation" is null 
    then "Most Recent Excessive Daytime Sleepiness Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Excessive Daytime Sleepiness Assertion",
      PS."Excessive Daytime Sleepiness Observation",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-eds-screening-casefeature',
      PCF.MostRecent(PS."Excessive Daytime Sleepiness"),
      ''
    )

define "Has Excessive Daytime Sleepiness":
  "Qualified Excessive Daytime Sleepiness".value.value as System.Boolean

define "No Excessive Daytime Sleepiness":
  not "Has Excessive Daytime Sleepiness"

define "Null Excessive Daytime Sleepiness":
  "Has Excessive Daytime Sleepiness" is null

//Additional EDS Criteria 
define "Has Additional Daytime Sleepiness Indicators":
  "Has ESS Score >= 10"
    or "Has Excessive Sleepiness While Driving"
    or "Snores loudly/intensely"
    or "Has Nocturnal Apnea"

define "Has No Additional Daytime Sleepiness Indicators":
  not "Has Additional Daytime Sleepiness Indicators"

define "Null Additional Daytime Sleepiness Indicators":
  "Has Additional Daytime Sleepiness Indicators" is null


define "Most Recent Epworth Sleepiness Scale Observation":
  PCF.MostRecent([Observation: AC."Qualifying Epworth Sleepiness Scale Assertion"])

define "ESS Score >= 10":
  if not "Most Recent Epworth Sleepiness Scale Observation" is null
    then "Most Recent Epworth Sleepiness Scale Observation"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Epworth Sleepiness Scale Assertion",
      PS."ESS Score >= 10",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-ess-screening-casefeature',
      PCF.MostRecent(PS."Epworth Sleepiness Scale Score >= 10"),
      ''
    )

define "Has ESS Score >= 10":
  "ESS Score >= 10".value.value as System.Boolean

define "Does Not Have ESS Score >= 10":
  not "Has ESS Score >= 10"

define "Null ESS Score":
  "Has ESS Score >= 10" is null


define "Most Recent Excessive Sleepiness While Driving":
  PCF.MostRecent([Observation: AC."Qualifying Excessive Sleepiness While Driving Assertion"])

define "Qualifying Excessive Sleepiness While Driving":
  if not "Most Recent Excessive Sleepiness While Driving" is null
    then "Most Recent Excessive Sleepiness While Driving"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Excessive Sleepiness While Driving Assertion",
      PS."Excessive Sleepiness While Driving Observation",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-sleepydriving-screening-casefeature',
      PCF.MostRecent(PS."Excessive Sleepiness While Driving"),
      ''
    )

define "Has Excessive Sleepiness While Driving":
  "Qualifying Excessive Sleepiness While Driving".value.value as System.Boolean

define "Does Not Have Excessive Sleepiness While Driving":  
  not "Has Excessive Sleepiness While Driving"

define "Null Excessive Sleepiness While Driving":
  "Has Excessive Sleepiness While Driving" is null


define "Most Recent Loud Snoring Observation":
  PCF.MostRecent([Observation: AC."Qualifying Loud Snoring Assertion"])

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

define "Snores loudly/intensely":
  "Loud/Intense Snoring".value.value as System.Boolean

define "Does Not Snore Loudly/Intensely":
  not "Snores loudly/intensely"

define "Null Snoring Volume/Intensity":
  "Snores loudly/intensely" is null


define "Most Recent Nocturnal Apnea Observation":
  PCF.MostRecent([Observation: AC."Qualifying Nocturnal Apnea Assertion"])

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

define "Has Nocturnal Apnea":
  "Nocturnal Apnea".value.value as System.Boolean

define "Does Not have nocturnal apnea":
  not "Has Nocturnal Apnea"

define "Null Apnea":
  "Has Nocturnal Apnea" is null


//RE-EXAMINE IF THIS IS OK/WORKS
define "Most Recent Absence Of Comorbid Medical Conditions Observation":
  PCF.MostRecent([Observation: AC."Qualifying Absence Of Comorbid Medical Conditions Assertion"])

define "Qualifying Absence Of Comorbid Medical Conditions":
  if not "Most Recent Absence Of Comorbid Medical Conditions Observation" is null
    then "Most Recent Absence Of Comorbid Medical Conditions Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Absence Of Comorbid Medical Conditions Assertion",
      PS."Absence of Comorbid Medical Conditions",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-comorbid-screening-casefeature',
      PCF.MostRecent(PS."Has Comorbid Medical Conditions"),
      ''
    )

define "Has Absence Of Comorbid Medical Conditions":
  "Qualifying Absence Of Comorbid Medical Conditions".value.value as System.Boolean

define "No Absence Of Comorbid Medical Conditions":
  not "Has Absence Of Comorbid Medical Conditions"

define "Null Presence of Comorbid Medical Conditions":
  "Has Absence Of Comorbid Medical Conditions" is null

//Eligible Comorbid Medical Conditions Criteria
define "Has Applicable Comorbid Medical Conditions":
  "Has Neuromuscular Disease With Associated Pulmonary Disease"
    or "Has Cardiac Disease"
    or ("Has Moderate To Severe Pulmonary Disease"
      and "Has Moderate To Severe Pulmonary Disease Including COPD or Asthma")

define "Has No Applicable Comorbid Medical Conditions":
  not "Has Applicable Comorbid Medical Conditions"

define "Null Applicable Comorbid Medical Conditions":
  "Has Applicable Comorbid Medical Conditions" is null


define "Most Recent Moderate To Severe Pulmonary Disease":
  PCF.MostRecent([Observation: AC."Qualifying Moderate To Severe Pulmonary Disease Assertion"])

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

define "Has Moderate To Severe Pulmonary Disease":
  "Qualifying Moderate To Severe Pulmonary Disease".value.value as System.Boolean

define "No Moderate To Severe Pulmonary Disease":
  not "Has Moderate To Severe Pulmonary Disease"

define "Null Pulmonary Disease":
  "Has Moderate To Severe Pulmonary Disease" is null

define "Has Moderate To Severe Pulmonary Disease Including COPD or Asthma":
  "Has Moderate To Severe Pulmonary Disease Including COPD"
    or "Has Moderate To Severe Pulmonary Disease Including Asthma"


define "Most Recent Pulmonary Disease Including COPD":
  PCF.MostRecent([Observation: AC."Qualifying Moderate To Severe Pulmonary Disease Assertion Including COPD Assertion"])

define "Qualifying Moderate To Severe Pulmonary Disease Including COPD":
  if not "Most Recent Pulmonary Disease Including COPD" is null
    then "Most Recent Pulmonary Disease Including COPD"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Moderate To Severe Pulmonary Disease Assertion Including COPD Assertion",
      PS."Pulmonary Disease Including COPD",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-pulmonarywithcopd-screening-casefeature',
      PCF.MostRecent(PS."Moderate To Severe Pulmonary Disease Including COPD"),
      ''
    )

define "Has Moderate To Severe Pulmonary Disease Including COPD":
  "Qualifying Moderate To Severe Pulmonary Disease Including COPD".value.value as System.Boolean

define "No Moderate To Severe Pulmonary Disease Including COPD":
  not "Has Moderate To Severe Pulmonary Disease Including COPD"

define "Null Pulmonary Disease Including COPD":
  "Has Moderate To Severe Pulmonary Disease Including COPD" is null


define "Most Recent Pulmonary Disease Including Asthma":
  PCF.MostRecent([Observation: AC."Qualifying Moderate To Severe Pulmonary Disease Assertion Including Asthma Assertion"])

define "Qualifying Moderate To Severe Pulmonary Disease Including Asthma":
  if not "Most Recent Pulmonary Disease Including Asthma" is null
    then "Most Recent Pulmonary Disease Including Asthma"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Moderate To Severe Pulmonary Disease Assertion Including Asthma Assertion",
      PS."Pulmonary Disease Including Asthma",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-pulmonarywithasthma-screening-casefeature',
      PCF.MostRecent(PS."Moderate To Severe Pulmonary Disease Including Asthma"),
      ''
    )

define "Has Moderate To Severe Pulmonary Disease Including Asthma":
  "Most Recent Pulmonary Disease Including Asthma".value.value as System.Boolean

define "No Moderate To Severe Pulmonary Disease Including Asthma":
  not "Has Moderate To Severe Pulmonary Disease Including Asthma"

define "Null Pulmonary Disease Including Asthma":
  "Has Moderate To Severe Pulmonary Disease Including Asthma" is null


define "Most Recent Neuromuscular Disease With Pulmonary Disease":
  PCF.MostRecent([Observation: AC."Qualifying Neuromuscular Disease With Associated Pulmonary Disease Assertion"])

define "Qualifying Neuromuscular Disease With Associated Pulmonary Disease":
  if not "Most Recent Neuromuscular Disease With Pulmonary Disease" is null
    then "Most Recent Neuromuscular Disease With Pulmonary Disease"
  else
    PCF.CaseFeatureObservation(
      AC."Qualifying Neuromuscular Disease With Associated Pulmonary Disease Assertion",
      PS."Qualified Neuromuscular Disease With Associated Pulmonary Disease",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscular-screening-casefeature',
      PCF.MostRecent(PS."Neuromuscular Disease With Associated Pulmonary Disease"),
      ''
    )

define "Has Neuromuscular Disease With Associated Pulmonary Disease":
  "Most Recent Neuromuscular Disease With Pulmonary Disease".value.value as System.Boolean

define "No Neuromuscular Disease With Associated Pulmonary Disease":
  not "Has Neuromuscular Disease With Associated Pulmonary Disease"

define "Null Nueromuscular Disease":
  "Has Neuromuscular Disease With Associated Pulmonary Disease" is null


define "Most Recent Cardiac Disease Observation":
  PCF.MostRecent([Observation: AC."Qualifying Cardiac Disease Assertion"])

define "Qualifying Cardiac Disease":
  if not "Most Recent Cardiac Disease Observation" is null
    then "Most Recent Cardiac Disease Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Qualifying Cardiac Disease Assertion",
      PS."Cardiac Disease Observation",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature',
      PCF.MostRecent(PS."Qualifying Cardiac Disease"),
      ''
    )

define "Has Cardiac Disease":
  "Qualifying Cardiac Disease".value.value as System.Boolean

define "No Cardiac Disease":
  not "Has Cardiac Disease"

define "Null Cardiac Disease":
  "Has Cardiac Disease" is null


//Home Observation Criteria:
define "Most Recent Qualified Device Observation":
  PCF.MostRecent([Observation: AC."Uses A Qualified Device Assertion"])

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

define "Patient Uses Qualified Device":
  "Uses A Qualified Device".value.value as System.Boolean

define "Does Not Use Qualified Device":
  not "Patient Uses Qualified Device"

define "Unknown Device Used":
  "Patient Uses Qualified Device" is null



define "Most Recent Safe Use Of Equipment At Home Observation":
  PCF.MostRecent([Observation: AC."Safe Equipment Use At Home Assertion"])

define "Safe Equipment Use At Home":
  if not "Most Recent Safe Use Of Equipment At Home Observation" is null
    then "Most Recent Safe Use Of Equipment At Home Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Safe Equipment Use At Home Assertion",
      PS."Safe Use Of Equipment At Home Observation",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-safehomeuse-screening-casefeature',
      PCF.MostRecent(PS."Can Safely Use Equipment At Home"),
      ''
    )

define "Can Safely Use Equipment At Home":
  "Safe Equipment Use At Home".value.value as System.Boolean

define "Can Not Safely Use Equipment At Home":
  not "Can Safely Use Equipment At Home"

define "Unknown Ability To Use Equipment At Home":
  "Can Safely Use Equipment At Home" is null


define "Most Recent Physician Evaluated Observation":
  PCF.MostRecent([Observation: AC."Physician Evaluated Results Assertion"])

define "Physician Evaluated Results":
  if not "Most Recent Physician Evaluated Observation" is null
    then "Most Recent Physician Evaluated Observation"
  else 
    PCF.CaseFeatureObservation(
      AC."Physician Evaluated Results Assertion",
      PS."Physician Evaluated Results Observation",
      'http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-physicianevaluated-screening-casefeature',
      PCF.MostRecent(PS."Physician Evaluated Results"),
      ''
    )

define "Ability To Have Physician Evaluate Results":
  "Physician Evaluated Results".value.value as System.Boolean

define "Unable To Have Physician Evaluate Results":
  not "Ability To Have Physician Evaluate Results"

define "Unknown Ability To Have Physician Evaluate Results":
  "Ability To Have Physician Evaluate Results" is null


//Not Approved Response
define "Not Approved Detail":
  'Prior Authorization DENIED.'
    + '<br />Reasoning:'
    + Coalesce(
      if "Not Within Qualifying Age" then '<br />- Individual is not within the qualifying age.' else '',
      "Not Approved EDS",
      "Not Approved Absence of Comorbid Conditions",
      "Not Approved Home Criteria"
    ) //Coalesce only accepts 5 elements so they had to be spilt up:

define "Not Approved EDS":
  if "Has Excessive Daytime Sleepiness" and "Has No Additional Daytime Sleepiness Indicators" 
    then  'Patient doesn\'t have any of the following additional daytime sleepiness indicators: ESS score of 10 or greater excessive sleepiness while driving snore loudly/intensely no witnessed nocturnal apnea, choking and/or gasping'   
  else
    if "No Excessive Daytime Sleepiness" then '<br />- Individual does not have excessive daytime sleepiness.'
  else
    ''

define "Not Approved Absence of Comorbid Conditions":
  if "No Absence Of Comorbid Medical Conditions" and "Has No Applicable Comorbid Medical Conditions"
    then '<br />- Individual has none of the following eligible comorbid conditions: Moderate to severe pulmonary disease including COPD or Asthma, Neuromuscular disease with associated pulmonary disease, Cardiac Disease'
  else 
    if "No Absence Of Comorbid Medical Conditions" then '<br />- Individual does not have an absence of comorbid medical conditions'
  else
    ''

define "Not Approved Pulmonary Disease With Associated Conditions":
  if "No Moderate To Severe Pulmonary Disease" and "Has Moderate To Severe Pulmonary Disease Including COPD or Asthma"
    then '<br />- Individual does not have moderate to severe pulmonary disease including COPD or Asthma'
  else
    if "No Moderate To Severe Pulmonary Disease" then '<br />- Individual does not have moderate to severe pulmonary disease'
  else 
  ''

define "Not Approved Home Criteria":
  Coalesce(
    if "Does Not Use Qualified Device" then '<br />- Individual does not use Type II, Type III, Type IV or PAT PM device' else '',
    if "Can Not Safely Use Equipment At Home" then '<br />- Individual or caregiver does not have appropriate cognitive function, dexterity and mobility to use equipment safely at home' else '',
    if "Unable To Have Physician Evaluate Results" then '<br />- Individual is unable to have physician evaluate results of home sleep tests' else ''
  )

//Not Approved Null Response
define "Temporarily not approved":
  'Prior Authorization DENIED.'
    + '<br />Reasoning:'
    + Coalesce(
      if "Age Unknown" then '<br />- Please enter the following: Patient Age' else '', 
      "Null EDS",
      "Null Comorbid Medical Conditions",
      "Null Home Criteria"
    )

define "Null EDS":
  if "Null Excessive Daytime Sleepiness" 
    then '<br />- Please enter the following: Excessive Daytime Sleepiness'
  else 
    if "Null Excessive Daytime Sleepiness" and "Null Additional Daytime Sleepiness Indicators"
      then Coalesce(
        if "Null ESS Score" then '<br />- Please enter the following: Epworth Sleepiness Scale' else '',
        if "Null Excessive Sleepiness While Driving" then '<br />- Please enter the following: Excessive Sleepiness While driving' else '',
        if "Null Snoring Volume/Intensity" then '<br />- Please enter the following: Loud/Intense Snoring' else '',
        if "Null Apnea" then '<br />- Please enter the following: Nocturnal apnea' else ''
      )
  else
    ''

define "Null Comorbid Medical Conditions":
  if "Null Presence of Comorbid Medical Conditions" 
    then '<br />- Please enter the following: Absence Of Comorbid Medical Conditions'
  else 
    if "Null Presence of Comorbid Medical Conditions" and "Null Applicable Comorbid Medical Conditions"
      then Coalesce(
        "Null Pulmonary Disease With Associated Conditions",
        if "Null Nueromuscular Disease" then '<br />- Please enter the following: Neuromuscular Disease With Associated Pulmonary Disease' else '',
        if "Null Cardiac Disease" then '<br />- Please enter the following: Cardiac Disease' else ''
      )
  else
    ''

define "Null Pulmonary Disease With Associated Conditions":
  if "Null Pulmonary Disease" 
    then '<br />- Please enter the following: Moderate To Severe Pulmonary Disease'
  else
    if "Null Pulmonary Disease" and "Has Moderate To Severe Pulmonary Disease Including COPD or Asthma"
      then Coalesce(
        if "Null Pulmonary Disease Including COPD" then '<br />- Please enter the following: Moderate To Severe Pulmonary Disease Including Chronic Obstructive Pulmonary Disease' else '',
        if "Null Pulmonary Disease Including Asthma" then '<br />- Please enter the following: Moderate To Severe Pulmonary Disease Including Nocturnal Or Uncontrolled Asthma' else ''
      )
  else
    ''

define "Null Home Criteria":
  Coalesce(
    if "Unknown Device Used" then '<br />- Please enter the following: Use Of Type II, Type III, Type IV or PAT PM Device' else '',
    if "Unknown Ability To Use Equipment At Home" then '<br />- Please enter the following: Individual Or Caregiver Use Of Equipment Safely At Home' else '',
    if "Unknown Ability To Have Physician Evaluate Results" then '<br />- Please enter the following: Ability To Have Physician Evaluate Home Testing Results' else ''
  )

//Approved Response
define "Approved Detail":
  'Prior Authorization APPROVED.'
  + '<br />Reasoning:'
  + '<br /> Is qualifying age'
  + '<br /> Has Excessive Daytime Sleepiness'
  + '<br /> Has an Epworth Sleepiness Scale score greater than or equal to 10'
  + '<br /> Has excessive sleepiness while driving'
  + '<br /> Snores loudly/intensly'
  + '<br /> Has witnessed nocturnal apnea, choking and/or gasping'
  + '<br /> Has an absence of comorbid medical conditions'
  + '<br /> Has moderate to severe pulmonary disease'
  + '<br /> Has moderate to severe pulmonary disease including COPD'
  + '<br /> Has moderate to severe pulmonary disease including asthma'
  + '<br /> Has neuromuscular disease with associated pulmonary disease'
  + '<br /> Has cardiac disease'
  + '<br /> Does use a qualified device'
  + '<br /> Individual or caregiver can use equipment safely at home'
  + '<br /> Can have physician evaluate home testing results'

