library ASLPPolicyCaseFeatures

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'

context Patient
//IMPORTANT NOTE: This was taken from demo-content-r4. May need edits
 
define function ReferenceTo(resource Resource):
  Reference { reference: string { value: resource.typeof() + '/' + resource.id } }
 
//TODO: flesh out other types of resources
define fluent function typeof(resource Resource): 
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
    evidence FHIR.DomainResource,
    evidenceText System.String
):
  if code is null or value is null 
    then null as Observation
  else
    if evidence is null 
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
        id: id { value: 'cf-' + evidence.id },
        meta: Meta { profile: {canonical { value: profile } } },
        extension: { 
          Extension {
            url: url { value: 'http://hl7.org/fhir/uv/cpg/StructureDefinition/cpg-instantiatesCaseFeature' }, //change this to aslp
            value: uri { value: profile }
            }
        },
        contained: {
          Provenance {
            id: id { value: 'prov-' + evidence.id },
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
              Reference { reference: string { value: 'Observation/cf-' + evidence.id } } 
            },
            occurred: dateTime { value: Now() },
            recorded: instant { value: Now() },
            entity: {
              FHIR.Provenance.Entity { 
                role: FHIR.ProvenanceEntityRole { value: 'derivation' },
                what: ReferenceTo(evidence)
              }
             }
            // agent: {
            //     FHIR.Provenance.Agent {
            //         who: Reference { reference: string {value: agent }} //Should this be "Humana"? 
            //     }
            // }
          } 
        },
        code: code,
        effective: dateTime { value: Coalesce(effective, Now() ) },
        issued: instant { value: Now() },
        subject: ReferenceTo(Patient),
        status: ObservationStatus { value: 'preliminary' }, //should this be preliminary
        value: boolean { value: value }
    }

define function CaseFeatureObservation( code FHIR.CodeableConcept, value System.Boolean, profile System.String, evidence FHIR.DomainResource, evidenceText System.String):
  CaseFeatureObservation(code, value, Now(), profile, evidence, evidenceText)

define function CaseFeatureObservation( code FHIR.CodeableConcept, value System.Boolean, profile System.String, evidence Choice<FHIR.Procedure,FHIR.Observation,FHIR.Organization,FHIR.Coverage,FHIR.Condition,FHIR.Patient>, evidenceText System.String):
  if evidence is FHIR.Procedure
    then CaseFeatureObservation(code, value, Now(), profile, evidence as FHIR.Procedure, evidenceText)
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

