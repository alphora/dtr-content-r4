Instance: Condition-snoring-FacilityBasedPSG-test-case-5
InstanceOf: Condition
Usage: #example

* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#problem-list-item "Problem List Item"
* code = $ICD10#R06.83 "Snoring"
* subject = Reference(Patient/Patient-EDS-Snoring-apnea)
* onsetDateTime = "2023-01-03T11:30:00-07:00"