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
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscularwithpulmonary-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has Cardiac Disease?", "Patient has Cardiac Disease")
    * insert ActionInputCql("Qualifying Cardiac Disease", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has moderate to severe pulmonary disease?", "Patient has moderate to severe pulmonary disease")
    * insert ActionInputCql("Qualifying Moderate To Severe Pulmonary Disease", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-moderatetoseverepulmonarydisease-screening-casefeature"
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

 

Instance: Facility-Based-Polysomnogram-Questionnaire
InstanceOf: PlanDefinition
Usage: #example
* insert CommonProperties("Facility-Based-Polysomnogram-Questionnaire")

* library = "http://example.org/sdh/dtr/aslp/Library/ASLPPolicyPAA"

* url = "http://example.org/sdh/dtr/aslp/PlanDefinition/Facility-Based-Polysomnogram-Questionnaire"

* action
  * title = "Facility-Based Polysomnogram Questionnaire"
  * description = "Is the patient applicable for facility-based polysomnogram (PSG)?"
  * definitionCanonical = Canonical(Facility-Based-Polysomnogram)  
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
    * insert ActionInput("Patient has diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS\) implantation with a known diagnosis of obstructive sleep apnea (OSA\)?", "Patient has diagnostic testing prior to planned hypoglossal nerve stimulator (HGNS\) implantation with a known diagnosis of obstructive sleep apnea (OSA\)")
    * insert ActionInputCql("Qualifying Diagnostic Testing With Diagnosis of OSA", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-diagnostictesting-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has/had central sleep apnea (CSA\)?", "Patient has/had central sleep apnea (CSA\)")
    * insert ActionInputCql("Qualifying Central Sleep Apnea (CSA\)", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-csa-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has/had narcolespy when a multiple sleep latency test (MSLT\) is/was planned?", "Patient has/had narcolespy when a multiple sleep latency test (MSLT\) is/was planned")
    * insert ActionInputCql("Qualifying Narcolespy", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-featuresassociatedwithnarcolepsy-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has/had obesity hypoventilation syndrome (OHS\) which cannot be attributed to hypothyroidism\, neuromuscular weakness\, pleural pathology\, pulmonary disease\, or skeletal restriction?", "Patient has/had obesity hypoventilation syndrome (OHS\) which cannot be attributed to hypothyroidism\, neuromuscular weakness\, pleural pathology\, pulmonary disease\, or skeletal restriction")
    * insert ActionInputCql("Qualifying Obesity Hypoventilation Syndrome (OHS\)", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-ohs-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has history of traumatic brain injury (TBI\) with EDS?", "Patient has history of traumatic brain injury (TBI\) with EDS")
    * insert ActionInputCql("Qualifying traumatic brain injury (TBI\)", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-tbiwitheds-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has idiopathic central nervous system hyperinsomnia when a multiple sleep latency test (MSLT\) is planned?", "Patient has idiopathic central nervous system hyperinsomnia when a multiple sleep latency test (MSLT\) is planned")
    * insert ActionInputCql("Qualifying idiopathic central nervous system hyperinsomnia", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-idiopathiccnshypersomnia-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient or caregiver lacks cognitive function\, dexterity\, or mobility to use portable monitor (PM\) equipment safely at home?", "Patient or caregiver lacks cognitive function\, dexterity\, or mobility to use portable monitor (PM\) equipment safely at home")
    * insert ActionInputCql("Qualifying cognitive\, dexterity\, or mobility impairment", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-unsafeequipmentuseathome-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has a mission critical profession?", "Patient has a mission critical profession")
    * insert ActionInputCql("Qualifying mission critical profession", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-missioncriticalprofession-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has moderate to severe pulmonary disease including but not limited to chronic obstructive pulmonary disease (COPD\) or nocturnal or uncontrolled asthma?", "Patient has moderate to severe pulmonary disease including but not limited to chronic obstructive pulmonary disease (COPD\) or nocturnal or uncontrolled asthma")
    * insert ActionInputCql("Qualifying pulmonary disease", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-moderatetoseverepulmonarydisease-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has neuromuscular disease with associated pulmonary disease?", "Patient has neuromuscular disease with associated pulmonary disease")
    * insert ActionInputCql("Qualifying neuromuscular disease with associated pulmonary disease", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-neuromuscularwithpulmonary-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has unusual or atypical parasomnias?", "Patient has unusual or atypical parasomnias")
    * insert ActionInputCql("Qualifying parasomnias", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-parasomnia-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has paroxysmal arousals or other sleep disruptions thought to be seizure related?", "Patient has paroxysmal arousals or other sleep disruptions thought to be seizure related")
    * insert ActionInputCql("Qualifying paroxysmal arousals or other sleep disruptions thought to be seizure related", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-paroxysmalarousals-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has periodic limb movement disorder?", "Patient has periodic limb movement disorder")
    * insert ActionInputCql("Qualifying periodic limb movement disorder", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-plmd-screening-casefeature"
  * input[+]
    * insert ActionInput("Patient has cardiac disease including but not limited to pulmonary hypertension or uncontrolled cardiac arrhythmia?", "Patient has cardiac disease including but not limited to pulmonary hypertension or uncontrolled cardiac arrhythmia")
    * insert ActionInputCql("Qualifying cardiac disease", ASLPPolicyPAA)
    * type = #Observation
    * profile = "http://example.org/sdh/dtr/aslp/StructureDefinition/aslp-paa-cardiacdisease-screening-casefeature"