Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $v3-MaritalStatus = http://terminology.hl7.org/CodeSystem/v3-MaritalStatus
Alias: $org-type = http://terminology.hl7.org/CodeSystem/organization-type

Instance: payer-patient-1
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#pay
* identifier[+].system = "https://prior-auth.org/fhir/memberidentifier"
* identifier[=].value = "N0000017"
* identifier[+].type = $v2-0203#MR "Medical Record Number"
* identifier[=].type.text = "Medical Record Number"
* identifier[=].system = "http://hospital.smarthealthit.org"
* identifier[=].value = "7d91ca3c-9fa8-63c5-94af-3894d1b023b6"
* identifier[+].type = $v2-0203#SS "Social Security Number"
* identifier[=].type.text = "Social Security Number"
* identifier[=].system = "http://hl7.org/fhir/sid/us-ssn"
* identifier[=].value = "999-70-4335"
* identifier[+].type = $v2-0203#DL "Driver's License"
* identifier[=].type.text = "Driver's License"
* identifier[=].system = "urn:oid:2.16.840.1.113883.4.3.25"
* identifier[=].value = "S99927507"
* identifier[+].type = $v2-0203#PPN "Passport Number"
* identifier[=].type.text = "Passport Number"
* identifier[=].system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
* identifier[=].value = "X68615393X"
* telecom.system = #phone
* telecom.value = "555-203-6945"
* telecom.use = #home
* active = true
* name.use = #official
* name.text = "The Donald"
* name.family = "Trump"
* name.given = "Donald"
* gender = #male
* birthDate = "1938-04-30"

* address.line = "375 VonRueden Underpass Apt 19"
* address.city = "Carver"
* address.state = "MA"
* address.postalCode = "00000"
* address.country = "US"
* maritalStatus = $v3-MaritalStatus#S "Never Married"
* communication.language = urn:ietf:bcp:47#en-US "English"


Instance: payer-patient-2
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#pay
* identifier[0].system = "https://github.com/synthetichealth/synthea"
* identifier[=].value = "85e086aa-c117-6cbf-e2b4-4a9e621a73c1"
* identifier[+].system = "https://prior-auth.org/fhir/memberidentifier"
* identifier[=].value = "N0000016"
* identifier[+].type = $v2-0203#MR "Medical Record Number"
* identifier[=].type.text = "Medical Record Number"
* identifier[=].system = "http://hospital.smarthealthit.org"
* identifier[=].value = "85e086aa-c117-6cbf-e2b4-4a9e621a73c1"
* identifier[+].type = $v2-0203#SS "Social Security Number"
* identifier[=].type.text = "Social Security Number"
* identifier[=].system = "http://hl7.org/fhir/sid/us-ssn"
* identifier[=].value = "999-34-8854"
* name.use = #official
* name.family = "Homenick"
* name.given[0] = "Dianna"
* name.given[+] = "Kiersten"
* telecom.system = #phone
* telecom.value = "555-968-1946"
* telecom.use = #home
* gender = #female
* birthDate = "2007-03-31"

* address.line = "607 Boyle Plaza Apt 43"
* address.city = "North Brookfield"
* address.state = "MA"
* address.postalCode = "01535"
* address.country = "US"
* maritalStatus = $v3-MaritalStatus#S "Never Married"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: payer-patient-3
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#pay
* identifier[0].system = "https://github.com/synthetichealth/synthea"
* identifier[=].value = "a470aa8e-2e18-8e33-f524-382b9fc6eb49"
* identifier[+].system = "https://prior-auth.org/fhir/memberidentifier"
* identifier[=].value = "N0000018"
* identifier[+].type = $v2-0203#MR "Medical Record Number"
* identifier[=].type.text = "Medical Record Number"
* identifier[=].system = "http://hospital.smarthealthit.org"
* identifier[=].value = "a470aa8e-2e18-8e33-f524-382b9fc6eb49"
* identifier[+].type = $v2-0203#SS "Social Security Number"
* identifier[=].type.text = "Social Security Number"
* identifier[=].system = "http://hl7.org/fhir/sid/us-ssn"
* identifier[=].value = "999-36-4256"
* identifier[+].type = $v2-0203#DL "Driver's License"
* identifier[=].type.text = "Driver's License"
* identifier[=].system = "urn:oid:2.16.840.1.113883.4.3.25"
* identifier[=].value = "S99995156"
* identifier[+].type = $v2-0203#PPN "Passport Number"
* identifier[=].type.text = "Passport Number"
* identifier[=].system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
* identifier[=].value = "X55672745X"
* name[0].use = #official
* name[=].family = "Vandervort"
* name[=].given[0] = "Georgette"
* name[=].given[+] = "Tawanda"
* name[=].prefix = "Mrs."
* name[+].use = #maiden
* name[=].family = "Shields"
* name[=].given[0] = "Georgette"
* name[=].given[+] = "Tawanda"
* name[=].prefix = "Mrs."
* telecom.system = #phone
* telecom.value = "555-262-3852"
* telecom.use = #home
* gender = #female
* birthDate = "1994-11-06"

* address.line = "963 Kihn Orchard Suite 15"
* address.city = "Wilmington"
* address.state = "MA"
* address.postalCode = "01887"
* address.country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"

* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: payer-patient-4
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#pay
* identifier[0].system = "https://github.com/synthetichealth/synthea"
* identifier[=].value = "92b4ad87-92b9-4cac-7a36-6c9e12e09f69"
* identifier[+].system = "https://prior-auth.org/fhir/memberidentifier"
* identifier[=].value = "N0000019"
* identifier[+].type = $v2-0203#MR "Medical Record Number"
* identifier[=].type.text = "Medical Record Number"
* identifier[=].system = "http://hospital.smarthealthit.org"
* identifier[=].value = "92b4ad87-92b9-4cac-7a36-6c9e12e09f69"
* identifier[+].type = $v2-0203#SS "Social Security Number"
* identifier[=].type.text = "Social Security Number"
* identifier[=].system = "http://hl7.org/fhir/sid/us-ssn"
* identifier[=].value = "999-53-5472"
* identifier[+].type = $v2-0203#DL "Driver's License"
* identifier[=].type.text = "Driver's License"
* identifier[=].system = "urn:oid:2.16.840.1.113883.4.3.25"
* identifier[=].value = "S99921702"
* identifier[+].type = $v2-0203#PPN "Passport Number"
* identifier[=].type.text = "Passport Number"
* identifier[=].system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
* identifier[=].value = "X8255641X"
* name.use = #official
* name.family = "Murazik"
* name.given[0] = "Calvin"
* name.given[+] = "Jason"
* name.prefix = "Mr."
* telecom.system = #phone
* telecom.value = "555-783-7609"
* telecom.use = #home
* gender = #male
* birthDate = "1965-11-26"

* address.line = "546 Dibbert Vale Suite 25"
* address.city = "Amherst"
* address.state = "MA"
* address.postalCode = "00000"
* address.country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: payer-patient-5
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#pay
* identifier[+].system = "https://prior-auth.org/fhir/memberidentifier"
* identifier[=].value = "N0000020"
* identifier[+].type = $v2-0203#MR "Medical Record Number"
* identifier[=].type.text = "Medical Record Number"
* identifier[=].system = "http://hospital.smarthealthit.org"
* identifier[=].value = "c547ca48-bb2c-8ac1-3385-901b5e9f51c0"
* identifier[+].type = $v2-0203#SS "Social Security Number"
* identifier[=].type.text = "Social Security Number"
* identifier[=].system = "http://hl7.org/fhir/sid/us-ssn"
* identifier[=].value = "999-85-5286"
* identifier[+].type = $v2-0203#DL "Driver's License"
* identifier[=].type.text = "Driver's License"
* identifier[=].system = "urn:oid:2.16.840.1.113883.4.3.25"
* identifier[=].value = "S99919616"
* identifier[+].type = $v2-0203#PPN "Passport Number"
* identifier[=].type.text = "Passport Number"
* identifier[=].system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
* identifier[=].value = "X67830063X"
* name[0].use = #official
* name[=].family = "Hermiston"
* name[=].given[0] = "Letty"
* name[=].given[+] = "Kelle"
* name[=].prefix = "Mrs."
* name[+].use = #maiden
* name[=].family = "Reynolds"
* name[=].given[0] = "Letty"
* name[=].given[+] = "Kelle"
* name[=].prefix = "Mrs."
* telecom.system = #phone
* telecom.value = "555-316-5593"
* telecom.use = #home
* gender = #female
* birthDate = "1989-03-22"

* address.line = "231 Kutch Village Apt 76"
* address.city = "Wakefield"
* address.state = "MA"
* address.postalCode = "01880"
* address.country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#zh "Chinese"


Instance: payer-patient-6
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#pay
* identifier[+].system = "https://prior-auth.org/fhir/memberidentifier"
* identifier[=].value = "N0000220"
* identifier[+].type = $v2-0203#MR "Medical Record Number"
* identifier[=].type.text = "Medical Record Number"
* identifier[=].system = "http://hospital.smarthealthit.org"
* identifier[=].value = "c547ca48-bb2c-8ac1-3385-901b5e9f22c0"
* identifier[+].type = $v2-0203#SS "Social Security Number"
* identifier[=].type.text = "Social Security Number"
* identifier[=].system = "http://hl7.org/fhir/sid/us-ssn"
* identifier[=].value = "999-85-5281"
* identifier[+].type = $v2-0203#DL "Driver's License"
* identifier[=].type.text = "Driver's License"
* identifier[=].system = "urn:oid:2.16.840.1.113883.4.3.25"
* identifier[=].value = "S99919716"
* identifier[+].type = $v2-0203#PPN "Passport Number"
* identifier[=].type.text = "Passport Number"
* identifier[=].system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
* identifier[=].value = "X67831063X"
* name[0].use = #official
* name[=].family = "DOE"
* name[=].given[0] = "TEST"
* name[=].given[+] = "USER"
* name[=].prefix = "Mrs."
* name[+].use = #maiden
* name[=].family = "DOE1"
* name[=].given[0] = "TEST1"
* name[=].given[+] = "USER1"
* name[=].prefix = "Mrs."
* telecom.system = #phone
* telecom.value = "555-316-5593"
* telecom.use = #home
* gender = #male
* birthDate = "1967-03-21"

* address.line = "231 Kutch Village Apt 76"
* address.city = "Wakefield"
* address.state = "MA"
* address.postalCode = "01880"
* address.country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#zh "Chinese"