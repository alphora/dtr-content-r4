Instance: payer-coverage-1
InstanceOf: Coverage
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-coverage"
* identifier
  * system = "http://acme.org/fhir-ns/payer-coverage-identifier-system"
  * value = "12345"
* status = #active
* beneficiary = Reference(Patient/payer-patient-1)
* payor = Reference(Organization/NYS-Medicaid)

Instance: payer-coverage-2
InstanceOf: Coverage
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-coverage"
* identifier
  * system = "http://acme.org/fhir-ns/payer-coverage-identifier-system"
  * value = "23456"
* status = #active
* beneficiary = Reference(Patient/payer-patient-2)
* payor = Reference(Organization/NYS-Medicaid)

Instance: payer-coverage-3
InstanceOf: Coverage
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-coverage"
* identifier
  * system = "http://acme.org/fhir-ns/payer-coverage-identifier-system"
  * value = "34567"
* status = #active
* beneficiary = Reference(Patient/payer-patient-3)
* payor = Reference(Organization/NYS-Medicaid)

Instance: payer-coverage-4
InstanceOf: Coverage
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-coverage"
* identifier
  * system = "http://acme.org/fhir-ns/payer-coverage-identifier-system"
  * value = "45678"
* status = #active
* beneficiary = Reference(Patient/payer-patient-4)
* payor = Reference(Organization/NYS-Medicaid)

Instance: payer-coverage-5
InstanceOf: Coverage
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-coverage"
* identifier
  * system = "http://acme.org/fhir-ns/payer-coverage-identifier-system"
  * value = "56789"
* status = #active
* beneficiary = Reference(Patient/payer-patient-5)
* payor = Reference(Organization/NYS-Medicaid)

Instance: payer-coverage-6
InstanceOf: Coverage
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-coverage"
* identifier
  * system = "http://acme.org/fhir-ns/payer-coverage-identifier-system"
  * value = "90235"
* status = #active
* beneficiary = Reference(Patient/payer-patient-6)
* payor = Reference(Organization/NYS-Medicaid)