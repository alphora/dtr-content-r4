library ASLPPolicyFBPSG

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'
include ASLPPolicyCaseFeatures called PCF
include ASLPPolicyConcepts called AC
include ASLPPolicyScreening called PS
include ASLPPolicyPAA called PAA

context Patient

define "Is Qualifying Age Value":
  PAA."Qualifying Patient Age".value.value as System.Boolean

define "Is Qualifying Age":
  IsTrue("Is Qualifying Age Value")

define "Not Within Qualifying Age":
  IsFalse("Is Qualifying Age Value")

define "Age Unknown":
  IsNull("Is Qualifying Age Value")

define "Has Excessive Daytime Sleepiness Value":
  PAA."Qualified Excessive Daytime Sleepiness".value.value as System.Boolean

define "Has Excessive Daytime Sleepiness":
  IsTrue("Has Excessive Daytime Sleepiness Value")

define "No Excessive Daytime Sleepiness":
  IsFalse("Has Excessive Daytime Sleepiness Value")

define "Null Excessive Daytime Sleepiness":
  IsNull("Has Excessive Daytime Sleepiness Value")

//Additional EDS Criteria 


define "Has Additional Daytime Sleepiness Indicators Value":
  PAA."Has ESS Score >= 10 Value"
    or PAA."Has Excessive Sleepiness While Driving Value"
    or PAA."Snores loudly/intensely Value"
    or PAA."Has Nocturnal Apnea Value"

define "Has Additional Daytime Sleepiness Indicators":
  IsTrue("Has Additional Daytime Sleepiness Indicators Value")

define "Has No Additional Daytime Sleepiness Indicators":
  IsFalse("Has Additional Daytime Sleepiness Indicators Value")

define "Null Additional Daytime Sleepiness Indicators":
  IsNull("Has Additional Daytime Sleepiness Indicators Value")

//Diagnostic testing


define "Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
  exists ( PS."Has BMI less than 35 kg/m2" ) //https://resources.massgeneralbrighamhealthplan.org/medicalpolicy/SleepStudies.pdf
    
    and exists ( PS."DISE performed prior to HGNS implantation" )
    and exists ( PS."Qualifying Diagnosis of Obstructive Sleep Apnea (OSA)" )
    and exists ( PS."Planned Hypoglossal Nerve Stimulator (HGNS) Implantation" )

define "Null Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA":
  IsNull("Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA")

//Central Sleep Apnea (CSA)


define "Has Central Sleep Apnea":
  exists ( PS."Qualifying Central Sleep Apnea" )

define "Null Central Sleep Apnea (CSA)":
  IsNull("Has Central Sleep Apnea")

//Features associated with narcolepsy when MSLT is planned


define "Has Qualifying Feature Associated With Narcolepsy When MSLT is Planned":
  exists ( PS."Qualifying Narcolepsy" )
    and exists ( PS."Planned Multiple sleep latency test (MSLT)" )

define "Unknown Features Associated With Narcolepsy When MSLT is Planned":
  IsNull("Has Qualifying Feature Associated With Narcolepsy When MSLT is Planned")

//Obesity Hypoventilation Syndrome (OHS)


define "Has Obesity Hypoventilation Syndrome":
  exists ( PS."Qualifying Obesity Hypoventilation Syndrome" )

define "Unknown Obesity Hypoventilation Syndrome (OHS)":
  IsNull("Has Obesity Hypoventilation Syndrome")

//History of Traumatic Brain Injury (TBI) with EDS


define "Has History of Traumatic Brain Injury with Excessive Daytime Sleepiness":
  exists ( ( [Condition: Cx."History of TBI"] ).active ( ).confirmed ( ) )
    and exists ( ( ( [Condition: Cx."EDS"] ).active ( ).confirmed ( ) )
        union ( ( [Observation: Cx."EDS"] ).resulted ( ) )
    )

