/*
COVERAGE DETERMINATIONS
ALL PATIENTS MUST BE 18 OR OLDER

PlanDef: Home/Portable Monitor Sleep Testing 
description: Humana members may be eligible under the Plan for a home/portable monitor (PM) sleep testing to confirm the suspected diagnosis of moderate to severe obstructive sleep apnea (OSA) when ALL of the following criteria are met: 
  
IF 
  {
  Patient has Excessive Daytime Sleepiness {
    AND {
      Epworth Sleepiness Scale (ESS) score of 10 or greater
      OR Excessive sleepiness while driving
      OR Loud/intense snoring
      OR Witnessed nocturnal apnea, choking and/or gasping}
      }
  AND Absence of (the following) Eligible Comorbid Conditions {
    AND {
      Moderate to severe pulmonary disease including, but may not be limited to {
         Chronic obstructive pulmonary disease (COPD) with an FEV1 (forced expiratory volume in one second) less than 60%, use of home oxygen or evidence of hypoventilation such as carbon dioxide (CO2) level greater than or equal to 45 mm Hg
         OR Nocturnal or uncontrolled asthma}
      OR Neuromuscular disease with associated pulmonary disease including, but may not be limited to: amyotrophic lateral sclerosis, multiple sclerosis, myotonic dystrophy, Parkinson’s, previous stroke with residual respiratory effects, spina bifida or uncontrolled epilepsy
      OR Cardiac disease, including but may not be limited to: congestive heart failure (CHF) (New York Heart Association class III or IV or left ventricular ejection fraction [LVEF] less than 45%), pulmonary hypertension or uncontrolled cardiac arrhythmia}
  }
  AND Eligible Devices {
    Examples include but not limited to {
    AccuSom
    OR Alice PDx Portable Sleep System
    OR ApneaLink Air
    OR ARES Home Sleep Test System
    OR Embletta MPR-PG
    OR NightOwl or NightOwl Mini
    OR Nox T3s
    OR Sleep Profiler PSG2
    OR SleepView
    OR StarDust II
    OR WatchPAT 300 or WatchPAT ONE }
  }
  AND Individual or caregiver has appropriate cognitive function, dexterity and mobility to use equipment safely at home
  AND Home sleep testing results must be evaluated by a qualified physician
  }
THEN 
 {Approved}
ELSE
  {Denied}


PlanDef: Repeat Sleep Study – Home/Portable Monitor Sleep Testing
description: Humana members may be eligible under the Plan for a repeat home/portable monitor (PM) sleep test when the following criteria are met:

IF 
  {
  Patient has Evaluation following adjustment of an oral appliance prescribed for the treatment of OSA
  OR Evaluation following surgery for OSA
  OR Reassessment of an individual with documented OSA after significant weight loss or gain (10% of body weight) with persistent OSA symptoms
  }
THEN 
  {Approved}
ELSE
  {Denied}


PlanDef:Facility-Based Polysomnogram
description: Humana members may be eligible under the Plan for a facility-based PSG to confirm the suspected diagnosis of moderate to severe OSA when the following criteria are met:

IF 
  {
  Patient has Excessive Daytime Sleepiness {
    AND {
      Epworth Sleepiness Scale (ESS) score of 10 or greater
      OR Excessive sleepiness while driving
      OR Loud/intense snoring
      OR Witnessed nocturnal apnea, choking and/or gasping}
      }
  AND Individual presents with ANY of the following {
    Diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS) implantation for an individual with a known diagnosis of OSA
    OR History of or clinical features associated with central sleep apnea (CSA) (including CSA with Cheyne-Stokes breathing pattern, CSA due to high-altitude periodic breathing or CSA due to regular use of a long-acting opioid medication or other respiratory depressant for at least 2 months duration)
    OR History of or clinical features associated with narcolepsy (moderate to severe daytime sleepiness associated with cataplexy, hypnagogic hallucinations or sleep paralysis) when a MSLT is planned
    OR History of or clinical features associated with obesity hypoventilation syndrome (OHS) (BMI greater than 30kg/m2 with alveolar hypoventilation when awake [PaCO2 greater than 45 mmHg] which cannot be attributed to other conditions such as hypothyroidism, neuromuscular weakness, pleural pathology, pulmonary disease or skeletal restriction)
    OR History of traumatic brain injury (TBI) with EDS (eg, post-traumatic hypersomnia, post-traumatic narcolepsy)
    OR Idiopathic central nervous system hypersomnia (presence of difficult morning awakening, constant somnolence, prolonged night sleep or sleep drunkenness) when a MSLT is planned
    OR Individual (or caregiver) lacks cognitive function, dexterity or mobility to use PM equipment safely at home
    OR Mission critical profession including, but may not be limited to: airline pilots, bus drivers, military personnel and truck drivers
    OR Moderate to severe pulmonary disease including, but may not be limited to {
      Chronic obstructive pulmonary disease (COPD) with an FEV1 less than 60%, use of home oxygen or evidence of hypoventilation such as CO2 level greater than or equal to 45 mm Hg
      OR Nocturnal or uncontrolled asthma
    }
    OR Neuromuscular disease with associated pulmonary disease including, but may not be limited to: amyotrophic lateral sclerosis, multiple sclerosis, myotonic dystrophy, Parkinson’s, previous stroke with residual respiratory effects, spina bifida or uncontrolled epilepsy
    OR Parasomnias that are unusual or atypical because of the duration, frequency or time of the behavior including, but may not be limited to: confusional arousals, nocturnal seizures, psychogenic dissociative states and REM sleep behavior disorder
    OR Paroxysmal arousals or other sleep disruptions thought to be seizure related
    OR Periodic limb movement disorder** (involuntary, jerking movements of the legs during sleep causing EDS due to sleep fragmentation)
    OR Cardiac disease, including but may not be limited to: CHF (New York Heart Association class III or IV or LVEF less than 45%), pulmonary hypertension or uncontrolled cardiac arrhythmia
  }
  }
THEN 
  {Approved}
ELSE 
  {Denied}


PlanDef: Repeat Sleep Study – Facility-Based Polysomnogram
description: Humana members may be eligible under the Plan for a repeat facility-based PSG when the following criteria are met:

IF
  {
  Diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS) implantation for an individual with a known diagnosis of OSA
  OR Individual (or caregiver) lacks cognitive function, dexterity or mobility to use PM equipment safely at home
  OR Reassessment warranted of an individual with documented OSA after significant weight loss or gain (10% of body weight) with persistent OSA symptoms
  OR Results of previous home/PM sleep test or PAP device-generated data were indeterminate or technically inadequate for suspected OSA in an individual with a high pretest probability
  OR Post-HGNS implantation for: {
    Titrating device parameters and determining therapeutic stimulation setting (approximately 1 month following the implantation)
    OR Substantial weight gain (10% of body weight) with return of OSA symptoms
  }
  }
THEN
  {Approved}
ELSE
  {Denied}
  
  
  
PlanDef: Facility-Based Positive Airway Pressure Titration Study
description: Humana members may be eligible under the Plan for facility-based PAP titration study when the following criteria are met:

IF
  {
  Conclusive diagnosis of OSA as documented by sleep study
  AND any of the folowing {
    Failure of APAP treatment trial
    OR History of or clinical features associated with central sleep apnea (CSA) including CSA with Cheyne-Stokes breathing pattern, CSA due to high altitude periodic breathing or CSA due to regular use of a long-acting opioid medication or other respiratory depressant for at least 2 months duration)
    OR History of or clinical features associated with OHS (BMI greater than 30kg/m2 with alveolar hypoventilation when awake [PaCO2 greater than 45 mmHg]), which cannot be attributed to other conditions such as hypothyroidism, neuromuscular weakness, pleural pathology, pulmonary disease or skeletal restriction
    OR Individual (or caregiver) lacks cognitive function, dexterity and mobility to use PM equipment safely at home
    OR Presence of comorbid medical condition(s) that would degrade the accuracy of home/portable monitor sleep testing when at least ONE of the following is present:{
      Moderate to severe pulmonary disease including, but may not be limited to: COPD, nocturnal or uncontrolled asthma
      OR Neuromuscular disease with associated pulmonary disease including, but may not be limited to: amyotrophic lateral sclerosis, multiple sclerosis, myotonic dystrophy, Parkinson’s, previous stroke with residual respiratory effects, spina bifida or uncontrolled epilepsy
      OR Cardiac disease including, but may not be limited to: CHF (New York Heart Association class III or IV or LVEF less than 45%), pulmonary hypertension or uncontrolled cardiac arrhythmia
      OR Symptoms of OSA persist and/or attempts to comply with PAP device have failed despite documented provider support including proper fitting of device and individual education
    }
  }
  }
THEN
  {Approved}
ELSE
  {Denied}


PlanDef: Multiple Sleep Latency Test and Maintenance of Wakefulness Test
description: Humana members may be eligible under the Plan for multiple sleep latency test (MSLT) or maintenance of wakefulness test (MWT) when ALL of the following criteria are met:

IF
  {
  Assessment of treatment response or presence of associated features of narcolepsy such as: cataplexy, EDS/hypersomnia, hypnagogic hallucinations or sleep paralysis
  AND Testing consists of nap opportunities performed at 2 hour intervals (initial nap opportunity begins within 90 minutes to 3 hours after termination of the nocturnal PSG recording)
  AND Testing is performed in the daytime immediately following a negative nocturnal PSG (during which a minimum of 6 hours sleep was achieved and sleep apnea not diagnosed) for the evaluation of symptoms of narcolepsy
  AND 
  }
THEN
  {Approved}
ELSE
  {Denied}


COVERAGE LIMITATIONS

PlanDef: Facility-based polysomnogram (PSG), facility-based PAP titration study, or home/portable monitor (PM) sleep testing
description:Humana members may NOT be eligible under the Plan for a facility-based polysomnogram (PSG), facility-based PAP titration study or home/portable monitor (PM) sleep testing for ANY indications other than those listed above, including the following:

IF
  {
  Circadian rhythm disorders
  OR Common, uncomplicated or noninjurious parasomnias, such as typical disorders of arousal, bruxism, enuresis, nightmares or sleep talking
  OR Facility-based or home sleep testing to calibrate or evaluate noncovered devices
  OR Home sleep testing not evaluated by a qualified physician
  OR Insomnia
  OR Restless legs syndrome (RLS)
  }
THEN
  {Denied} //Is this right?
ELSE
  {Approved} //Is this right?


PlanDef: Multiple Sleep Latency Test and Maintenance of Wakefulness Test
description: Humana members may NOT be eligible under the Plan for MSLT or MWT for any indications other than those listed above, including:

IF
  {
  Performance following a positive PSG (during which a minimum of 6 hours sleep was achieved and sleep apnea or OSA diagnosed)
  OR Single nap studies for the diagnosis of any sleep disorder, including narcolepsy
  OR Unattended or home MSLT study
  }
THEN
  {Denied} //Is this right?
ELSE
  {Approved} //Is this right?  

Coverage Limitations (Humana members may NOT be eligible under the Plan for a facility-based polysomnogram (PSG), facility-based PAP titration study or home/portable monitor (PM) sleep testing for ANY indications other than those listed above, including the following)
- Age Restrictions????
- Circadian rhythm disorders
- OR Common, uncomplicated or noninjurious parasomnias, such as typical disorders of arousal, bruxism, enuresis, nightmares or sleep talking
- Facility-based or home sleep testing to calibrate or evaluate noncovered devices
- Home sleep testing not evaluated by a qualified physician
- Insomnia
- Restless legs syndrome (RLS)

- MAY NOT BE ELIGIBLE:
  - sleep study testing using artificial intelligence (eg, SomnoMetry, EnsoSleep, Sunrise System) ; ( This is considered experimental/investigational as it is not identified as widely used and generally accepted for any other proposed use as reported in nationally recognized peer-reviewed medical literature published in the English language)  
  - Wesper Home Sleep Lab (Although it may be prescribed by a health care practitioner, Wesper Home Sleep Lab is also available without a prescription and may be obtained over-the-counter (OTC) and is therefore generally excluded in the certificate. In the absence of a certificate exclusion for OTC items, this is considered experimental/investigational as it is not identified as widely used and generally accepted for the proposed use as reported in nationally recognized peer reviewed medical literature published in the English language)
  - facility-based, daytime, abbreviated, cardiorespiratory sleep studies (PAP NAP testing) to acclimate individuals to PAP for any indications. (This is considered experimental/ investigational as it is not identified as widely used and generally accepted for the proposed use as reported in nationally recognized peer-reviewed medical literature published in the English language.)
  - facility-based PAP titration study for upper airway resistance syndrome (UARS). (This is considered experimental/investigational as it is not identified as widely used and generally accepted for the proposed use as reported in nationally recognized peer-reviewed medical literature published in the English language)
  - Multiple Sleep Latency Test and Maintenance of Wakefulness Test. (These are considered experimental/investigational as they are not identified as widely used and generally accepted for any other proposed uses as reported in nationally recognized peer reviewed medical literature published in the English language) (Humana members may NOT be eligible under the Plan for MSLT or MWT for any indications other than those listed above, including:
    - Performance following a positive PSG (during which a minimum of 6 hours sleep was achieved and sleep apnea or OSA diagnosed)
    - OR Single nap studies for the diagnosis of any sleep disorder, including narcolepsy
    - OR Unattended or home MSLT study) 
  - prescreening devices or procedures to predict pretest probability of OSA prior to seeking a sleep study including, but may not be limited to, acoustic pharyngometry and SleepStrip; (This is considered experimental/investigational as it is not identified as widely used and generally accepted for the proposed use as reported in nationally recognized peer reviewed medical literature published in the English language)
  - Belun Ring BLR 100x for any indication. (Although it may be prescribed by a health care practitioner, Belun Ring BLR 100x is also available without a prescription and may be obtained over- the-counter (OTC) and is therefore generally excluded in the certificate. In the absence of a certificate exclusion for OTC items, this is considered experimental/ investigational as it is not identified as widely used and generally accepted for the proposed use as reported in nationally recognized peer reviewed medical literature published in the English language)
  - stand-alone actigraphy, such as the Actiwatch Spectrum, for the diagnosis of any sleep disorder. (This is considered experimental/investigational as it is not identified as widely used and generally accepted for the proposed use as reported in nationally recognized peer reviewed medical literature published in the English language)

- MEDICAL ALTERNATIVES (Recommendations?)
  - Physician consultation is advised to make an informed decision based on an individual’s health needs.
  - Humana may offer a disease management program for this condition. The member may call the number on his/her identification card to ask about our programs to help manage his/her care

PROVIDER CLAIMS CODES (idk if this is needed)
(Any CPT, HCPCS or ICD codes listed on this medical coverage policy are for informational purposes only. Do not rely on the accuracy and inclusion of specific codes. Inclusion of a code does not guarantee coverage and or reimbursement for a service or procedure)

*/

