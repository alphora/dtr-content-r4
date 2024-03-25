library ASLPPolicyCaseFeatures

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'

codesystem "ConditionClinicalStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-clinical'
codesystem "ConditionVerificationStatusCodes": 'http://terminology.hl7.org/CodeSystem/condition-ver-status'
codesystem "ObservationStatusCodes": 'http://hl7.org/fhir/observation-status'

code "active": 'active' from "ConditionClinicalStatusCodes"
code "confirmed": 'confirmed' from ConditionVerificationStatusCodes
code "observation-final": 'final' from "ObservationStatusCodes" display 'Final'
code "observation-amended": 'amended' from "ObservationStatusCodes" display 'Amended'
code "observation-corrected": 'corrected' from "ObservationStatusCodes" display 'Corrected'

context Patient
//IMPORTANT NOTE: This was taken from demo-content-r4. May need edits
 
define function ReferenceTo(resource Choice<FHIR.Procedure,FHIR.Observation,FHIR.Organization,FHIR.Coverage,FHIR.Condition,FHIR.Patient,FHIR.DeviceRequest>):
  Reference { reference: string { value: resource.typeof() + '/' + resource.id } }
 
//TODO: flesh out other types of resources
define fluent function typeof(resource Choice<FHIR.Procedure,FHIR.Observation,FHIR.Organization,FHIR.Coverage,FHIR.Condition,FHIR.Patient,FHIR.DeviceRequest>): 
  case
    when resource is Patient then
      'Patient'
    when resource is Condition then  
      'Condition'
    when resource is Observation then  
      'Observation'
    when resource is Procedure then  
      'Procedure'
    when resource is Coverage then  
      'Coverage'
    when resource is Encounter then  
      'Encounter'
    when resource is Organization then  
      'Organization'
    when resource is DeviceRequest then  
      'DeviceRequest'
    else
      Message(null, true, 'FHIRCommon.typeof.UnknownFHIResource', 'Error', 'Unknown resource type: ' + resource.id)
  end

//NOTE: agent is to be set by the service
//Inference resource should be built by CQL.  Need example.
//Application Assertion resource should be built by the application.  Example in test data.

//TODO: need to use a choice for other Observation value types
// consider if using an extension for the evidenceText is correct
// TODO: what should happen when there's no evidence?
define function CaseFeatureObservation(
    code FHIR.CodeableConcept,
    value System.Boolean,
    effective System.DateTime,
    profile System.String, 
    evidences List<Choice<FHIR.Procedure,FHIR.Observation,FHIR.Organization,FHIR.Coverage,FHIR.Condition,FHIR.Patient,FHIR.DeviceRequest>>,
    evidenceText System.String
):
  if code is null or value is null 
    then null as Observation
  else
    if evidences is null 
      then Observation {
        id: id { value: 'cf-' + code.coding[0].code},
        meta: Meta { profile: { canonical { value: profile } } },
        extension: { 
            Extension { 
              url: url { value: 'http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-instantiatesCaseFeature' }, //change this to aslp
              value: uri { value: profile } 
              } 
        },
        code: code,
        effective: dateTime { value: Coalesce(effective, Now()) },
        issued: instant { value: Now()},
        subject: ReferenceTo(Patient),
        status: ObservationStatus { value: 'preliminary' }, //should this be preliminary??
        value: boolean { value: value }
      }
  else
    Observation {
        id: id { value: 'cf-' + First(evidences).id },
        meta: Meta { profile: {canonical { value: profile } } },
        extension: { 
          Extension {
            url: url { value: 'http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-instantiatesCaseFeature' }, //change this to aslp
            value: uri { value: profile }
            }
        },
        contained: {
          CreateProvenence( evidences, evidenceText )
        },
        code: code,
        effective: dateTime { value: Coalesce(effective, Now() ) },
        issued: instant { value: Now() },
        subject: ReferenceTo(Patient),
        status: ObservationStatus { value: 'preliminary' }, //should this be preliminary
        value: boolean { value: value }
    }

define function CreateProvenence( evidences List<Choice<FHIR.Procedure,FHIR.Observation,FHIR.Organization,FHIR.Coverage,FHIR.Condition,FHIR.Patient,FHIR.DeviceRequest>>, evidenceText System.String ):
  Provenance {
    id: id { value: 'prov-' + First(evidences).id },
    extension: { 
      Extension { 
        url: url { 
          value: 'http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-casefeature-evidence-text' 
        }, 
        value: markdown { 
          value: evidenceText 
        } 
      } 
    },
    target: { 
      Reference { reference: string { value: 'Observation/cf-' + First(evidences).id } } 
    },
    occurred: dateTime { value: Now() },
    recorded: instant { value: Now() },
    entity: ((evidences e where e is not null) evidence return 
      FHIR.Provenance.Entity { 
        role: FHIR.ProvenanceEntityRole { value: 'derivation' },
        what: ReferenceTo(evidence)
      })
    // agent: {
    //     FHIR.Provenance.Agent {
    //         who: Reference { reference: string {value: agent }} //Should this be "Humana"? 
    //     }
    // }
  } 

