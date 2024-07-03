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

 

