Instance: Condition-Snoring-FacilityBasedPSG-test-case-3
InstanceOf: Condition
Usage: #example

* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#problem-list-item "Problem List Item"
* code = $ICD10#I50 "Heart failure"
* subject = Reference(Patient/Patient-heart-failure)
* onsetDateTime = "2023-01-01T17:30:00-07:00"