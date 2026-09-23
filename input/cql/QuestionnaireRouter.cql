library QuestionnaireRouter version '0.1.0'

using USCore version '7.0.0'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

valueset "Sleep Study Procedure": 'http://terminology.smilecdr.com/cs/sleepstudy'
valueset "Other Example Procedure": 'http://terminology.smilecdr.com/cs/priorauth'

context Patient

define "CanonicalBase": 'http://example.org/sdh/dtr/aslp'

define function GetAdaptiveQuestionnairePlanDefinition(procedureCode System.Code) 
returns System.String:
    // if (procedureCode in "Sleep Study Procedure") then
    //     "CanonicalBase" + '/PlanDefinition/Home-Monitor-Sleep-Testing-Questionnaire'
    if (
        (procedureCode.system = 'http://www.ama-assn.org/go/cpt' and procedureCode.code in {
            '95800','95801','95803','95805','95806','95807','95808','95810','95811','94762','92520' }
        )
        or (procedureCode.system = 'urn:oid:2.16.840.1.113883.6.285' and procedureCode.code in {
            'E1399','G0398','G0399','G0400' }
        )
        or (procedureCode.system = 'http://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets' and procedureCode.code in {
            'E1399','G0398','G0399','G0400' }
        )
    ) then 
      "CanonicalBase" + '/PlanDefinition/Home-Monitor-Sleep-Testing-Questionnaire'
    // else if (procedureCode in "Other Example Procedure") then
    //     "CanonicalBase" + '/Questionnaire/ASLPA1'
    // else if (procedureCode in "Other Example Procedure") then
    //     "CanonicalBase" + '/PlanDefinition/Home-Monitor-Sleep-Testing'
    else if (
        (procedureCode.system = 'http://www.ama-assn.org/go/cpt' and procedureCode.code in {
            '92015','55250','86999','86849','84591','81001','95805','95811','95803','95807','87299' }
        )
        or (procedureCode.system = 'urn:oid:2.16.840.1.113883.6.285' and procedureCode.code in {
            'C8918','G0398','G0122','G0219','E0601','E1093','E0574','E0430','E0607','E0130','A4253' }
        )
        or (procedureCode.system = 'http://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets' and procedureCode.code in {
            'C8918','G0398','G0122','G0219','E0601','E1093','E0574','E0430','E0607','E0130','A4253' }
        ) 
    ) then 
        "CanonicalBase" + '/PlanDefinition/Home-Monitor-Sleep-Testing'
    else
        null as System.String
        //Message(null, true, 'QuestionnaireRouter.GetAdaptiveQuestionnairePlanDefinition', 'Error', 'Error: Adapative Questionnaire PlanDefinition not found for code ' + procedureCode.code + '. (code=' + procedureCode.code + '; system=' + procedureCode.system + ')')