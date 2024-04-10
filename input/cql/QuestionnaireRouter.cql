library QuestionnaireRouter

using FHIR version '4.0.1'
// TODO: update to use USCore directly
//using USCore version '3.1.1'

include USCoreCommon
include FHIRHelpers version '4.1.000'

context Patient

define function GetAdaptiveQuestionnairePlanDefinition(procedureCode System.Code) 
returns System.String:
    // TODO: create a valueset for sleep study codes to compare to procedureCode
    if (procedureCode.code ~ 'sleep-study-code') then
        'http://example.org/sdh/dtr/aslp/PlanDefinition/Home-Monitor-Sleep-Testing-Questionnaire'
    else
        // TODO: surface an error message here? Or return null? 
        null as System.String