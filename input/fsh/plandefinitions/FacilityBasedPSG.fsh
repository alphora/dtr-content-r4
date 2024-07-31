Instance: Facility-Based-Polysomnogram
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Facility-Based-Polysomnogram")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyFBPSG"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/Facility-Based-Polysomnogram"

* action
  * title = "Qualifying Patient Age"
  * description = "Input for whether the patient is within qualifying age."
  * input
    * insert ActionInput("Is patient 18 years or older?", "The patient is 18 years or older")
    * insert ActionInputCql("Qualifying Patient Age", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-patientage-casefeature-definition"
  * action[0]
    * title = "Is Not Qualifying Patient Age"
    * description = "The patient is not within the qualifying age."
    * insert ActionConditionCql("Not Within Qualifying Age")
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/fbpsg-pa-adj-not-approved"
  * action[+]
    * title = "Age Unknown"
    * description = "The patient age is unknown. More Information is needed"
    * insert ActionConditionCql("Age Unknown") 
    * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/fbpsg-pa-adj-temp-not-approved"
  * action[+]
    * title = "Is Qualifying Patient Age"
    * description = "The patient is within the qualifying age"
    * insert ActionConditionCql("Is Qualifying Age")
  * action[+]
    * title = "Has Excessive daytime sleepiness (EDS)"
    * description = "Patient has excessive daytime sleepiness"
    * input
      * insert ActionInput("Patient has excessive daytime sleepiness?", "Patient has excessive daytime sleepiness")
      * insert ActionInputCql("Qualified Excessive Daytime Sleepiness", ASLPPolicyFBPSG)
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
          * insert ActionInputCql("ESS Score >= 10", ASLPPolicyFBPSG)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-ess-screening-casefeature"
        * input[+]
          * insert ActionInput("Does patient have excessive sleepiness while driving", "Patient has Excessive sleepiness while driving")
          * insert ActionInputCql("Qualifying Excessive Sleepiness While Driving", ASLPPolicyFBPSG)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-sleepydriving-screening-casefeature"
        * input[+]
          * insert ActionInput("Does patient snore loudly", "Patient snores loudly")
          * insert ActionInputCql("Loud/Intense Snoring", ASLPPolicyFBPSG)
          * type = #Observation
          * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-loudsnoring-screening-casefeature"
        * input[+]
          * insert ActionInput("Does patient have nocturnal apnea", "Patient has nocturnal apnea")
          * insert ActionInputCql("Nocturnal Apnea", ASLPPolicyFBPSG)
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
          * description = "Patient has at least one of the following additional daytime sleepiness indicators: ESS score of 10 or greater, excessive sleepiness while driving, snore loudly/intensely, witnessed nocturnal apnea, choking and/or gasping"
          * insert ActionConditionCql("Has Additional Daytime Sleepiness Indicators")

          * action[+]
            * title = "Individual presents"
            * description = "Individual presents with ANY of the following"
            * input[+]
              * insert ActionInput("Patient has undergone diagnostic testing prior to planned hypoglossal nerve stimulator implantation with a known diagnosis of OSA?", "Patient has undergone diagnostic testing prior to planned hypoglossal nerve stimulator implantation with a known diagnosis of OSA")
              * insert ActionInputCql("Diagnostic testing prior to planned HGNS implantation", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-HGNS-screening"
            * input[+]
              * insert ActionInput("Patient history of Central Sleep Apnea(CSA\)?", "Patient history of Central Sleep Apnea(CSA\)")
              * insert ActionInputCql("Qualifying History of Central Sleep Apnea(CSA\)", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-history-CSA-screening"
            * input[+]
              * insert ActionInput("Patient has Central Sleep Apnea(CSA\)?", "Patient has Central Sleep Apnea(CSA\)")
              * insert ActionInputCql("Qualifying Central Sleep Apnea(CSA\)", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-CSA-screening"
            * input[+]
              * insert ActionInput("Patient has narcolepsy when a multiple sleep latency test (MSLT\) is planned?", "Patient has narcolepsy when a multiple sleep latency test (MSLT\) is planned")
              * insert ActionInputCql("Qualifying Narcolespy", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-narcolepsy-screening"
            * input[+]
              * insert ActionInput("Patient had narcolepsy when a multiple sleep latency test (MSLT\) was planned?", "Patient had narcolepsy when a multiple sleep latency test (MSLT\) was planned")
              * insert ActionInputCql("Qualifying History of Narcolespy", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-history-narcolepsy-screening"
            * input[+]
              * insert ActionInput("Patient has obesity hypoventilation syndrome (OHS\) which cannot be attributed to hypothyroidism\, neuromuscular weakness\, pleural pathology\, pulmonary disease\, or skeletal restriction?", "Patient has obesity hypoventilation syndrome (OHS\) which cannot be attributed to hypothyroidism\, neuromuscular weakness\, pleural pathology\, pulmonary disease\, or skeletal restriction")
              * insert ActionInputCql("Qualifying Obesity Hypoventilation Syndrome (OHS\)", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-OHS-screening"
            * input[+]
              * insert ActionInput("Patient had obesity hypoventilation syndrome (OHS\) which cannot be attributed to hypothyroidism\, neuromuscular weakness\, pleural pathology\, pulmonary disease\, or skeletal restriction?", "Patient had obesity hypoventilation syndrome (OHS\) which cannot be attributed to hypothyroidism\, neuromuscular weakness\, pleural pathology\, pulmonary disease\, or skeletal restriction")
              * insert ActionInputCql("Qualifying History of Obesity Hypoventilation Syndrome (OHS\)", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-history-OHS-screening"
            * input[+]
              * insert ActionInput("Patient has history of traumatic brain injury (TBI\) with EDS?", "Patient has history of traumatic brain injury (TBI\) with EDS")
              * insert ActionInputCql("Qualifying traumatic brain injury (TBI\)", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-history-TBI-screening"
            * input[+]
              * insert ActionInput("Patient has idiopathic central nervous system hypersomnia when a multiple sleep latency test (MSLT\) is planned?", "Patient has idiopathic central nervous system hypersomnia when a multiple sleep latency test (MSLT\) is planned")
              * insert ActionInputCql("Qualifying idiopathic central nervous system hypersomnia", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-idiopathic-CNS-hypersomnia-screening"
            * action[+]
              * title = "Can not safely use equipment at home"
              * description = "Individual or caregiver lacks cognitive function, dexterity and mobility to use equipment safely at home"
              * input
                * insert ActionInput("Patient can safely use equipment at home?", "Patient can safely use equipment at home")
                * insert ActionInputCql("Safe Equipment Use At Home", ASLPPolicyFBPSG)
                * type = #Observation
                * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-safehomeuse-screening-casefeature"
              * action[0]
                * title = "Can safely use equipment at home"
                * description = "The patient can safely use equipment at home"
                * insert ActionConditionCql("Can Safely Use Equipment At Home")
                * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved"
              * action[+] 
                * title = "Null or Unknown ability to use equipment at home"
                * description = "Unknown answer. More Information is needed" 
                * insert ActionConditionCql("Unknown Ability To Use Equipment At Home")
                * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
              * action[+]
                * title = "Can not safely use equipment at home"
                * description = "The patient can not safely use equipment at home"
                * insert ActionConditionCql("Can Not Safely Use Equipment At Home")
            * input[+]
              * insert ActionInput("Patient has a mission critical profession?", "Patient has a mission critical profession")
              * insert ActionInputCql("Qualifying mission critical profession", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-mission-critical-profession-screening"
            * input[+]
              * insert ActionInput("Patient has neuromuscular disease with associated pulmonary disease?", "Patient has neuromuscular disease with associated pulmonary disease")
              * insert ActionInputCql("Qualifying Neuromuscular Disease With Associated Pulmonary Disease", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscular-screening-casefeature"
            * input[+]
              * insert ActionInput("Patient has Cardiac Disease?", "Patient has Cardiac Disease")
              * insert ActionInputCql("Qualifying Cardiac Disease", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature"
            * input[+]
              * insert ActionInput("Patient has moderate to severe pulmonary disease?", "Patient has moderate to severe pulmonary disease")
              * insert ActionInputCql("Qualifying Moderate To Severe Pulmonary Disease", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-moderatepulmonary-screening-casefeature"
            * input[+]
              * insert ActionInput("Patient has Parasomnias that are unusual or atypical?", "Patient has Parasomnias that are unusual or atypical")
              * insert ActionInputCql("Qualifying Parasomnias", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-parasomnias-screening"
            * input[+]
              * insert ActionInput("Patient has Paroxysmal arousals or other sleep disruption thought to be seizure related?", "Patient has Paroxysmal arousals or other sleep disruption thought to be seizure related")
              * insert ActionInputCql("Qualifying Paroxysmal arousals or other sleep disruption thought to be seizure related", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-paroxysmal-arousals-screening"
            * input[+]
              * insert ActionInput("Patient has Periodic limb movement disorder?", "Patient has Periodic limb movement disorder")
              * insert ActionInputCql("Qualifying Parasomnias", ASLPPolicyFBPSG)
              * type = #Observation
              * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-periodic-limb-movement-disorder-screening"
            * action[0]
              * title = "Has no applicable medical conditions"
              * description = "Has none of the following eligible conditions: diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS) implantation with a known diagnosis of OSA, central sleep apnea (CSA), narcolespy when a multiple sleep latency test (MSLT) is planned, obesity hypoventilation syndrome (OHS), traumatic brain injury (TBI) with EDS, idiopathic central nervous system hyperinsomnia when a MSLT is planned, individual or caregiver lacks cognitive function, dexterity, or mobility to use portable monitor (PM) equipment safely, has a mission critical profession, moderate to severe pulmonary disease, neuromuscular disease associated with pulmonary disease, unusual or atypical parasomnias, paroxysmal arousals or other sleep disruptions thought to be seizure related, periodic limb movement disorder, and/or cardiac disease" 
              * insert ActionConditionCql("Has No Applicable Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-not-approved" 
            * action[+]
              * title = "Null or Unknown answer"
              * description = "Unknown answer. More Information is needed"
              * insert ActionConditionCql("Null Applicable Medical Conditions")
              * definitionCanonical = "http://example.org/sdh/dtr/aslp/PlanDefinition/aslp-pa-adj-temp-not-approved"
            * action[+]
              * title = "Has Applicable Medical Conditions"
              * description = "Patient has at least one of the following eligible conditions: diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS) implantation with a known diagnosis of OSA, central sleep apnea (CSA), narcolespy when a multiple sleep latency test (MSLT) is planned, obesity hypoventilation syndrome (OHS), traumatic brain injury (TBI) with EDS, idiopathic central nervous system hyperinsomnia when a MSLT is planned, individual or caregiver lacks cognitive function, dexterity, or mobility to use portable monitor (PM) equipment safely, has a mission critical profession, moderate to severe pulmonary disease, neuromuscular disease associated with pulmonary disease, unusual or atypical parasomnias, paroxysmal arousals or other sleep disruptions thought to be seizure related, periodic limb movement disorder, and/or cardiac disease" 
              * insert ActionConditionCql("Has Applicable Medical Conditions")