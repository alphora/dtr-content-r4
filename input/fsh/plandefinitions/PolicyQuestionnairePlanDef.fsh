Instance: Home-Monitor-Sleep-Testing-Questionnaire
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Home-Monitor-Sleep-Testing-Questionnaire")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/Home-Monitor-Sleep-Testing-Questionnaire"

* action
  * title = "Home/Portable Monitor Sleep Testing Questionnaire"
  * description = "Is the patient applicable for home/portable sleep monitor testing"
  * definitionCanonical = Canonical(Home-Monitor-Sleep-Testing)  
  * input[+]
    * insert ActionInput("Is patient 18 years or older?", "The patient is 18 years or older")
    * insert ActionInputCql("Qualifying Patient Age", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-patientage-casefeature-definition"
  * input[+]
    * insert ActionInput("Patient has excessive daytime sleepiness?", "Patient has excessive daytime sleepiness")
    * insert ActionInputCql("Qualified Excessive Daytime Sleepiness", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-eds-screening-casefeature"
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
  * input[+]
    * insert ActionInput("Patient uses a qualified device?", "Patient uses a qualified device")
    * insert ActionInputCql("Uses A Qualified Device", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-qualifieddevice-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient can safely use equipment at home?", "Patient can safely use equipment at home")
    * insert ActionInputCql("Safe Equipment Use At Home", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-safehomeuse-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient can have physician evaluate results?", "Patient can have physician evaluate results")
    * insert ActionInputCql("Physician Evaluated Results", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-physicianevaluated-screening-casefeature"

 
//Facility-Based PSG
Instance: Facility-Based-Polysomnogram-Questionnaire
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Facility-Based-Polysomnogram-Questionnaire")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyFBPSG"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/Facility-Based-Polysomnogram-Questionnaire"

* action
  * title = "Facility-Based Polysomnogram Questionnaire"
  * description = "Is the patient applicable for facility-based polysomnogram (PSG)?"
  * definitionCanonical = Canonical(Facility-Based-Polysomnogram)  
  * input[+]
    * insert ActionInput("Is patient 18 years or older?", "The patient is 18 years or older")
    * insert ActionInputCql("Qualifying Patient Age", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-patientage-casefeature-definition"
  * input[+]
    * insert ActionInput("Patient has excessive daytime sleepiness?", "Patient has excessive daytime sleepiness")
    * insert ActionInputCql("Qualified Excessive Daytime Sleepiness", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-eds-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient have ESS score >= 10?", "ESS score >= 10")
    * insert ActionInputCql("ESS Score >= 10", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-ess-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient have excessive sleepiness while driving?", "Patient has Excessive sleepiness while driving")
    * insert ActionInputCql("Qualifying Excessive Sleepiness While Driving", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-sleepydriving-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient snore loudly?", "Patient snores loudly")
    * insert ActionInputCql("Loud/Intense Snoring", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-loudsnoring-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient have nocturnal apnea?", "Patient has nocturnal apnea")
    * insert ActionInputCql("Nocturnal Apnea", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-apnea-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient had diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS\) implantation with a known diagnosis of obstructive sleep apnea (OSA\)?", "Patient has diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS\) implantation with a known diagnosis of obstructive sleep apnea (OSA\)")
    * insert ActionInputCql("Has Diagnostic Testing Prior to Planned HGNS Implantation With Diagnosis of OSA", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-HGNS-screening"
  * input[+]
    * insert ActionInput("Does patient has/had central sleep apnea (CSA\)?", "Patient has/had central sleep apnea (CSA\)")
    * insert ActionInputCql("Has Central Sleep Apnea", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-HGNS-screening"
  * input[+]
    * insert ActionInput("Does patient has/had narcolepsy when a multiple sleep latency test (MSLT\) is planned?", "Patient has/had narcolepsy when a multiple sleep latency test (MSLT\) is planned")
    * insert ActionInputCql("Has Qualifying Feature Associated With Narcolepsy When MSLT is Planned", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-narcolepsy-screening"
  * input[+]
    * insert ActionInput("Does patient has/had obesity hypoventilation syndrome (OHS\) which cannot be attributed to hypothyroidism\, neuromuscular weakness\, pleural pathology\, pulmonary disease\, or skeletal restriction?", "Patient has/had obesity hypoventilation syndrome (OHS\) which cannot be attributed to hypothyroidism\, neuromuscular weakness\, pleural pathology\, pulmonary disease\, or skeletal restriction")
    * insert ActionInputCql("Has Obesity Hypoventilation Syndrome", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-OHS-screening"
  * input[+]
    * insert ActionInput("Does patient has history of traumatic brain injury (TBI\) with EDS?", "Patient has history of traumatic brain injury (TBI\) with EDS")
    * insert ActionInputCql("Has History of Traumatic Brain Injury with Excessive Daytime Sleepiness", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-history-TBI-screening"
  * input[+]
    * insert ActionInput("Does patient has idiopathic central nervous system hypersomnia when a multiple sleep latency test (MSLT\) is planned?", "Patient has idiopathic central nervous system hypersomnia when a multiple sleep latency test (MSLT\) is planned")
    * insert ActionInputCql("Has Idiopathic Central Nervous System Hypersomnia When MSLT is Planned", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-idiopathic-CNS-hypersomnia-screening"
  * input[+]
    * insert ActionInput("Does patient lacks cognitive function\, dexterity and mobility to use equipment safely at home?", "Patient lacks cognitive function\, dexterity and mobility to use equipment safely at home")
    * insert ActionInputCql("Lacks Cognitive Function\, Dexterity\, or Mobility for Safe Use of Equipment", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-safehomeuse-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient has a mission critical profession?", "Patient has a mission critical profession")
    * insert ActionInputCql("Has Mission Critical Profession", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-mission-critical-profession-screening"
  * input[+]
    * insert ActionInput("Does patient has neuromuscular disease with associated pulmonary disease?", "Patient has neuromuscular disease with associated pulmonary disease")
    * insert ActionInputCql("Has Neuromuscular Disease With Associated Pulmonary Disease", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscular-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient has Cardiac Disease?", "Patient has Cardiac Disease")
    * insert ActionInputCql("Has Cardiac Disease", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient has moderate to severe pulmonary disease?", "Patient has moderate to severe pulmonary disease")
    * insert ActionInputCql("Has Moderate To Severe Pulmonary Disease", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-moderatepulmonary-screening-casefeature"
  * input[+]
    * insert ActionInput("Does patient has Parasomnias that are unusual or atypical?", "Patient has Parasomnias that are unusual or atypical")
    * insert ActionInputCql("Has Parasomnias", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-parasomnias-screening"
  * input[+]
    * insert ActionInput("Does patient has Paroxysmal arousals or other sleep disruption thought to be seizure related?", "Patient has Paroxysmal arousals or other sleep disruption thought to be seizure related")
    * insert ActionInputCql("Has Paroxysmal Arousal or Other Sleep Disruptions Thought to be Seizure Related", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-paroxysmal-arousals-screening"
  * input[+]
    * insert ActionInput("Does patient has Periodic limb movement disorder?", "Patient has Periodic limb movement disorder")
    * insert ActionInputCql("Has Periodic Limb Movement Disorder", ASLPPolicyFBPSG)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/fbpsg-paa-periodic-limb-movement-disorder-screening"