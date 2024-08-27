Instance: Condition-EDS-FacilityBasedPSG-test-case-5
InstanceOf: Condition
Usage: #example

* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#problem-list-item "Problem List Item"
* code = $SCT#370971007 "Somnolence syndrome (disorder)"
* subject = Reference(Patient/Patient-EDS-Snoring-apnea)
* onsetDateTime = "2023-02-02T17:30:00-07:00"