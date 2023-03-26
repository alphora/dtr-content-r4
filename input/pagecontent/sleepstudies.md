### Sleep Studies

### Data Elements

* Eligibility Request Date
* Eligibility Request Time
* NOTE: Assumes contact is the same as the ordering physician, not necessarily the case
* Contact Name (Practitioner.name.where(use = 'usual').select(family & (', ' + given.first())))
* Contact Email (Practitioner.telecom.where(system = 'email').value)
* Contact Phone Number (Practitioner.telecom.where(system = 'phone').value)
* Member Name (Patient.name.where(use = 'usual').select(famiy & (', ' + given.first()))) // Sufficient?
* Member ID Number (Coverage.subscriberId)
* Member DOB (Patient.birthDate)
* Member Contact Number (Patient.telecom.where(system = 'phone').value)
* Group ID (Coverage.class.where(type = "group").value) // NOTE: Need codes for the [Coverage Class Codes ValueSet](http://hl7.org/fhir/valueset-coverage-class.html)
* Ordering Physician Name (Practitioner.name.where(use = 'usual').select(family & (', ' + given.first())))
* Ordering Physician NPI (Practitioner.identifier.where(system = 'http://hl7.org/fhir/sid/us-npi').value
* Ordering Physician Practice Name (Location.name) // NOTE: Need to determine how the location is related here?
* Ordering Physician Address (Practitioner.address.where(use = 'usual')
* Ordering Physician City ''
* Ordering Physician State ''
* Ordering Physician Zip ''
* Ordering Physician Phone (Practitioner.telecom.where(system = 'phone').value)
* Ordering Physician Fax  (Practitioner.telecom.where(system = 'fax').value)
* Ordering Physician Email (Practitioner.telecome.where(system = 'email').value)
* Rendering Facility Name (Location.name)
* Rendering Facility Type (Outpatient, Ambulatory Surgery Center, Inpatient)
* Inpatient Number of Days (duration in days between start of Encounter.period and Coalesce(end of Encounter.period, Today())
* Rendering Facility Address (Location.address.where(use = 'usual')
* Rendering Facility City ''
* Rendering Facility State ''
* Rendering Facility Zip ''
* Rendering Facility Phone (Location.telecom.where(system = 'phone').value)
* Rendering Facility Fax (Location.telecom.where(system = 'fax').value)
* Rendering Facility Email (Location.telecom.where(system = 'email').value)
* Procedure Code (Procedure.code) // NOTE: Define "Sleep Studies" value set to identify codes of potential sleep studies)
* Procedure Date (Procedure.date)
* Diagnosis of Obstructive Sleep Apnea (Condition.code in "Sleep Anea") // NOTE: Define "Sleep Apnea" with at least ICD10#G47.33|Obstructive Sleep Apnea (OSA)
* Other Diagnosis (? How to determine what diagnoses should be included here?)
* Indication (Reason for request): ? Free text?
* History of Hypertension? (Condition.code in "Hypertension")
* History of Diabetes? // (Condition.code in "Diabetes") 
* Neck Circumference (in inches): Observation.value as Quantity // NOTE: LOINC code for Neck Circumference in inches?
* Height (in inches) (Vital Signs Height profile)
* Weight (in pounds) (Vital Signs Weight profile)
* BMI (Vital Signs BMI profile)
* Response Scale (Not Known or N/A, Strongly Disagree (Never), Disagree (< 1/wk), Somewhat Agree (1-2/wk), Agree (3-4/wk), Strongly Agree (5-7/wk)
    * Patient snores in his/her sleep
    * Patient gasps, chokes, and/or stops breathing in his/her sleep
    * Patient snorts in his/her sleep
    * NOTE: Define a response scale with the response scale codes above)
    * NOTE: Define these questions as codes? Are these standard instruments that already have codes?
    * NOTE: (Observation.value as Boolean)

