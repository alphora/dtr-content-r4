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
  AND Absence of the following Eligible Comorbid Conditions {
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
*/

Alias: $plan-definition-type = http://terminology.hl7.org/CodeSystem/plan-definition-type
Alias: $usage-context-type = http://terminology.hl7.org/CodeSystem/usage-context-type
Alias: $activity-codes = http://fhir.org/guides/nachc/hiv-cds/CodeSystem/activity-codes
Alias: $iso3166-1-3 = http://hl7.org/fhir/ValueSet/iso3166-1-3
Alias: $action-type = http://terminology.hl7.org/CodeSystem/action-type
Alias: $x12-adjudication-status = https://codesystem.x12.org/005010/306

RuleSet: CommonProperties(value)
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

RuleSet: CommonPropertiesRationale(rationale, expression)
* extension[+]
  * url = "http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-rationale"
  * valueMarkdown.extension
    * url = "http://hl7.org/fhir/StructureDefinition/cqf-expression"
    * valueExpression
      * description = {rationale}
      * language = #text/cql-identifier
      * expression = {expression}

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



Instance: aslp-pa-adj-approved
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("aslp-pa-adj-approved")
* insert CommonPropertiesRationale("Prior Authorization Adjudication Approved", "Approved Detail")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-approved"

* action[+]
  * title = "Prior Auth Adjudication Approved"
  * description = "Prior authorization adjudication approval for sleep study tests"
  * code = $x12-adjudication-status#A1 "Approved"
  * dynamicValue[+]
    * path = "description" 
    * expression
      * language = #text/cql-identifier
      * expression = "Approved Detail"

Instance: fbpsg-pa-adj-approved
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("fbpsg-pa-adj-approved")
* insert CommonPropertiesRationale("Facility-Based PSG Prior Authorization Adjudication Approved", "Approved Detail")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyFBPSG"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/fbpsg-pa-adj-approved"

* action[+]
  * title = "Facility-Based PSG Prior Auth Adjudication Approved"
  * description = "Prior authorization adjudication approval for Facility-Based PSG"
  * code = $x12-adjudication-status#A1 "Approved"
  * dynamicValue[+]
    * path = "description" 
    * expression
      * language = #text/cql-identifier
      * expression = "Approved Detail"

Instance: aslp-pa-adj-not-approved
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("aslp-pa-adj-not-approved")
* insert CommonPropertiesRationale("Prior Authorization Adjudication for Sleep Study Not Approved", "Not Approved Detail")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"

* action[+]
  * title = "Not Approved Prior Authorization Adjudication"
  * description = "Prior Authorization Adjudication for Sleep Study Not Approved"
  * code = $x12-adjudication-status#A3 "Denied"
  * dynamicValue[+]
    * path = "description" 
    * expression
      * language = #text/cql-identifier
      * expression = "Not Approved Detail"

Instance: fbpsg-pa-adj-not-approved
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("fbpsg-pa-adj-not-approved")
* insert CommonPropertiesRationale("Facility-Based PSG Prior Authorization Adjudication for Sleep Study Not Approved", "Not Approved Detail")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyFBPSG"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/fbpsg-pa-adj-not-approved"

* action[+]
  * title = "Facility-Based PSG Not Approved Prior Authorization Adjudication"
  * description = "Prior Authorization Adjudication for Facility-Based PSG Not Approved"
  * code = $x12-adjudication-status#A3 "Denied"
  * dynamicValue[+]
    * path = "description" 
    * expression
      * language = #text/cql-identifier
      * expression = "Not Approved Detail"

Instance: aslp-pa-adj-temp-not-approved
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("aslp-pa-adj-temp-not-approved")
* insert CommonPropertiesRationale("Prior Authorization Adjudication for Sleep Study Temporary Not Approved", "Temporarily Not Approved")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"

* action[+]
  * title = "Temporarily Not Approved Prior Authorization Adjudication"
  * description = "Prior Authorization Adjudication for Sleep Study Temporarily Not Approved"
  * code = $x12-adjudication-status#A4 "Pended"
  * dynamicValue[+]
    * path = "description" 
    * expression
      * language = #text/cql-identifier
      * expression = "Temporarily Not Approved"
        
Instance: fbpsg-pa-adj-temp-not-approved
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("fbpsg-pa-adj-temp-not-approved")
* insert CommonPropertiesRationale("Prior Authorization Adjudication for Sleep Study Temporary Not Approved", "Temporarily Not Approved")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyFBPSG"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/fbpsg-pa-adj-temp-not-approved"

* action[+]
  * title = "Facility-Based PSG Temporarily Not Approved Prior Authorization Adjudication"
  * description = "Prior Authorization Adjudication for Facility-Based PSG Temporarily Not Approved"
  * code = $x12-adjudication-status#A4 "Pended"
  * dynamicValue[+]
    * path = "description" 
    * expression
      * language = #text/cql-identifier
      * expression = "Temporarily Not Approved"

//Home/Portable Monitor Sleep Testing to confirm the suspected diagnosis of moderate to severe obstructive sleep apnea (OSA)
Instance: Home-Monitor-Sleep-Testing
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Home-Monitor-Sleep-Testing")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/Home-Monitor-Sleep-Testing"

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
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
  * action[+]
    * title = "Is Qualifying Patient Age"
    * description = "The patient is within the qualifying age"
    * insert ActionConditionCql("Is Qualifying Age")    

  * action[+]
    * title = "Has Excessive daytime sleepiness (EDS)"
    * description = "Patient has excessive daytime sleepiness"
    * input
      * insert ActionInput("Patient has excessive daytime sleepiness?", "Patient has excessive daytime sleepiness")
      * insert ActionInputCql("Qualified Excessive Daytime Sleepiness", ASLPPolicyPAA)
      * type = #Observation
      * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-eds-screening-casefeature"
    * action[0]
      * title = "Does Not Have excessive daytime sleepiness"
      * description = "The patient does not have excessive daytime sleepiness"
      * insert ActionConditionCql("No Excessive Daytime Sleepiness")
      * definitionCanonical = Canonical(aslp-pa-adj-not-approved)
    * action[+]
      * title = "Null or Unknown excessive daytime sleepiness"
      * description = "Unknown answer. More Information is needed"
      * insert ActionConditionCql("Null Excessive Daytime Sleepiness")
      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
    * action[+]
      * title = "Has excessive daytime sleepiness"
      * description = "The patient has excessive daytime sleepiness"
      * insert ActionConditionCql("Has Excessive Daytime Sleepiness")

      * action[+]
        * title = "Additional Daytime Sleepiness Indicator"
        * description = "One or more of the following additional daytime sleepiness indicators: ESS score of 10 or greater, excessive sleepiness while driving, snore loudly/intensely, witnessed nocturnal apnea, choking and/or gasping"
        * input[+]
          * insert ActionInput("Does patient have ESS score >= 10?", "ESS score >= 10")
          * insert ActionInputCql("ESS Score >= 10", ASLPPolicyPAA)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-ess-screening-casefeature"
        * input[+]
          * insert ActionInput("Does patient have excessive sleepiness while driving", "Patient has Excessive sleepiness while driving")
          * insert ActionInputCql("Qualifying Excessive Sleepiness While Driving", ASLPPolicyPAA)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-sleepydriving-screening-casefeature"
        * input[+]
          * insert ActionInput("Does patient snore loudly", "Patient snores loudly")
          * insert ActionInputCql("Loud/Intense Snoring", ASLPPolicyPAA)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-loudsnoring-screening-casefeature"
        * input[+]
          * insert ActionInput("Does patient have nocturnal apnea", "Patient has nocturnal apnea")
          * insert ActionInputCql("Nocturnal Apnea", ASLPPolicyPAA)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-apnea-screening-casefeature"
    
        * action[0]
          * title = "Has none of the additional daytime sleepiness indicators"
          * description = "Patient has none of the following additional daytime sleepiness indicators: ESS score of 10 or greater, excessive sleepiness while driving, snore loudly/intensely, witnessed nocturnal apnea, choking and/or gasping"
          * insert ActionConditionCql("Has No Additional Daytime Sleepiness Indicators")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved" 
        * action[+]
          * title = "Null or Unknown answer"
          * description = "Unknown answer. More Information is needed"
          * insert ActionConditionCql("Null Additional Daytime Sleepiness Indicators")
          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
        * action[+]
          * title = "Has Additional Daytime Sleepiness Indicators"
          * description = "Patient has the following additional daytime sleepiness indicators: ESS score of 10 or greater, excessive sleepiness while driving, snore loudly/intensely, witnessed nocturnal apnea, choking and/or gasping"
          * insert ActionConditionCql("Has Additional Daytime Sleepiness Indicators")


          * action[+]
            * title = "Absence of comorbid medical conditions"
            * description = "Absence of comorbid medical condition(s) that would reduce the accuracy of a home/PM sleep test"
            * input[+]
              * insert ActionInput("Patient has neuromuscular disease with associated pulmonary disease?", "Patient has neuromuscular disease with associated pulmonary disease")
              * insert ActionInputCql("Qualifying Neuromuscular Disease With Associated Pulmonary Disease", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscular-screening-casefeature"
            * input[+]
              * insert ActionInput("Patient has Cardiac Disease?", "Patient has Cardiac Disease")
              * insert ActionInputCql("Qualifying Cardiac Disease", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature"
            * input[+]
              * insert ActionInput("Patient has moderate to severe pulmonary disease?", "Patient has moderate to severe pulmonary disease")
              * insert ActionInputCql("Qualifying Moderate To Severe Pulmonary Disease", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-moderatepulmonary-screening-casefeature"
            
            * action[+]
              * title = "Has Applicable Comorbid Medical Conditions"
              * description = "Patient has one of the following eligible comorbid conditions: Moderate to severe pulmonary disease including COPD or Asthma, Neuromuscular disease with associated pulmonary disease, Cardiac Disease"
              * insert ActionConditionCql("Has Applicable Comorbid Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved" 
            * action[+]
              * title = "Null or Unknown answer"
              * description = "Unknown answer. More Information is needed"
              * insert ActionConditionCql("Null Applicable Comorbid Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
            * action[+]
              * title = "Has no applicable comorbid medical conditions"
              * description = "Has none of the following eligible comorbid conditions: Moderate to severe pulmonary disease including COPD or Asthma, Neuromuscular disease with associated pulmonary disease, Cardiac Disease"
              * insert ActionConditionCql("Has Absence Of Applicable Comorbid Medical Conditions")
              
            
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
                  * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
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
                      * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
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
                          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
                        * action[+]
                          * title = "Able to have physician evaluated results"
                          * description = "The patient is able to have physician evaluate results of home sleep tests"
                          * insert ActionConditionCql("Ability To Have Physician Evaluate Results")
                          * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-approved"
                 
 
  
