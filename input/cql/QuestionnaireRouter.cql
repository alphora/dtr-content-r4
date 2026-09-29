library QuestionnaireRouter

using FHIR version '4.0.1'

//valueset "Diabetes Procedure": 'http://terminology.smilecdr.com/cs/diabetes'

context Patient

define "CanonicalBase": 'http://example.org/sdh/demo/sglt2i'

define function GetAdaptiveQuestionnairePlanDefinition(procedureCode System.Code) 
returns System.String:
    //if (procedureCode in "Diabetes Procedure") then
    if (true) then
        "CanonicalBase" + '/Questionnaire/SGLT2i-PA-PlanDefinition'
    else
        null as System.String
        //Message(null, true, 'QuestionnaireRouter.GetAdaptiveQuestionnairePlanDefinition', 'Error', 'Error: Adapative Questionnaire PlanDefinition not found for code ' + procedureCode.code + '. (code=' + procedureCode.code + '; system=' + procedureCode.system + ')')