define "Unknown History of Traumatic Brain Injury (TBI) with Excessive Daytime Sleepiness (EDS)":
  IsNull("Has History of Traumatic Brain Injury with Excessive Daytime Sleepiness")

//Idiopathic Central Nervous System Hypersomnia when MSLT is planned


define "Has Idiopathic Central Nervous System Hypersomnia When MSLT is Planned":
  exists ( PS."Qualifying Idiopathic Central Nervous System Hypersomnia" )
    and exists ( PS."Planned Multiple sleep latency test (MSLT)" )

define "Null Idiopathic Central Nervous System Hypersomnia When MSLT is Planned":
  IsNull("Has Idiopathic Central Nervous System Hypersomnia When MSLT is Planned")

//Lack of cognitive function, dexterity, or mobility to use portable monitor (PM) equipment safely at home


define "Lacks Cognitive Function, Dexterity, or Mobility for Safe Use of Equipment":
  exists ( PS."Qualifying Impairment for Safe Use of Equipment" )

define "Unknown Lack of Cognitive Function, Dexterity, or Mobility to Use Portable Monitor (PM) Safely At Home":
  IsNull("Lacks Cognitive Function, Dexterity, or Mobility for Safe Use of Equipment")

//Mission critical profession


define "Has Mission Critical Profession":
  exists ( PS."Qualifying Mission Critical Profession" )

define "Unknown Profession or Unknown Whether Profession is Mission Critical":
  IsNull("Has Mission Critical Profession")

//Neuromuscular


define "Has Neuromuscular Disease With Associated Pulmonary Disease":
  PS."Neuromuscular Disease With Associated Pulmonary Disease"

//cardiac disease


define "Has Cardiac Disease":
  PS."Has Cardiac Disease"

//Pulmonary Disease


define "Has Moderate To Severe Pulmonary Disease":
  PS."Has Moderate To Severe Pulmonary Disease"

//Parasomnias


define "Has Parasomnia":
  exists ( PS."Qualifying Parasomnias" )

define "Unknown Parasomnia":
  IsNull("Has Parasomnia")

//Paroxysmal arousals or other sleep disruptions thought to be seizure related


define "Has Paroxysmal Arousal or Other Sleep Disruptions Thought to be Seizure Related":
  exists ( PS."Qualifying Sleep Disruptions Thought to be Seizure Related" )

define "Unknown Paroxysmal Arousals or Other Sleep Disruptions Thought to be Seizure Related":
  IsNull("Has Paroxysmal Arousal or Other Sleep Disruptions Thought to be Seizure Related")

//Periodic Limb Movement Disorder (PLMD)


define "Has Periodic Limb Movement Disorder":
  exists ( PS."Qualifying Periodic Limb Movement Disorder" )

define "Unknown Periodic Limb Movement Disorder (PLMD)":
  IsNull("Has Periodic Limb Movement Disorder")

//Criteria to meet any one of following medical conditions:


define "Has Applicable Medical Condition For Facility-Based PSG Value":
  "Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA"
    or "Has Central Sleep Apnea"
    or "Has Qualifying Feature Associated With Narcolepsy When MSLT is Planned"
    or "Has Obesity Hypoventilation Syndrome"
    or "Has History of Traumatic Brain Injury with Excessive Daytime Sleepiness"
    or "Has Idiopathic Central Nervous System Hypersomnia When MSLT is Planned"
    or "Lacks Cognitive Function, Dexterity, or Mobility for Safe Use of Equipment"
    or "Has Mission Critical Profession"
    or "Has Moderate To Severe Pulmonary Disease"
    or "Has Neuromuscular Disease With Associated Pulmonary Disease"
    or "Has Parasomnia"
    or "Has Paroxysmal Arousal or Other Sleep Disruptions Thought to be Seizure Related"
    or "Has Periodic Limb Movement Disorder"
    or "Has Cardiac Disease"

define "Has Applicable Medical Condition For Facility-Based PSG":
  IsTrue("Has Applicable Medical Condition For Facility-Based PSG Value")

