Instance: Condition-Snoring-FacilityBasedPSG-test-case-1
InstanceOf: Condition
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-encounter"
* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#problem-list-item "Problem List Item"
* code = $ICD10#R06.83 "Snoring"
* subject = Reference(Patient/patient-with-EDS-ObesityHypoventilationSyndrome)
* onsetDateTime = "2023-02-01T11:30:00-07:00"