Instance: Condition-apnea-FacilityBasedPSG-test-case-7
InstanceOf: Condition
Usage: #example

* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#problem-list-item "Problem List Item"
* code = $SCT#230493001 "Mixed sleep apnea (disorder)"
* subject = Reference(Patient/EDS-apnea-pulmonary)
* onsetDateTime = "2023-02-20T18:30:00-07:00"