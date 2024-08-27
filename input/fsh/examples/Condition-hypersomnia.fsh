Instance: Condition-hypersomnia-FacilityBasedPSG-test-case-6
InstanceOf: Condition
Usage: #example

* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#problem-list-item "Problem List Item"
* code = $SCT#44241600 "Idiopathic hypersomnia associated with long sleep time (disorder)"
* subject = Reference(Patient/EDS-hypersomnia)
* onsetDateTime = "2023-02-01T18:30:00-07:00"