Alias: $plan-definition-type = http://terminology.hl7.org/CodeSystem/plan-definition-type
Alias: $usage-context-type = http://terminology.hl7.org/CodeSystem/usage-context-type
Alias: $activity-codes = http://fhir.org/guides/nachc/hiv-cds/CodeSystem/activity-codes
Alias: $iso3166-1-3 = http://hl7.org/fhir/ValueSet/iso3166-1-3
Alias: $action-type = http://terminology.hl7.org/CodeSystem/action-type

RuleSet: CommonProperties(value, rationale, expression)
* meta.profile = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-publishableplandefinition"
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
  * valueCode = #shareable
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
  * valueCode = #computable
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
  * valueCode = #executable
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeCapability"
  * valueCode = #publishable
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-knowledgeRepresentationLevel"
  * valueCode = #structured
* extension[+]
  * url = "http://hl7.org/fhir/us/cqfmeasures/StructureDefinition/cqfm-softwaresystem"
  * valueReference = Reference(Device/cqf-tooling)
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-questionnaire-generate"
  * valueBoolean = true
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-rationale"
  * valueMarkdown.extension
    * url = "http://hl7.org/fhir/StructureDefinition/cqf-expression"
    * valueExpression
      * description = {rationale}
      * language = #text/cql-identifier
      * expression = {expression}
