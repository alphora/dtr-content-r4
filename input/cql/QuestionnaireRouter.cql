library QuestionnaireRouter

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include USCoreCommon
include FHIRHelpers version '4.1.000'

valueset "Sleep Study Procedure": 'http://terminology.smilecdr.com/cs/sleepstudy'
valueset "Other Example Procedure": 'http://terminology.smilecdr.com/cs/priorauth'

context Patient

define "CanonicalBase": 'http://example.org/sdh/dtr/aslp'

define function GetAdaptiveQuestionnairePlanDefinition(procedureCode System.Code) 
returns System.String:
    // TODO: create a valueset for sleep study codes to compare to procedureCode
    if (procedureCode in "Sleep Study Procedure") then
        "CanonicalBase" + '/PlanDefinition/Home-Monitor-Sleep-Testing-Questionnaire'
    else if (procedureCode in "Other Example Procedure") then
        "CanonicalBase" + '/Questionnaire/ASLP1'
    else
        //null as System.String
        Message(null, true, 'QuestionnaireRouter.GetAdaptiveQuestionnairePlanDefinition', 'Error', 'Error: Adapative Questionnaire PlanDefinition not found for code ' + procedureCode.code + '. (code=' + procedureCode.code + '; system=' + procedureCode.system + ')')