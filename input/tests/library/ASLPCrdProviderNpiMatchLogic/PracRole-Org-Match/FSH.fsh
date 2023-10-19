Alias: $organization-type = http://terminology.hl7.org/CodeSystem/organization-type
Alias: $v3-ActCode = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $subscriber-relationship = http://terminology.hl7.org/CodeSystem/subscriber-relationship
Alias: $coverage-class = http://terminology.hl7.org/CodeSystem/coverage-class
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $v3-MaritalStatus = http://terminology.hl7.org/CodeSystem/v3-MaritalStatus
Alias: $v3-ParticipationFunction = http://terminology.hl7.org/CodeSystem/v3-ParticipationFunction
Alias: $practitioner-role = http://terminology.hl7.org/CodeSystem/practitioner-role
Alias: $v3-RoleCode = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $cpt = http://www.ama-assn.org/go/cpt

Instance: Payor-Coverage-PracRole-Org-Match
InstanceOf: Coverage
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-coverage"
* meta.tag = $organization-type#pay "Payor"
* status = #active
* identifier.system = "http://acme.org/fhir-ns/payor-coverage-identifier-system"
* identifier.value = "1213"
* type = $v3-ActCode#EHCPOL "Extended Healthcare"
* subscriber = Reference(RelatedPerson/Payor-Patient-PracRole-Org-Match)
* subscriberId = "Provider-Patient-PracRole-Org-Mismatch"
* beneficiary = Reference(Provider-Patient-PracRole-Org-Match)
* relationship = $subscriber-relationship#self "Self"
* payor = Reference(Organization/Payor-Insurance-PracRole-Org-Match)
* class.type = $coverage-class#plan "Plan"
* class.value = "IP"
* class.name = "Insurance Plan"

Instance: Provider-Coverage-PracRole-Org-Match
InstanceOf: Coverage
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-coverage"
* meta.tag = $organization-type#prov "Provider"
* status = #active
* identifier.system = "http://acme.org/fhir-ns/payor-coverage-identifier-system"
* identifier.value = "1213"
* type = $v3-ActCode#EHCPOL "Extended Healthcare"
* subscriber = Reference(Payor-Patient-PracRole-Org-Match)
* subscriberId = "Provider-Patient-PracRole-Org-Match"
* beneficiary = Reference(Patient/Provider-Patient-PracRole-Org-Match)
* relationship = $subscriber-relationship#self "Self"
* payor = Reference(Payor-Insurance-PracRole-Org-Match)
* class.type = $coverage-class#plan "Plan"
* class.value = "IP"
* class.name = "Insurance Plan"

Instance: Payor-Insurance-PracRole-Org-Match
InstanceOf: Organization
Usage: #example
* meta.tag = $organization-type#pay "Payor"
* active = true
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "0192837465"
* name = "Best Insurance Co."
* alias = "BestI"
* telecom.use = #work
* telecom.system = #phone
* telecom.value = "212 555 0010"
* address.use = #work
* address.line = "1 Insured Rd."
* address.city = "New York"
* address.state = "NY"
* address.postalCode = "10002"
* address.period.start = "1901-01-01"

Instance: Provider-Insurance-PracRole-Org-Match
InstanceOf: Organization
Usage: #example
* meta.tag = $organization-type#prov "Provider"
* active = true
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "0192837465"
* name = "Best Insurance Co."
* alias = "BestI"
* telecom.use = #work
* telecom.system = #phone
* telecom.value = "212 555 0010"
* address.use = #work
* address.line = "1 Insured Rd."
* address.city = "New York"
* address.state = "NY"
* address.postalCode = "10002"
* address.period.start = "1901-01-01"

Instance: Provider-Patient-PracRole-Org-Match
InstanceOf: Patient
Usage: #example
* identifier.use = #usual
* identifier.type = $v2-0203#MR "Medical Record Number"
* identifier.system = "urn:oid:1.2.36.146.595.217.0.1"
* identifier.value = "5559991"
* identifier.period.start = "2010-06-15"
* identifier.assigner.display = "Acme Healthcare"
* active = true
* name.use = #official
* name.family = "McDonald"
* name.given = "Ronald"
* telecom.system = #phone
* telecom.value = "415 321 9817"
* telecom.use = #mobile
* address.use = #home
* address.type = #both
* address.line = "17 Home Lane"
* address.city = "San Francisco"
* address.state = "Ca"
* address.postalCode = "94016"
* address.period.start = "2010-04-01"
* deceasedBoolean = false
* birthDate = "1963-09-18"
* maritalStatus = $v3-MaritalStatus#U
* gender.extension.url = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex"
* gender.extension.valueCode = #m