* identifier[+]
  * use = #official
  * value = {value}
* version = "1.0.0"
* status = #draft
* experimental = true
* useContext
  * code = $usage-context-type#task "Workflow Task"
  * valueCodeableConcept = $activity-codes#ASLP.PAS "Prior Auth Adjudication" //change to right code and display value when possible
* publisher = "Smile Digital Health"
* jurisdiction
  * coding[+]
    * version = "4.0.1"
    * system = $iso3166-1-3
    * code = #USA
    * display = "United States of America"
* usage = "This is to be used in conjunction with a patient-facing FHIR application."

RuleSet: ActionInputCql(expression, name)
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-featureExpression"
  * valueExpression
    * language = #text/cql-identifier
    * expression = {expression}
    * reference = "http://example.org/sdh/dtr/aslp/Library/{name}"

RuleSet: ActionInput(string, markdown)
* extension[0]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-input-text"
  * valueString = {string}
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-input-description"
  * valueMarkdown = {markdown}

RuleSet: ActionConditionCql(expression)
* condition
  * kind = #applicability
  * expression
    * language = #text/cql-identifier
    * expression = {expression}



Instance: PAA-Approved
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Prior Authorization Adjudication Approved", "Approved PAA", "pa-adju-approved")

* library = "http://example.org/sdh/dtr/aslp/Library/pa-approved"

