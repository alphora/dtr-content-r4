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
    * insert ActionConditionCql("Not Within Qualifying Age", ASLPPolicyPAA)
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
  * action[+]
    * title = "Age Unknown"
    * description = "The patient age is unknown. More Information is needed"
    * insert ActionConditionCql("Age Unknown", ASLPPolicyPAA) 
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
  * action[+]
    * title = "Is Qualifying Patient Age"
    * description = "The patient is within the qualifying age"
    * insert ActionConditionCql("Is Qualifying Age", ASLPPolicyPAA)

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
        * definitionCanonical = http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved
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
              * insert ActionInput("Patient has features or clinical history of CSA for 2 months or more?", "Patient has features or clinical history of CSA for 2 months or more)
              * insert ActionInputCql("History of CSA for 2>= months", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-CSA-screening"
            * input[+]
              * insert ActionInput("Patient has features or clinical history of Narcolepsy along with a planned MSLT test?", "Patient has features or clinical history of Narcolepsy along with a planned MSLT test")
              * insert ActionInputCql("History of Narcolepsy and a planned MSLT test", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-narcolepsy-screening"
            * input[+]
              * insert ActionInput("Patient has features or clinical history of OHS?", "Patient has features or clinical history of OHS")
              * insert ActionInputCql("History/clinical features of OHS", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-OHS-screening"
            * input[+]
              * insert ActionInput("Patient has features or clinical history of brain injury/TBI with EDS?", "Patient has features or clinical history of brain injury/TBI with EDS")
              * insert ActionInputCql("History/clinical features of TBI with EDS", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-brain-injury-screening"
            * input[+]
              * insert ActionInput("Patient has idiopathic central nervous system hypersomnia when a MSLT is planned?", "Patient has idiopathic central nervous system hypersomnia long with a planned MSLT test?")
              * insert ActionInputCql("History/clinical features of Idiopathic central nervous system hypersomnia", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-hypersomnia-screening"
            * input[+]
              * insert ActionInput("Patient/caregiver lacks cognitive ,dexterity or mobility ability to safely use equipmemt at home?, "Patient/caregiver" lacks cognitive ,dexterity or mobility ability to safely use equipmemt at home")
              * insert ActionInputCql("Cannot use equipment safely at home", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-mobility-screening"
            * input[+]
              * insert ActionInput("Patient has a mission critical profession?, "Patient has a mission critical profession")
              * insert ActionInputCql("Mission critical profession", ASLPPolicyPAA)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-profession-screening"
            * input[+]
              * insert ActionInput("Patient has moderate to severe pulmonary disease including COPD or Asthma?, "Patient has moderate to severe pulmonary disease including COPD or Asthma")
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

              
          
          