Instance: Payor-Practitioner-PracRole-Org-Match-1
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner"
* meta.tag = $organization-type#pay "Payor"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "123987654"
* name.family = "Graham"
* name.given = "Audrey"
* name.prefix = "DR."
* telecom.system = #phone
* telecom.value = "901-321-7654"
* address.use = #work
* address.line = "20 Degrassi st"
* address.city = "Memphis"
* address.state = "TN"
* address.postalCode = "37501"
* address.period.start = "2011-06-01"
* gender = #female
* birthDate = "1986-10-24"
* active = true

Instance: Payor-Practitioner-PracRole-Org-Match-2
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner"
* meta.tag = $organization-type#pay "Payor"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "0987654321"
* name.family = "Pine"
* name.given = "Chris"
* name.prefix = "DR."
* telecom.system = #phone
* telecom.value = "415-321-9817"
* address.use = #work
* address.line = "10 Health av"
* address.city = "San Francisco"
* address.state = "CA"
* address.postalCode = "94118"
* address.period.start = "2009-09-09"
* gender = #male
* birthDate = "1972-08-24"
* active = true

Instance: Provider-Practitioner-PracRole-Org-Match-1
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner"
* meta.tag = $organization-type#prov "Provider"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "123987654"
* name.family = "Graham"
* name.given = "Audrey"
* name.prefix = "DR."
* telecom.system = #phone
* telecom.value = "901-321-7654"
* address.use = #work
* address.line = "20 Degrassi st"
* address.city = "Memphis"
* address.state = "TN"
* address.postalCode = "37501"
* address.period.start = "2011-06-01"
* gender = #female
* birthDate = "1986-10-24"
* active = true

Instance: Provider-Practitioner-PracRole-Org-Match-2
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner"
* meta.tag = $organization-type#prov "Provider"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "0987654321"
* name.family = "Pine"
* name.given = "Chris"
* name.prefix = "DR."
* telecom.system = #phone
* telecom.value = "415-321-9817"
* address.use = #work
* address.line = "10 Health av"
* address.city = "San Francisco"
* address.state = "CA"
* address.postalCode = "94118"
* address.period.start = "2009-09-09"
* gender = #male
* birthDate = "1972-08-24"
* active = true

Instance: Payor-Ordering-Practitioner-PracRole-Org-Match-1
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole"
* meta.tag = $organization-type#pay "Payor"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "123987654"
* active = true
* code = $v3-ParticipationFunction#PCP "Primary Care Physician"
* specialty = $practitioner-role#doctor "Doctor"
* period.start = "2011-06-01"
* period.end = "2051-06-01"
* telecom.system = #phone
* telecom.value = "901-321-7654"
* organization = Reference(Payor-Insurance-PracRole-Org-Match)
* practitioner = Reference(Payor-Practitioner-PracRole-Org-Match-1) "Dr. Audrey Graham"

Instance: Payor-Ordering-Practitioner-PracRole-Org-Match-2
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole"
* meta.tag = $organization-type#pay "Payor"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "0987654321"
* active = true
* code = $v3-ParticipationFunction#PCP "Primary Care Physician"
* specialty = $practitioner-role#doctor "Doctor"
* period.start = "2009-09-09"
* period.end = "2040-01-01"
* telecom.system = #phone
* telecom.value = "415-830-2461"
* organization = Reference(Payor-Insurance-PracRole-Org-Match)
* practitioner = Reference(Payor-Practitioner-PracRole-Org-Match-2) "Dr. Chris Pine"

Instance: Payor-Requesting-Practitioner-PracRole-Org-Match-1
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole"
* meta.tag = $organization-type#pay "Payor"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "123987654"
* active = true
* code = $v3-ParticipationFunction#PCP "Primary Care Physician"
* specialty = $practitioner-role#doctor "Doctor"
* period.start = "2011-06-01"
* period.end = "2051-06-01"
* telecom.system = #phone
* telecom.value = "901-321-7654"
* organization = Reference(Organization/payor-Insurance-PracRole-Org-Match)
* practitioner = Reference(Practitioner/payor-Practitioner-PracRole-Org-Match-1) "Dr. Audrey Graham"

Instance: Payor-Requesting-Practitioner-PracRole-Org-Match-2
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole"
* meta.tag = $organization-type#pay "Payor"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "0987654321"
* active = true
* code = $v3-ParticipationFunction#PCP "Primary Care Physician"
* specialty = $practitioner-role#doctor "Doctor"
* period.start = "2009-09-09"
* period.end = "2040-01-01"
* telecom.system = #phone
* telecom.value = "415-830-2461"
* organization = Reference(Organization/payor-Insurance-PracRole-Org-Match)
* practitioner = Reference(Provider-Practitioner-PracRole-Org-Match-2) "Dr. Chris Pine"