define "Has No Applicable Medical Conditions For Facility-Based PSG":
  IsFalse("Has Applicable Medical Condition For Facility-Based PSG Value")

define "Null Applicable Medical Conditions For Facility-Based PSG":
  IsNull("Has Applicable Medical Condition For Facility-Based PSG Value")

define "LineBreak":
  '\r\n'

//Approved Response


define "Approved Detail":
  'Prior Authorization APPROVED.' + "LineBreak" + 'Reasoning:' + "Approved Age" + "Approved EDS" + "Approved Applicable Medical Condition For Facility-Based PSG"

define "Approved Age":
  if "Is Qualifying Age" then "LineBreak" + '- Is qualifying age' 
    else null

define "Approved EDS":
  if "Has Excessive Daytime Sleepiness"
    and "Has Additional Daytime Sleepiness Indicators" then "LineBreak" + '- Individual has Excessive Daytime Sleepiness and one of the following additional indicators: ESS score of 10 or greater, excessive sleepiness while driving, snore loudly/intensely, witnessed nocturnal apnea, choking and/or gasping' 
    else null

define "Approved Applicable Medical Condition For Facility-Based PSG":
  if "Has Applicable Medical Condition For Facility-Based PSG" then "LineBreak" + '- Individual presents with any of the following: diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS) implantation with a known diagnosis of OSA, central sleep apnea (CSA), narcolespy when a multiple sleep latency test (MSLT) is planned, obesity hypoventilation syndrome (OHS), traumatic brain injury (TBI) with EDS, idiopathic central nervous system hyperinsomnia when a MSLT is planned, individual or caregiver lacks cognitive function, dexterity, or mobility to use portable monitor (PM) equipment safely, has a mission critical profession, moderate to severe pulmonary disease, neuromuscular disease associated with pulmonary disease, unusual or atypical parasomnias, paroxysmal arousals or other sleep disruptions thought to be seizure related, periodic limb movement disorder, and/or cardiac disease' 
    else null

//Not Approved Response


define "Not Approved Detail":
  ' Prior Authorization DENIED.' + "LineBreak" + 'Reasoning:' + Coalesce(if "Not Within Qualifying Age" then "LineBreak" + '- Individual is not within the qualifying age.' 
      else null, "Not Approved EDS", "Not Approved Absence of Comorbid Conditions"
  )

define "Not Approved EDS":
  if "No Excessive Daytime Sleepiness" then "LineBreak" + '- Individual does not have excessive daytime sleepiness.' 
    else if "Has Excessive Daytime Sleepiness"
    and "Has No Additional Daytime Sleepiness Indicators" then "LineBreak" + '- Individual has none of the following additional daytime sleepiness indicators: ESS score of 10 or greater, excessive sleepiness while driving, snore loudly/intensely, witnessed nocturnal apnea, choking and/or gasping' 
    else null

define "Not Approved Absence of Comorbid Conditions":
  if "Has No Applicable Medical Conditions For Facility-Based PSG" then "LineBreak" + '- Individual has an absence of the following: diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS) implantation with a known diagnosis of OSA, central sleep apnea (CSA), narcolespy when a multiple sleep latency test (MSLT) is planned, obesity hypoventilation syndrome (OHS), traumatic brain injury (TBI) with EDS, idiopathic central nervous system hyperinsomnia when a MSLT is planned, individual or caregiver lacks cognitive function, dexterity, or mobility to use portable monitor (PM) equipment safely, has a mission critical profession, moderate to severe pulmonary disease, neuromuscular disease associated with pulmonary disease, unusual or atypical parasomnias, paroxysmal arousals or other sleep disruptions thought to be seizure related, periodic limb movement disorder, and/or cardiac disease' 
    else null

//Not Approved Null Response


define "Temporarily Not Approved":
  'Prior Authorization PENDING.' + "LineBreak" + 'Reasoning:' + Coalesce(if "Age Unknown" then 'Please enter the following: Patient Age' 
      else null, "Null EDS", "Null Eligible Medical Conditions for Facility-Based Polysomnogram (PSG)"
  )

