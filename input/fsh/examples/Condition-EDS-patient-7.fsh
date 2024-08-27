Instance: Condition-EDS-FacilityBasedPSG-test-case-7
InstanceOf: Condition
Usage: #example

* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#problem-list-item "Problem List Item"
* code = $SCT#141000119100 "Daytime somnolence (finding)"
* subject = Reference(Patient/EDS-apnea-pulmonary)
* onsetDateTime = "2023-03-12T17:30:00-07:00"