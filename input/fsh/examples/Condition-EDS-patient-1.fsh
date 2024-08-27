Instance: Condition-EDS-FacilityBasedPSG-test-case-1
InstanceOf: Condition
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/qicore/StructureDefinition/qicore-encounter"
* clinicalStatus = $condition-clinical#active "Active"
* verificationStatus = $condition-ver-status#confirmed "Confirmed"
* category = $condition-category#encounter-diagnosis "Encounter Diagnosis"
* code = $SCT#194439006 "Disorder of excessive somnolence (disorder)"
* subject = Reference(Patient/patient-with-EDS-ObesityHypoventilationSyndrome)
* encounter = Reference(Encounter/Encounter-FacilityBasedPSG-test-case-1)
* onsetDateTime = "2023-01-12T16:30:00-07:00"