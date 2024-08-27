Instance: Encounter-FacilityBasedPSG-test-case-1
InstanceOf: Encounter
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-encounter"
* status = #finished
* class = $v3-ActCode#PTNTCARE "Health Care Interaction - Patient Care"
* type = $CPT#99201 "Office or other outpatient visit for the evaluation and management of a new patient, which requires these 3 key components: A problem focused history; A problem focused examination; Straightforward medical decision making. Counseling and/or coordination of care with other physicians, other qualified health care professionals, or agencies are provided consistent with the nature of the problem(s) and the patient's and/or family's needs. Usually, the presenting problem(s) are self limited or minor. Typically, 10 minutes are spent face-to-face with the patient and/or family"
* subject = Reference(Patient/patient-with-EDS-ObesityHypoventilationSyndrome)
* period
  * start = "2023-08-12T15:00:00-07:00"
  * end = "2023-08-12T17:00:00-07:00"