define function CaseFeatureObservation( code FHIR.CodeableConcept, value System.Boolean, profile System.String, evidences List<Choice<FHIR.Procedure,FHIR.Observation,FHIR.Organization,FHIR.Coverage,FHIR.Condition,FHIR.Patient,FHIR.DeviceRequest>>, evidenceText System.String):
  CaseFeatureObservation(code, value, Now(), profile, evidences, evidenceText)

define function CaseFeatureObservation( code FHIR.CodeableConcept, value System.Boolean, profile System.String, evidences Choice<FHIR.Procedure,FHIR.Observation,FHIR.Organization,FHIR.Coverage,FHIR.Condition,FHIR.Patient,FHIR.DeviceRequest>, evidenceText System.String):
  CaseFeatureObservation(code, value, Now(), profile, {evidences}, evidenceText)

define function CaseFeatureObservation( code FHIR.CodeableConcept, value System.Boolean, profile System.String):
  CaseFeatureObservation(code, value, Now(), profile, null as List<FHIR.Observation>, '')

/*
define function CaseFeatureObservation( code FHIR.CodeableConcept, value System.Boolean, profile System.String, evidences List<Choice<FHIR.Procedure,FHIR.Observation,FHIR.Organization,FHIR.Coverage,FHIR.Condition,FHIR.Patient,FHIR.DeviceRequest>>, evidenceText System.String):
  if evidences is FHIR.Procedure
    then CaseFeatureObservation(code, value, Now(), profile, evidences as FHIR.Procedure, evidenceText)
  else if evidence is FHIR.Observation
    then CaseFeatureObservation(code, value, Now(), profile, evidence as FHIR.Observation, evidenceText)
  else if evidence is FHIR.Coverage then
    CaseFeatureObservation(code, value, Now(), profile, evidence as FHIR.Coverage, evidenceText)
  else if evidence is FHIR.Organization then
    CaseFeatureObservation(code, value, Now(), profile, evidence as FHIR.Organization, evidenceText)
  else if evidence is FHIR.Condition then
    CaseFeatureObservation(code, value, Now(), profile, evidence as FHIR.Condition, evidenceText)
  else if evidence is FHIR.Patient then
    CaseFeatureObservation(code, value, Now(), profile, evidence as FHIR.Patient, evidenceText)
  else 
    Message(null, true, 'FHIRCommon.CaseFeatureObservation.UnknownFHIResource', 'Error', 'Unknown Resource Type') //should it be ASLPPOlicyCaseFeatures.CaseFeatureObservation instead of FHIRCommon.CaseFeatureObservation
*/

//TODO: POC only (need to consider all the Observation considerations)
define function MostRecent(value List<FHIR.Observation>):
  First(
    value Observation
      sort by effective descending
  )

//TODO: POC only (need to consider all the Condition considerations)
define function MostRecent(value List<FHIR.Condition>):
  First(
    value Observation
      sort by recordedDate descending
  )

//TODO: POC only (need to consider all the Coverage considerations)
define function MostRecent(value List<FHIR.Coverage>):
  First(
    value Observation
      sort by period.start descending
  )

//TODO: POC only (need to consider all the Procedure considerations)
define function MostRecent(value List<FHIR.Procedure>):
  First(
    value Observation
      sort by performed.start descending
  )

//TODO: POC only (need to consider all the ServiceRequest considerations)
define function MostRecent(value List<FHIR.ServiceRequest>):
  First(
    value Observation
      sort by authoredOn descending
  )

//TODO: POC only (need to consider all the ServiceRequest considerations)
define function MostRecent(value List<FHIR.DeviceRequest>):
  First(
    value Observation
      sort by authoredOn descending
  )

define function CodingEvidence(concept FHIR.CodeableConcept):
  Coalesce(
    'Evidence: coding ' + 
    ShortSystem(First(concept.coding).system) + 
    '-' + First(concept.coding).code + 
    '-' + First(concept.coding).display,
    ' '
  )

define function ShortSystem(system String):
  if LastPositionOf('/', system) > -1 
    then Substring(system, LastPositionOf('/', system) + 1)
  else 
    system

define function ProvenanceAsString(caseFeature DomainResource):
  if not exists(caseFeature.contained)
    then ' (Evidence: user asserted)'
  else 
    ' (' + First((First(caseFeature.contained) as Provenance).extension).value + ')'

//Condition and Observation status fluent functions
define fluent function active(conditions List<FHIR.Condition>):
  conditions C
    where C.clinicalStatus ~ "active"

define fluent function confirmed(conditions List<FHIR.Condition>):
  conditions C
    where C.verificationStatus ~ "confirmed"

define fluent function resulted(observations List<FHIR.Observation>):
  observations observation
    where observation.status ~ "observation-final".code
      or observation.status ~ "observation-amended".code
      or observation.status ~ "observation-corrected".code