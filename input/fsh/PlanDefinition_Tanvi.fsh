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

RuleSet: ActionConditionCql(expression)
* condition
  * kind = #applicability
  * expression
    * language = #text/cql-identifier
    * expression = {expression}



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
        
//Facility-Based-Polysomnogram/Humana members may be eligible under the Plan for a facility-based PSG to confirm the suspected diagnosis of moderate to severe OSA when the following criteria are met
Instance: Facility-Based-Polysomnogram
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Facility-Based-Polysomnogram")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/Facility-Based-Polysomnogram"

* action
  * title = "Qualifying Patient Age"
  * description = "Input for whether the patient is within eligible age bracket."
  * input
    * insert ActionInput("Is patient 18 years or older?", "The patient is 18 years or older")
    * insert ActionInputCql("Qualifying Patient Age", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-patientage"
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
        * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
      * action[+]
        * title = "Null or Unknown excessive daytime sleepiness"
        * description = "Unknown answer. More Information is needed"
        * insert ActionConditionCql("Null Excessive Daytime Sleepiness")
        * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
      * action[+]
        * title = "Has excessive daytime sleepiness"
        * description = "The patient has excessive daytime sleepiness"
        * insert ActionConditionCql("Has Excessive Daytime Sleepiness")
        * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-approved"

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
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-tireddriving-screening-casefeature"
        * input[+]
          * insert ActionInput("Does patient snore loudly", "Patient snores loudly")
          * insert ActionInputCql("Loud/Intense Snoring", ASLPPolicyPAA)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-loudsnoring-screening-casefeature"
        * input[+]
          * insert ActionInput("Does patient have nocturnal apnea", "Patient has nocturnal apnea")
          * insert ActionInputCql("Nocturnal Apnea", ASLPPolicyPAA)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-noctural-apnea-screening-casefeature"
    
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
            * title = "Existence of any of the following indicators/criteria"
            * description = "Patient displays evidence of diagostic testing, planned hypoglossal nerve stimulator (HGNS)implantation/narcolepsy/obsesity/brain injury health history, hypersomnia/ paroxysmal arousal symptoms, lack of cognitive mobility indicators, has a mission critical profession are eligible, pulmonary or neuromuscular / REM sleep disease  under the facility-based PSG plan"
            * input[+]
              * insert ActionInput("Patient has planned a hypoglossal nerve stimulator implantation?", "Patient has an hypoglossal nerve stimulator implantation")
              * insert ActionInputCql("Hypoglossal nerve stimulator", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-hypogloss-implantation-screening"
            * input[+]
              * insert ActionInput("Patient had CSA for 2 months or more?", "Patient had CSA for 2 months or more")
              * insert ActionInputCql("Had CSA for 2>= months", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-CSAhistory-screening"
            * input[+]
              * insert ActionInput("Patient has Narcolepsy along with a planned MSLT test?", "Patient has Narcolepsy along with a planned MSLT test")
              * insert ActionInputCql("Narcolepsy and a planned MSLT test", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-narcolepsy-screening"
            * input[+]
              * insert ActionInput("Patient had Narcolepsy along with a planned MSLT test?", "Patient had Narcolepsy along with a planned MSLT test")
              * insert ActionInputCql("History of narcolepsy and a planned MSLT test", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-narcolepsyhistory-screening"
            * input[+]
              * insert ActionInput("Patient has OHS?", "Patient has OHS")
              * insert ActionInputCql("OHS", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-OHS-screening"
             * input[+]
              * insert ActionInput("Patient had OHS?", "Patient had OHS")
              * insert ActionInputCql("History of OHS", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-OHShistory-screening"          
            * input[+]
              * insert ActionInput("Patient has a brain injury/TBI with EDS?", "Patient has a brain injury/TBI with EDS")
              * insert ActionInputCql("TBI with EDS", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-brain-injury-screening"
            * input[+]
              * insert ActionInput("Patient had a brain injury/TBI with EDS?", "Patient had a brain injury/TBI with EDS")
              * insert ActionInputCql("History of TBI with EDS", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-brain-injury-screening"
            * input[+]
              * insert ActionInput("Patient has idiopathic central nervous system hypersomnia when a MSLT is planned?", "Patient has idiopathic central nervous system hypersomnia long with a planned MSLT test")
              * insert ActionInputCql("Idiopathic central nervous system hypersomnia", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-hypersomnia-screening"
            * input[+]
              * insert ActionInput("Patient/caregiver lacks cognitive dexterity or mobility ability to safely use equipmemt at home?", "Patient/caregiver lacks cognitive dexterity or mobility ability to safely use equipmemt at home")
              * insert ActionInputCql("Cannot use equipment safely at home", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-mobility-screening"
            * input[+]
              * insert ActionInput("Patient has a mission critical profession?", "Patient has a mission critical profession")
              * insert ActionInputCql("Mission critical profession", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-profession-screening"
            * input[+]
              * insert ActionInput("Patient has moderate to severe pulmonary disease including COPD or Asthma?", "Patient has moderate to severe pulmonary disease including COPD or Asthma")
              * insert ActionInputCql("COPD or Asthma", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-pulmonary-copd-asthma-screening"
            * input[+]
              * insert ActionInput("Patient has neuromuscular disease with associated pulmonary disease?", "Patient has neuromuscular disease with associated pulmonary disease")
              * insert ActionInputCql("Neuromuscular disease with associated pulmonary disease", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromusculardisease-screening"
            * input[+]
              * insert ActionInput("Patient have atypical parasomnias because of its duration/frequency/time?", "Patient have atypical parasomnias")
              * insert ActionInputCql("Atypical qualifying parasomnias", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-parasomnias-screening"
            * input[+]
              * insert ActionInput("Patient have paroxysmal arousals and sleep disruptions?", "Patient have paroxysmal arousals and sleep disruptions")
              * insert ActionInputCql("Paroxysmal arousals and sleep disruptions", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-paroxymal-sleep-arousals-screening"
            * input[+]
              * insert ActionInput("Patient have periodic limb movement disorder?", "Patient have periodic limb movement disorder")
              * insert ActionInputCql("Periodic Limb Movement Disorder", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-limb-movement-screening"
            * input[+]
              * insert ActionInput("Patient has Cardiac Disease?", "Patient has Cardiac Disease")
              * insert ActionInputCql("Qualifying Cardiac Disease", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening"

            * action[+]
              * title = "Does not have any of the applicable indicators/criteria"
              * description = "Patient does not have any one of the following eligible comorbid conditions: hypoglossal nerve stimulator (HGNS)implantation/narcolepsy/obsesity/brain injury health history, hypersomnia/ paroxysmal arousal symptoms, lack of cognitive mobility indicators, has a mission critical profession are eligible, pulmonary or neuromuscular / REM sleep disease  under the facility-based PSG plan"
            * insert ActionConditionCql("Does not have Applicable Comorbid Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved" 
            * action[+]
              * title = "Null or Unknown answer"
              * description = "Unknown answer. More Information is needed"
              * insert ActionConditionCql("Null Comorbid Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
            * action[+]
              * title = "Has applicable indicators/criteria"
              * description = "Has one of the following eligible comorbid conditions: hypoglossal nerve stimulator (HGNS)implantation/narcolepsy/obsesity/brain injury health history, hypersomnia/ paroxysmal arousal symptoms, lack of cognitive mobility indicators, has a mission critical profession are eligible, pulmonary or neuromuscular / REM sleep disease  under the facility-based PSG plan"
              * insert ActionConditionCql("Has Applicable Comorbid Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-approved"

              
        