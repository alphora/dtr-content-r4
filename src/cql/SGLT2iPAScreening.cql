library SGLT2iPAScreening

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include FHIRCommon version '1.1.000' called FC
include SGLT2iPAFHIR called SPF

valueset "Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.12.1001'
valueset "HbA1c": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.11.1024'
valueset "Diabetes Medication": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1190.58'
valueset "eGFR": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.6929.2.1000'
valueset "uACR": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.6929.2.1002'
valueset "Dialysis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.197'
valueset "CKD": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.53'
valueset "ConditionClinical": 'http://terminology.hl7.org/CodeSystem/condition-clinical'

context Patient

/* Inclusion Criteria */
define "Inclusion Criteria":
    SPF."Has Diagnosis of Diabetes"
    and SPF."Has Most Recent A1c > 8"
    and SPF."Has Evidence of CKD"
    // and not "Exclusion Criteria"

define "Is Eligible Summary":
  if "Inclusion Criteria"
    then 'Eligible patient: ' + First(Patient.name).text
        + ': Born ' + ToString(Patient.birthDate)
        + ' (Age: ' + ToString(AgeInYears())
        + '), Gender: ' + Patient.gender
  else null

define "Is Eligible Indicator":
  if "Inclusion Criteria"
    then 'info'
  else null


/* Exclusion Criteria */
define "Exclusion Criteria":
    not SPF."Has Diagnosis of Diabetes"
    or not SPF."Has Most Recent A1c > 8"
    or not SPF."Has Evidence of CKD"

define "Exclusion Summary":
  if "Exclusion Criteria"
    then First(Patient.name).text +
      ': Born ' + ToString(Patient.birthDate) +
      ' (Age: ' + ToString(AgeInYears()) +
      '), Gender: ' + Patient.gender
    else null

define "Exclusion Indicator":
  if "Exclusion Criteria"
    then 'info'
  else null

define "Exclusion Detail":
  if "Exclusion Criteria" then
    'Patient is not currently recommended for SGLT2i medication'
      +
        if (not SPF."Has Diagnosis of Diabetes") then
          ' becauase they do not have a diagnosis of diabetes'
        else if (not SPF."Has Most Recent A1c > 8") then
          ' because they have do not have an A1c or their A1c <= 8'
        else if (not SPF."Has Evidence of CKD") then 
            if (not SPF."Has Two eGFR < 90 With Dates 3 Months Apart" 
                and not SPF."Has eGFR < 90"
                and not SPF."On Dialysis"
            ) then 
                ' because they have do not have an eGFR, their eGFR >= 90, or they are not on dialysis'
            else if (not SPF."Has Two uACR > 30 With Dates 3 Months Apart"
                and not SPF."Has Recent uACR > 30"
                and not SPF."On Dialysis"
            ) then 
                ' because they have do not have an uACR, their uACR <= 30, or they are not on dialysis'
            else
                ' because they do not meet any of the following criteria: 2 eGFR < 90 with dates 3 months apart and 2 uACR > 30 with dates 3 months apart, or diagnosis of CKD, most recent eGFR < 90, and most recent uACR > 30, or they are not on dialysis.'
        else 
          ''
      + '.'
  else null