Instance: Provider-Ordering-Practitioner-PracRole-Org-Match-1
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole"
* meta.tag = $organization-type#prov "Provider"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "123987654"
* active = true
* code = $v3-ParticipationFunction#PCP "Primary Care Physician"
* specialty = $practitioner-role#doctor "Doctor"
* period.start = "2011-06-01"
* period.end = "2051-06-01"
* telecom.system = #phone
* telecom.value = "901-321-7654"
* organization = Reference(Provider-Insurance-PracRole-Org-Match)
* practitioner = Reference(Provider-Practitioner-PracRole-Org-Match-1) "Dr. Audrey Graham"

Instance: Provider-Ordering-Practitioner-PracRole-Org-Match-2
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole"
* meta.tag = $organization-type#prov "Provider"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "0987654321"
* active = true
* code = $v3-ParticipationFunction#PCP "Primary Care Physician"
* specialty = $practitioner-role#doctor "Doctor"
* period.start = "2009-09-09"
* period.end = "2040-01-01"
* telecom.system = #phone
* telecom.value = "415-830-2461"
* organization = Reference(Provider-Insurance-PracRole-Org-Match)
* practitioner = Reference(Provider-Practitioner-PracRole-Org-Match-2) "Dr. Chris Pine"

Instance: Provider-Requesting-Practitioner-PracRole-Org-Match-1
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole"
* meta.tag = $organization-type#prov "Provider"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "123987654"
* active = true
* code = $v3-ParticipationFunction#PCP "Primary Care Physician"
* specialty = $practitioner-role#doctor "Doctor"
* period.start = "2011-06-01"
* period.end = "2051-06-01"
* telecom.system = #phone
* telecom.value = "901-321-7654"
* organization = Reference(Provider-Insurance-PracRole-Org-Match)
* practitioner = Reference(Provider-Practitioner-PracRole-Org-Match-1) "Dr. Audrey Graham"

Instance: Provider-Requesting-Practitioner-PracRole-Org-Match-2
InstanceOf: PractitionerRole
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole"
* meta.tag = $organization-type#prov "Provider"
* identifier.system = "http://hl7.org/fhir/sid/us-npi"
* identifier.value = "0987654321"
* active = true
* code = $v3-ParticipationFunction#PCP "Primary Care Physician"
* specialty = $practitioner-role#doctor "Doctor"
* period.start = "2009-09-09"
* period.end = "2040-01-01"
* telecom.system = #phone
* telecom.value = "415-830-2461"
* organization = Reference(Provider-Insurance-PracRole-Org-Match)
* practitioner = Reference(Provider-Practitioner-PracRole-Org-Match-2) "Dr. Chris Pine"

Instance: Payor-Patient-PracRole-Org-Match
InstanceOf: RelatedPerson
Usage: #example
* meta.tag = $organization-type#pay "Payor"
* active = true
* identifier.use = #usual
* identifier.type = $v2-0203#MR "Medical Record Number"
* identifier.system = "urn:oid:1.2.36.146.595.217.0.1"
* identifier.value = "5559991"
* identifier.assigner.display = "Acme Healthcare"
* patient = Reference(Patient/Provider-Patient-PracRole-Org-Match)
* relationship = $v3-RoleCode#oneself "Self"
* name.use = #official
* name.family = "Mcdonald"
* name.given = "Ronald"
* telecom.system = #phone
* telecom.value = "415 555 9817"
* telecom.use = #mobile
* birthDate = "1963-09-18"

Instance: PracRole-Org-Match-SleepStudy
InstanceOf: ServiceRequest
Usage: #example
* status = #draft
* intent = #order
* code = $cpt#93010 "ELECTROCARDIOGRAM REPORT"
* code.text = "ELECTROCARDIOGRAM REPORT"
* subject = Reference(Patient/Provider-Patient-PracRole-Org-Match)
* authoredOn = "2023-03-23"
* reasonReference = Reference(Condition/Sleep-Apnea-PracRole-Org-Match)
* requester = Reference(Practitioner/Provider-Ordering-Practitioner-PracRole-Org-Match-1)
* performer = Reference(Practitioner/Provider-Requesting-Practitioner-PracRole-Org-Match-2)
* occurrenceDateTime = "2023-08-12T10:10:10-01:00"