define "Null EDS":
  if "Null Excessive Daytime Sleepiness" then "LineBreak" + ' - Please enter the following: Excessive Daytime Sleepiness' 
    else if "Null Additional Daytime Sleepiness Indicators" then "LineBreak" + 'Please enter the following: Additional Sleepiness Indicators' + ( if PAA."Null ESS Score" then "LineBreak" + ' - Please enter the following: Epworth Sleepiness Scale' 
      else if PAA."Null Excessive Sleepiness While Driving" then "LineBreak" + ' - Please enter the following: Excessive Sleepiness While driving' 
      else if PAA."Null Snoring Volume/Intensity" then "LineBreak" + ' - Please enter the following: Loud/Intense Snoring' 
      else if PAA."Null Apnea" then "LineBreak" + ' - Please enter the following: Nocturnal apnea' 
      else null
  ) 
    else null

define "Null Eligible Medical Conditions for Facility-Based Polysomnogram (PSG)":
  if "Null Applicable Medical Conditions For Facility-Based PSG" then "LineBreak" + 'Please enter the following: Applicable Medical Conditions' + ( if "Null Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA" then "LineBreak" + ' - Please enter the following: Diagnostic Testing Prior to Planned Hypoglossal Nerve Stimulator (HGNS) Implantation With Diagnosis of Obstructive Sleep Apnea (OSA)' 
      else if "Null Central Sleep Apnea (CSA)" then "LineBreak" + ' - Please enter the following: Central Sleep Apnea (CSA)' 
      else if "Unknown Features Associated With Narcolepsy When MSLT is Planned" then "LineBreak" + ' - Please enter the following: Features Associated With Narcolepsy When MSLT is Planned' 
      else if "Unknown Obesity Hypoventilation Syndrome (OHS)" then "LineBreak" + ' - Please enter the following: Obesity Hypoventilation Syndrome (OHS)' 
      else if "Unknown History of Traumatic Brain Injury (TBI) with Excessive Daytime Sleepiness (EDS)" then "LineBreak" + ' - Please enter the following: Traumatic Brain Injury (TBI) with Excessive Daytime Sleepiness (EDS)' 
      else if "Null Idiopathic Central Nervous System Hypersomnia When MSLT is Planned" then "LineBreak" + ' - Please enter the following: Idiopathic Central Nervous System Hypersomnia When MSLT is Planned' 
      else if "Unknown Lack of Cognitive Function, Dexterity, or Mobility to Use Portable Monitor (PM) Safely At Home" then "LineBreak" + ' - Please enter the following: Lack of Cognitive Function, Dexterity, or Mobility to Use Portable Monitor (PM) Safely At Home' 
      else if "Unknown Profession or Unknown Whether Profession is Mission Critical" then "LineBreak" + ' - Please enter the following: Mission Critical Profession' 
      else if PAA."Null Pulmonary Disease" then "LineBreak" + ' - Please enter the following: Moderate to Severe Pulmonary Disease' 
      else if PAA."Null Nueromuscular Disease" then "LineBreak" + ' - Please enter the following: Neuromuscular Disease With Associated Pulmonary Disease' 
      else if "Unknown Parasomnia" then "LineBreak" + ' - Please enter the following: Parasomnias' 
      else if "Unknown Paroxysmal Arousals or Other Sleep Disruptions Thought to be Seizure Related" then "LineBreak" + ' - Please enter the following: Paroxysmal Arousals or Other Sleep Disruptions Thought to be Seizure Related' 
      else if "Unknown Periodic Limb Movement Disorder (PLMD)" then "LineBreak" + ' - Please enter the following: Periodic Limb Movement Disorder (PLMD)' 
      else if PAA."Null Cardiac Disease" then "LineBreak" + ' - Please enter the following: Cardiac Disease' 
      else null
  ) 
    else null