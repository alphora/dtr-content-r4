library ASLPConcepts version '0.1.0'

using FHIR version '4.0.1'

codesystem "ICD-10": 'http://hl7.org/fhir/sid/icd-10'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "LOINC": 'http://loinc.org'
codesystem "RxNorm": 'http://www.nlm.nih.gov/research/umls/rxnorm'
codesystem "CPT": 'http://www.ama-assn.org/go/cpt'
codesystem "HCPCS": 'http://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets'
codesystem "CIEL": 'http://hl7.org/fhir/sid/ciel'
codesystem "ICD-11": 'http://hl7.org/fhir/sid/icd-11'
codesystem "ICHI": 'https://mitel.dimi.uniud.it/ichi/#http://id.who.int/ichi'
codesystem "ICF": 'http://hl7.org/fhir/sid/icf-nl'
codesystem "NDC": 'http://hl7.org/fhir/sid/ndc'
codesystem "NIDA": 'https://cde.drugabuse.gov'
codesystem "ASLP Codes": 'http://example.org/sdh/dtr/aslp/CodeSystem/aslp-codes'
codesystem "Payor Identifier CodeSystem": 'http://terminology.hl7.org/CodeSystem/organization-type'

valueset "Home Based Testing Sleep Studies Codes": 'http://example.org/sdh/dtr/aslp/ValueSet/aslp-a1-de2'
valueset "Facility Based Testing Sleep Studies Codes": 'http://example.org/sdh/dtr/aslp/ValueSet/aslp-a1-de9'
valueset "Sleep Study Codes Grouper": 'http://example.org/sdh/dtr/aslp/ValueSet/aslp-a1-de1-codes-grouper'
valueset "Diagnosis of Obstructive Sleep Apnea Codes": 'http://example.org/sdh/dtr/aslp/ValueSet/aslp-a1-de17'

code "History of Hypertension": 'ASLP.A1.DE18' from "ASLP Codes" display 'History of Hypertension'
code "History of Diabetes": 'ASLP.A1.DE19' from "ASLP Codes" display 'History of Diabetes'
code "Neck Circumference": 'ASLP.A1.DE23' from "ASLP Codes" display 'Neck Circumference'
code "Height": 'ASLP.A1.DE20' from "ASLP Codes" display 'Body height'
code "Weight": 'ASLP.A1.DE21' from "ASLP Codes" display 'Weight'
code "BMI": 'ASLP.A1.DE22' from "ASLP Codes" display 'BMI'

code "Payor Code": 'pay' from "Payor Identifier CodeSystem" display 'Payor'

context Patient

define function IsPayorResource(resource Resource)
returns System.Boolean:
  TagExists(resource, "Payor Code")

define function TagExists(resource Resource, value System.Code)
returns System.Boolean:
  if (exists(resource.meta.tag.system)) then
    AnyTrue(
      resource.meta.tag Tag
        return 
          if Tag.system.value ~ value.system and Tag.code.value ~ value.code then 
            true 
          else 
            false
    )
  else false