* action[+]
  * title = "Prior Auth Adjudication Approved"
  * description = "Prior authorization adjudication approval for sleep study tests"
  * input
    * insert ActionInput("Patient has been approved?", "Patient has been approved")
    * insert ActionInputCql("PAA Approved", pa-approved)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/approved-pa"
  * action[0]
    * title = "Approved"
    * description = "Patient has been Approved"
    * insert ActionConditionCql("Approved")
  * action[+]
    * title = "Override Approval"
    * description = "Override approval"
    * insert ActionConditionCql("Override Approval")

Instance: PAA-Denial
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Prior Authorization Adjudication for Sleep Study Denial", "Denied PAA", "aslp-pa-adj-not-approved")

* library = "http://example.org/sdh/dtr/aslp/Library/pa-denied"

* action[+]
  * title = "Denied Prior Authorization Adjudication"
  * description = "Prior Authorization Adjudication for Sleep Study Denied"
  * input
    * insert ActionInput("Is Sleep Study Denied?", "Sleep Study is Denied")
    * insert ActionInputCql("Denied", pa-not-approved)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/pa-adj-not-approved"
  * action[0]
    * title = "Denied"
    * description = "Patient has been denied"
    * insert ActionConditionCql("Denied")
  * action[+]
    * title = "Override Denial"
    * description = "Override Denial"
    * insert ActionConditionCql("Override Denial")
  * action[+]
    * title = "Null or unknown response"
    * description = "Response is null or unknown. Please resubmit responses."
    * insert ActionConditionCql("Null or Unknown Response")


        

