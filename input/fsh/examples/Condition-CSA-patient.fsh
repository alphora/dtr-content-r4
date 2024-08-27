Instance: Condition-CSA-FacilityBasedPSG-test-case-5
InstanceOf: Condition
Usage: #example

* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#problem-list-item "Problem List Item"
* code = $SCT#724506009 "Central sleep apnea co-occurrent with Cheyne Stokes respiration (disorder)"
* subject = Reference(Patient/Patient-EDS-Snoring-apnea)
* onsetDateTime = "2023-03-01T18:30:00-07:00"