//Home/Portable Monitor Sleep Testing to confirm the suspected diagnosis of moderate to severe obstructive sleep apnea (OSA)
Instance: Home-Monitor-Sleep-Testing
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Prior Authorization Adjudication for Home/portable monitor sleep testing", "Home Monitor PAA", "pa-adju-home-mon")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* action
  * title = "Qualifying Patient Age"
  * description = "Input for whether the patient is within qualifying age."
  * input
    * insert ActionInput("Is patient 18 years or older?", "The patient is 18 years or older")
    * insert ActionInputCql("Qualifying Patient Age", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-patientage-casefeature-definition"
  * action[0]
    * title = "Is Not Qualifying Patient Age"
    * description = "The patient is not within the qualifying age."
    * insert ActionConditionCql("Not Within Qualifying Age")
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
  * action[+]
    * title = "Age Unknown"
    * description = "The patient age is unknown. More Information is needed"
    * insert ActionConditionCql("Age Unknown") 
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
  * action[+]
    * title = "Is Qualifying Patient Age"
    * description = "The patient is within the qualifying age"
    * insert ActionConditionCql("Is Qualifying Age")    

  * action[+]
    * title = "Has Excessive daytime sleepiness (EDS)"
    * description = "Patient has excessive daytime sleepiness"
    * input
      * insert ActionInput("Patient has excessive daytime sleepiness?", "Patient has excessive daytime sleepiness")
      * insert ActionInputCql("Qualifying Excessive Daytime Sleepiness", ASLPPolicyPAA)
      * type = #Observation
      * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-eds-screening-casefeature"
    * action[0]
      * title = "Does Not Have excessive daytime sleepiness"
      * description = "The patient does not have excessive daytime sleepiness"
      * insert ActionConditionCql("No Excessive Daytime Sleepiness")
      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
    * action[+]
      * title = "Null or Unknown excessive daytime sleepiness"
      * description = "Unknown answer. More Information is needed"
      * insert ActionConditionCql("Null Excessive Daytime Sleepiness")
      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
    * action[+]
      * title = "Has excessive daytime sleepiness"
      * description = "The patient has excessive daytime sleepiness"
      * insert ActionConditionCql("Has Excessive Daytime Sleepiness")
    
      * action[+]
        * title = "ESS score of 10 or greater"
        * description = "Epworth Sleepiness Scale (ESS) score of 10 or greater"
        * input
          * insert ActionInput("Does patient had ESS score >= 10?", "ESS score >= 10")
          * insert ActionInputCql("ESS Score >= 10", ASLPPolicyPAA)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-ess-screening-casefeature"
        * action[0]
          * title = "Does not have ESS score >= 10"
          * description = "Patient does not have ESS score of 10 or greater"
          * insert ActionConditionCql("Does Not Have ESS Score >= 10")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved" //Is this right??  
        * action[+]
          * title = "Null or Unknown ESS Score"
          * description = "Unknown answer. More Information is needed"
          * insert ActionConditionCql("Null ESS Score")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
        * action[+]
          * title = "Has an ESS score >= 10"
          * description = "Patient has an ESS Score of 10 or greater"
          * insert ActionConditionCql("Has ESS Score >= 10")
      
      * action[+]
        * title = "Excessive sleepiness while driving"
        * description = "Excessive sleepiness while driving"
        * input
          * insert ActionInput("Does patient have excessive sleepiness while driving", "Patient has Excessive sleepiness while driving")
          * insert ActionInputCql("Qualifying Excessive Sleepiness While Driving", ASLPPolicyPAA)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-sleepydriving-screening-casefeature"
        * action[0]
          * title = "Does not have excessive sleepiness while driving"
          * description = "Patient does not have excessive sleepiness while driving"
          * insert ActionConditionCql("Does Not Have Excessive Sleepiness While Driving")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved" //Is this right??  
        * action[+]
          * title = "Null or Unknown excessive sleepiness while driving"
          * description = "Unknown answer. More Information is needed"
          * insert ActionConditionCql("Null Excessive Sleepiness While Driving")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
        * action[+]
          * title = "Has excessive sleepiness while driving"
          * description = "Patient has excessive sleepiness while driving"
          * insert ActionConditionCql("Has Excessive Sleepiness While Driving")
      
      * action[+]
        * title = "Loud Snoring"
        * description = "Loud/intense snoring"
        * input
          * insert ActionInput("Does patient snore loudly", "Patient snores loudly")
          * insert ActionInputCql("Loud/Intense Snoring", ASLPPolicyPAA)
          * type = #Condition
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-loudsnoring-screening-casefeature"
        * action[0]
          * title = "Does not snore loudly/intensely"
          * description = "Patient does not snore loudly/intensely"
          * insert ActionConditionCql("Does Not Snore Loudly/Intensely")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved" //Is this right??  
        * action[+]
          * title = "Null or Unknown snoring volume"
          * description = "Unknown answer. More Information is needed"
          * insert ActionConditionCql("Null Snoring Volume/Intensity")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
        * action[+]
          * title = "Snores loudly/intensely"
          * description = "Patient snores loudly/intensely"
          * insert ActionConditionCql("Snores loudly/intensely")
      
      * action[+]
        * title = "Nocturnal Apnea"
        * description = "Witnessed nocturnal apnea, choking and/or gasping"
        * input
          * insert ActionInput("Does patient have nocturnal apnea", "Patient has nocturnal apnea")
          * insert ActionInputCql("Nocturnal Apnea", ASLPPolicyPAA)
          * type = #Condition
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-apnea-screening-casefeature"
        * action[0]
          * title = "Does not have nocturnal apnea"
          * description = "Patient does not have witnessed nocturnal apnea, choking and/or gasping"
          * insert ActionConditionCql("Does Not have nocturnal apnea")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved" //Is this right??  
        * action[+]
          * title = "Null or Unknown apnea"
          * description = "Unknown answer. More Information is needed"
          * insert ActionConditionCql("Null Apnea")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
        * action[+]
          * title = "Has Nocturnal Apnea"
          * description = "Patient has witnessed nocturnal apnea, choking and/or gasping"
          * insert ActionConditionCql("Has Nocturnal Apnea")

          * action[+]
            * title = "Absence of comorbid medical conditions"
            * description = "Absence of comorbid medical condition(s) that would reduce the accuracy of a home/PM sleep test"
            * input
              * insert ActionInput("Patient has absence of medical condition?", "Patient has absence comorbid medical condition")
              * insert ActionInputCql("Qualifying Absence Of Comorbid Medical Conditions", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-comorbid-screening-casefeature"
            * action[0]
              * title = "Does not have absence of comorbid medical conditions"
              * description = "The patient does not have an absence of comorbid medical conditions"
              * insert ActionConditionCql("No Absence Of Comorbid Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
            * action[+]
              * title = "Null or Unknown presence of comorbid medical conditions"
              * description = "Unknown answer. More Information is needed"
              * insert ActionConditionCql("Null Presence of Comorbid Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
            * action[+]
              * title = "Has an absence of comorbid medical conditions"
              * description = "The patient has an absence of comorbid medical conditions"
              * insert ActionConditionCql("Has Absence Of Comorbid Medical Conditions")
              
              * action
                * title = "Moderate to severe pulmonary disease"
                * description = "Moderate to severe pulmonary disease including, but may not be limited to: COPD, nocturnal or uncontrolled asthma"
                * input
                  * insert ActionInput("Patient has moderate to severe pulmonary disease?", "Patient has moderate to severe pulmonary disease")
                  * insert ActionInputCql("Qualifying Moderate To Severe Pulmonary Disease", ASLPPolicyPAA)
                  * type = #Observation
                  * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-moderatepulmonary-screening-casefeature"
                * action[0]
                  * title = "No Moderate to severe pulmonary disease"
                  * description = "Patient has no moderate to severe pulmonary disease"
                  * insert ActionConditionCql("No Moderate To Severe Pulmonary Disease")
                  * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                * action[+]
                  * title = "Null or Unknown pulmonary disease"
                  * description = "Unknown answer. More Information is needed"
                  * insert ActionConditionCql("Null Pulmonary Disease")
                  * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                * action[+]
                  * title = "Has moderate to severe pulmonary disease"
                  * description = "Patient has moderate to severe pulmonary disease"
                  * insert ActionConditionCql("Has Moderate To Severe Pulmonary Disease") 
                  
                  * action[+]
                    * title = "Moderate to severe pulmonary disease including COPD"
                    * description = "Moderate to severe pulmonary disease including Chronic Obstructive Pulmonary Disease (COPD) with an FEV1 less than 60%, use of home oxygen or evidence of hypoventilation such as CO2 level greater than or equal to 45 mm Hg"
                    * input
                      * insert ActionInput("Patient has moderate to severe pulmonary disease including COPD?", "Patient has moderate to severe pulmonary disease including COPD")
                      * insert ActionInputCql("Qualifying Moderate To Severe Pulmonary Disease Including COPD", ASLPPolicyPAA)
                      * type = #Observation
                      * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-pulmonarywithcopd-screening-casefeature"
                    * action[0]
                      * title = "No Moderate to severe pulmonary disease including COPD"
                      * description = "Patient has no moderate to severe pulmonary disease including chronic obstructive pulmonary disease"
                      * insert ActionConditionCql("No Moderate To Severe Pulmonary Disease Including COPD")
                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"  
                    * action[+]
                      * title = "Null or Unknown pulmonary disease including COPD"
                      * description = "Unknown answer. More Information is needed"
                      * insert ActionConditionCql("Null Pulmonary Disease Including COPD")
                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                    * action[+]
                      * title = "Has moderate to severe pulmonary disease including COPD"
                      * description = "Patient has moderate to severe pulmonary disease including chronic obstructive pulmonary disease"
                      * insert ActionConditionCql("Has Moderate To Severe Pulmonary Disease Including COPD")
                      
                  * action[+]
                    * title = "Moderate to severe pulmonary disease including nocturnal or uncontrolled asthma"
                    * description = "Moderate to severe pulmonary disease including nocturnal or uncontrolled asthma"
                    * input
                      * insert ActionInput("Patient has moderate to severe pulmonary disease including nocturnal or uncontrolled asthma?", "Patient has moderate to severe pulmonary disease including nocturnal or uncontrolled asthma")
                      * insert ActionInputCql("Qualifying Moderate To Severe Pulmonary Disease Including Asthma", ASLPPolicyPAA)
                      * type = #Observation
                      * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-pulmonarywithasthma-screening-casefeature"
                    * action[0]
                      * title = "No Moderate to severe pulmonary disease including asthma"
                      * description = "Patient has no moderate to severe pulmonary disease including nocturnal or uncontrolled asthma"
                      * insert ActionConditionCql("No Moderate To Severe Pulmonary Disease Including Asthma")
                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                    * action[+]
                      * title = "Null or Unknown pulmonary disease including asthma"
                      * description = "Unknown answer. More Information is needed"
                      * insert ActionConditionCql("Null Pulmonary Disease Including Asthma")
                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                    * action[+]
                      * title = "Has moderate to severe pulmonary disease including asthma"
                      * description = "Patient has moderate to severe pulmonary disease including nocturnal or uncontrolled asthma"
                      * insert ActionConditionCql("Has Moderate To Severe Pulmonary Disease Including Asthma") 
                      
                      * action
                        * title = "Neuromuscular disease with associated pulmonary disease"
                        * description = "Neuromuscular disease with associated pulmonary disease including, but may not be limited to: amyotrophic lateral sclerosis, multiple sclerosis, myotonic dystrophy, Parkinson’s, previous stroke with residual respiratory effects, spina bifida or uncontrolled epilepsy"
                        * input
                          * insert ActionInput("Patient has neuromuscular disease with associated pulmonary disease?", "Patient has neuromuscular disease with associated pulmonary disease")
                          * insert ActionInputCql("Qualifying Neuromuscular Disease With Associated Pulmonary Disease", ASLPPolicyPAA)
                          * type = #Observation
                          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscular-screening-casefeature"
                      * action[0]
                          * title = "No Neuromuscular disease with associated pulmonary disease"
                          * description = "Patient does not have neuromuscular disease with associated pulmonary disease"
                          * insert ActionConditionCql("No Neuromuscular Disease With Associated Pulmonary Disease")
                          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                      * action[+]
                          * title = "Null or Unknown neuromuscular diseas with associated pulmonary disease"
                          * description = "Unknown answer. More Information is needed"
                          * insert ActionConditionCql("Null Nueromuscular Disease")
                          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                      * action[+]
                          * title = "Has neuromuscular disease with associated pulmonary disease present"
                          * description = "Patient has Neuromuscular disease with associated pulmonary disease"
                          * insert ActionConditionCql("Has Neuromuscular Disease With Associated Pulmonary Disease")
          
                          * action[+]
                            * title = "Cardiac Disease"
                            * description = "Cardiac disease, including but may not be limited to; congestive heart failure (CHF) (New York Heart Association class III or IV or left ventricular ejection fraction [LVEF] less than 45%), pulmonary hypertension or uncontrolled cardiac arrhythmia"
                            * input
                              * insert ActionInput("Patient has Cardiac Disease?", "Patient has Cardiac Disease")
                              * insert ActionInputCql("Qualifying Cardiac Disease", ASLPPolicyPAA)
                              * type = #Observation
                              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature"
                            * action[0]
                              * title = "No Cardiac Disease"
                              * description = "Patient does not have Cardiac Disease"
                              * insert ActionConditionCql("No Cardiac Disease")
                              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                            * action[+]
                              * title = "Null or Unknown cardiac disease"
                              * description = "Unknown answer. More Information is needed"
                              * insert ActionConditionCql("Null Cardiac Disease")
                              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                            * action[+]
                              * title = "Has Cardiac Disease"
                              * description = "Patient has Cardiac Disease"
                              * insert ActionConditionCql("Has Cardiac Disease")
                  
                              * action[+]
                                * title = "Qualified device is used"
                                * description = "Type II, Type III, Type IV or PAT PM device is used (Type IV PM devices must measure a minimum of 3 channels that include heartrate, oxygen saturation and respiratory analysis)."
                                * input
                                  * insert ActionInput("Patient uses a qualified device?", "Patient uses a qualified device")
                                  * insert ActionInputCql("Uses A Qualified Device", ASLPPolicyPAA)
                                  * type = #Observation
                                  * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-qualifieddevice-screening-casefeature"
                                * action[0]
                                  * title = "Does not use a qualified device"
                                  * description = "The patient does not use Type II, Type III, Type IV or PAT PM device"
                                  * insert ActionConditionCql("Does Not Use Qualified Device")
                                  * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                                * action[+]
                                  * title = "Null or Unknown device used"
                                  * description = "Unknown answer. More Information is needed"
                                  * insert ActionConditionCql("Unknown Device Used")
                                  * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                                * action[+]
                                  * title = "Uses a qualified device"
                                  * description = "The patient uses Type II, Type III, Type IV or PAT PM device"
                                  * insert ActionConditionCql("Patient Uses Qualified Device")
                      
                                  * action[+]
                                    * title = "Can safely use equipment at home"
                                    * description = "Individual or caregiver has appropriate cognitive function, dexterity and mobility to use equipment safely at home"
                                    * input
                                      * insert ActionInput("Patient can safely use equipment at home?", "Patient can safely use equipment at home")
                                      * insert ActionInputCql("Safe Equipment Use At Home", ASLPPolicyPAA)
                                      * type = #Observation
                                      * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-safehomeuse-screening-casefeature"
                                    * action[0]
                                      * title = "Can not safely use equipment at home"
                                      * description = "The patient can not safely use equipment at home"
                                      * insert ActionConditionCql("Can Not Safely Use Equipment At Home")
                                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                                    * action[+]
                                      * title = "Null or Unknown ability to use equipment at home"
                                      * description = "Unknown answer. More Information is needed"
                                      * insert ActionConditionCql("Unknown Ability To Use Equipment At Home")
                                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                                    * action[+]
                                      * title = "Can safely use equipment at home"
                                      * description = "The patient can safely use equipment at home"
                                      * insert ActionConditionCql("Can Safely Use Equipment At Home")                      
                          
                                      * action[+]
                                        * title = "Physician evaluated results"
                                        * description = "Home sleep testing results must be evaluated by a qualified physician"
                                        * input
                                          * insert ActionInput("Patient can have physician evaluate results?", "Patient can have physician evaluate results")
                                          * insert ActionInputCql("Physician Evaluated Results", ASLPPolicyPAA)
                                          * type = #Observation
                                          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-physicianevaluated-screening-casefeature"
                                        * action[0]
                                          * title = "Unable to have physician evaluate results"
                                          * description = "The patient is unable to have physician evaluate results of home sleep tests"
                                          * insert ActionConditionCql("Unable To Have Physician Evaluate Results")
                                          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                                        * action[+]
                                          * title = "Null or Unknown ability to have physician evaluate results"
                                          * description = "Unknown answer. More Information is needed"
                                          * insert ActionConditionCql("Unknown Ability To Have Physician Evaluate Results")
                                          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                                        * action[+]
                                          * title = "Able to have physician evaluated results"
                                          * description = "The patient is able to have physician evaluate results of home sleep tests"
                                          * insert ActionConditionCql("Ability To Have Physician Evaluate Results")
                                          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-approved"

  

/*
//Option 2:  
Instance: Home-Monitor-Sleep-Testing
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Prior Authorization Adjudication for Home/portable monitor sleep testing", "Home Monitor PAA", "pa-adju-home-mon")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* action
  * title = "Qualifying Patient Age"
  * description = "Input for whether the patient is within qualifying age."
  * input
    * insert ActionInput("Is patient 18 years or older?", "The patient is 18 years or older")
    * insert ActionInputCql("Qualifying Patient Age", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/qualifying-age-casefeature"
  * action[0]
    * title = "Is Not Qualifying Patient Age"
    * description = "The patient is not within the qualifying age."
    * insert ActionConditionCql("Not Within Qualifying Age")
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
  * action[+]
    * title = "Age Unknown"
    * description = "The patient age is unknown. More Information is needed"
    * insert ActionConditionCql("Age Unknown") 
  * action[+]
    * title = "Is Qualifying Patient Age"
    * description = "The patient is within the qualifying age"
    * insert ActionConditionCql("Is Qualifying Age")    

  * action[+]
    * title = "Has Excessive daytime sleepiness (EDS)"
    * description = "Patient has excessive daytime sleepiness"
    * input
      * insert ActionInput("Patient has excessive daytime sleepiness?", "Patient has excessive daytime sleepiness")
      * insert ActionInputCql("Excessive Daytime Sleepiness", ASLPPolicyPAA)
      * type = #Observation
      * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/excessive-daytime-sleepiness"
    * action[0]
      * title = "Does Not Have excessive daytime sleepiness"
      * description = "The patient does not have excessive daytime sleepiness"
      * insert ActionConditionCql("No Excessive Daytime Sleepiness")
      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
    * action[+]
      * title = "Null or Unknown excessive daytime sleepiness"
      * description = "Unknown answer. More Information is needed"
      * insert ActionConditionCql("Null Excessive Daytime Sleepiness")
    * action[+]
      * title = "Has excessive daytime sleepiness"
      * description = "The patient has excessive daytime sleepiness"
      * insert ActionConditionCql("Has Excessive Daytime Sleepiness")
      * action
        * input[0]
          * insert ActionInput("Patient has ESS score of 10 or greater?", "Patient has ESS score of 10 or greater")
          * insert ActionInputCql("ESS Score Of >= 10", ASLPPolicyPAA)
          * type = #Observation
        * input[+]
          * insert ActionInput("Patient has excessive sleepiness while driving?", "Patient has excessive sleepiness while driving")
          * insert ActionInputCql("Excessive Sleepiness While Driving", ASLPPolicyPAA)
          * type = #Observation
        * input[+]
          * insert ActionInput("Patient snores loudly/intensly?", "Patient snores loudly/intensly")
          * insert ActionInputCql("Loud/Intense Snoring", ASLPPolicyPAA)
          * type = #Observation
        * input[+]
          * insert ActionInput("Patient has nocturnal apnea?", "Patient has nocturnal apnea")
          * insert ActionInputCql("Nocturnal Apnea", ASLPPolicyPAA)
          * type = #Observation
        
        * action[+]
          * title = "Absence of the following comorbid medical conditions"
          * description = "Absence of comorbid medical condition(s) that would reduce the accuracy of a home/PM sleep test"
          * input
            * insert ActionInput("Patient has absence of the following comorbid medical condition?", "Patient has absence of the following comorbid medical condition")
            * insert ActionInputCql("Absence Of The Following Comorbid Medical Conditions", ASLPPolicyPAA)
            * type = #Observation
            * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/absence-of-comorbid-conditions"
          * action[0]
            * title = "Has one of the following comorbid medical conditions"
            * description = "The patient does not have an absence of the following comorbid medical conditions"
            * insert ActionConditionCql("Has One Of The Following Comorbid Medical Conditions")
            * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
          * action[+]
            * title = "Null or Unknown absence of comorbid medical conditions"
            * description = "Unknown answer. More Information is needed"
            * insert ActionConditionCql("Null Absence Of Comorbid Medical Conditions")
          * action[+]
            * title = "Has an absence of the following comorbid medical conditions"
            * description = "The patient has an absence of the following comorbid medical conditions"
            * insert ActionConditionCql("Has Absence Of The Following Comorbid Medical Conditions")
            * action
              * input[0]
                * insert ActionInput("Patient has neuromuscular disease with associated pulmonary disease?", "Patient has neuromuscular disease with associated pulmonary disease")
                * insert ActionInputCql("Neuromuscular Disease With Associated Pulmonary Disease", ASLPPolicyPAA)
                * type = #Observation
              * input[+]
                * insert ActionInput("Patient has Cardiac Disease?", "Patient has Cardiac Disease")
                * insert ActionInputCql("Cardiac Disease", ASLPPolicyPAA)
                * type = #Observation
              * input[+]
                * insert ActionInput("Patient has moderate to severe pulmonary disease?", "Patient has moderate to severe pulmonary disease")
                * insert ActionInputCql("Moderate To Severe Pulmonary Disease", ASLPPolicyPAA)
                * type = #Observation
              * input[+] //Should this be equal??
                * insert ActionInput("Patient has moderate to severe pulmonary disease including COPD?", "Patient has moderate to severe pulmonary disease including COPD")
                * insert ActionInputCql("Moderate To Severe Pulmonary Disease Including COPD", ASLPPolicyPAA)
                * type = #Observation
              * input[=] //Should this be equal??
                * insert ActionInput("Patient has moderate to severe pulmonary disease including asthma?", "Patient has moderate to severe pulmonary disease including asthma")
                * insert ActionInputCql("Moderate To Severe Pulmonary Disease Including Asthma", ASLPPolicyPAA)
                * type = #Observation
              
              * action[+]
                * title = "Can safely use equipment at home"
                * description = "Individual or caregiver has appropriate cognitive function, dexterity and mobility to use equipment safely at home"
                * input
                  * insert ActionInput("Patient can safely use equipment at home?", "Patient can safely use equipment at home")
                  * insert ActionInputCql("Can Safely Use Equipment At Home", ASLPPolicyPAA)
                  * type = #Observation
                  * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/safely-use-equip-at-home"
                * action[0]
                  * title = "Can not safely use equipment at home"
                  * description = "The patient can not safely use equipment at home"
                  * insert ActionConditionCql("Unable To Safely Use Equipment At Home")
                  * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                * action[+]
                  * title = "Null or Unknown ability to use equipment safely"
                  * description = "Unknown answer. More Information is needed"
                  * insert ActionConditionCql("Unknown Ability To Use Equipment At Home")
                * action[+]
                  * title = "Can safely use equipment at home"
                  * description = "The patient can safely use equipment at home"
                  * insert ActionConditionCql("Able To Safely Use Equipment At Home")
                
                * action[+]
                  * title = "Physician evaluated results"
                  * description = "Home sleep testing results must be evaluated by a qualified physician"
                  * input
                    * insert ActionInput("Patient can have physician evaluated results?", "Patient can have physician evaluated results")
                    * insert ActionInputCql("Physician Evaluated Results", ASLPPolicyPAA)
                    * type = #Observation
                    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/pysician-eval-results"
                  * action[0]
                    * title = "Can not have physician evaluated results"
                    * description = "The patient can not have physician evaluated results of home sleep tests"
                    * insert ActionConditionCql("Unable To Have Physician Evaluated Results")
                    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                  * action[+]
                    * title = "Null or Unknown ability to have physician evaluated results"
                    * description = "Unknown answer. More Information is needed"
                    * insert ActionConditionCql("Unknown Ability To Use Equipment At Home")
                  * action[+]
                    * title = "Can have physician evaluated results"
                    * description = "The patient can have physician evaluated results of home sleep tests"
                    * insert ActionConditionCql("Ability To Have Physician Evaluated Results")
                  
                  * action[+]
                    * title = "Type II, Type III, Type IV or PAT PM device is used"
                    * description = "Type II, Type III, Type IV or PAT PM device is used (Type IV PM devices must measure a minimum of 3 channels that include heartrate, oxygen saturation and respiratory analysis)."
                    * input
                      * insert ActionInput("Patient uses Type II\, Type III\, Type IV or PAT PM device?", "Patient uses Type II\, Type III\, Type IV or PAT PM device")
                      * insert ActionInputCql("Patient Uses Type II\, Type III\, Type IV or PAT PM Device", ASLPPolicyPAA)
                      * type = #Observation
                      * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/device-used"
                    * action[0]
                      * title = "Does not use Type II, Type III, Type IV or PAT PM device"
                      * description = "The patient does not use Type II, Type III, Type IV* or PAT PM device"
                      * insert ActionConditionCql("Does Not Use Qualified Device")
                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
                    * action[+]
                      * title = "Null or Unknown device used"
                      * description = "Unknown answer. More Information is needed"
                      * insert ActionConditionCql("Unknown Device Used")
                    * action[+]
                      * title = "Uses Type II, Type III, Type IV* or PAT PM device"
                      * description = "The patient uses Type II, Type III, Type IV* or PAT PM device"
                      * insert ActionConditionCql("Uses Qualified Device")
                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-approved"
          
            

Instance: PAA-Approval
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Prior Authorization Adjudication for Sleep Study Approval", "Sleep Study Approval PAA", "aslp-pa-adj-approved")

* library = "http://example.org/sdh/dtr/aslp/Library/pa-approved"

* action[+]
  * title = "Approved Prior Authorization Adjudication"
  * description = "Prior Authorization Adjudication for Sleep Study Approval"
  * input
    * insert ActionInput("Is Sleep Study Approved?", "Sleep Study is approved")
    * insert ActionInputCql("Approved", pa-approved)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/pa-adj-approved"


Instance: PAA-Denial
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Prior Authorization Adjudication for Sleep Study Denial", "Sleep Study Denial PAA", "aslp-pa-adj-not-approved")

* library = "http://example.org/sdh/dtr/aslp/Library/pa-not-approved"

* action[+]
  * title = "Denied Prior Authorization Adjudication"
  * description = "Prior Authorization Adjudication for Sleep Study Denial"
  * input
    * insert ActionInput("Is Sleep Study Denied?", "Sleep Study is Denied")
    * insert ActionInputCql("Denied", pa-not-approved)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/pa-adj-not-approved"
  * action[0]
    * title = "Sleep Study Denied"
    * description = "The patient is denied"
    * insert ActionConditionCql("Denied")
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
  * action[+]
    * title = "Null or Unknown"
    * description = "The response is null or unknown. Please provide more information"
    * insert ActionConditionCql("Response Null or Unknown") 

*/