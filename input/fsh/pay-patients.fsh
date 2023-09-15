Alias: $organization-type = http://terminology.hl7.org/CodeSystem/organization-type
Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $v3-MaritalStatus = http://terminology.hl7.org/CodeSystem/v3-MaritalStatus

Instance: payer-patient-1
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $organization-type#pay
* identifier[0]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000017"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "7d91ca3c-9fa8-63c5-94af-3894d1b023b6"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-70-4335"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99927507"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X68615393X"
* telecom
  * system = #phone
  * value = "555-203-6945"
  * use = #home
* active = true
* name
  * use = #official
  * text = "The Donald"
  * family = "Trump"
  * given = "Donald"
* gender = #male
* birthDate = "1938-04-30"
* address
  * line = "375 VonRueden Underpass Apt 19"
  * city = "Carver"
  * state = "MA"
  * postalCode = "00000"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#S "Never Married"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: payer-patient-2
InstanceOf: USCorePatientProfile
Usage: #example
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000016"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "85e086aa-c117-6cbf-e2b4-4a9e621a73c1"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-34-8854"
* name
  * use = #official
  * family = "Homenick"
  * given[0] = "Dianna"
  * given[+] = "Kiersten"
* telecom
  * system = #phone
  * value = "555-968-1946"
  * use = #home
* gender = #female
* birthDate = "2007-03-31"
* address
  * line = "607 Boyle Plaza Apt 43"
  * city = "North Brookfield"
  * state = "MA"
  * postalCode = "01535"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#S "Never Married"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: payer-patient-3
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $organization-type#pay
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000018"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "a470aa8e-2e18-8e33-f524-382b9fc6eb49"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-36-4256"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99995156"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X55672745X"
* name[0]
  * use = #official
  * family = "Vandervort"
  * given[0] = "Georgette"
  * given[+] = "Tawanda"
  * prefix = "Mrs."
* name[+]
  * use = #maiden
  * family = "Shields"
  * given[0] = "Georgette"
  * given[+] = "Tawanda"
  * prefix = "Mrs."
* telecom
  * system = #phone
  * value = "555-262-3852"
  * use = #home
* gender = #female
* birthDate = "1994-11-06"
* address
  * line = "963 Kihn Orchard Suite 15"
  * city = "Wilmington"
  * state = "MA"
  * postalCode = "01887"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: payer-patient-4
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $organization-type#pay
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000019"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "92b4ad87-92b9-4cac-7a36-6c9e12e09f69"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-53-5472"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99921702"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X8255641X"
* name
  * use = #official
  * family = "Murazik"
  * given[0] = "Calvin"
  * given[+] = "Jason"
  * prefix = "Mr."
* telecom
  * system = #phone
  * value = "555-783-7609"
  * use = #home
* gender = #male
* birthDate = "1965-11-26"
* address
  * line = "546 Dibbert Vale Suite 25"
  * city = "Amherst"
  * state = "MA"
  * postalCode = "00000"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: payer-patient-5
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $organization-type#pay
* identifier[0]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000020"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "c547ca48-bb2c-8ac1-3385-901b5e9f51c0"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-85-5286"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99919616"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X67830063X"
* name[0]
  * use = #official
  * family = "Hermiston"
  * given[0] = "Letty"
  * given[+] = "Kelle"
  * prefix = "Mrs."
* name[+]
  * use = #maiden
  * family = "Reynolds"
  * given[0] = "Letty"
  * given[+] = "Kelle"
  * prefix = "Mrs."
* telecom
  * system = #phone
  * value = "555-316-5593"
  * use = #home
* gender = #female
* birthDate = "1989-03-22"
* address
  * line = "231 Kutch Village Apt 76"
  * city = "Wakefield"
  * state = "MA"
  * postalCode = "01880"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#zh "Chinese"

Instance: payer-patient-6
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $organization-type#pay
* identifier[0]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000220"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "c547ca48-bb2c-8ac1-3385-901b5e9f22c0"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-85-5281"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99919716"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X67831063X"
* name[0]
  * use = #official
  * family = "DOE"
  * given[0] = "TEST"
  * given[+] = "USER"
  * prefix = "Mrs."
* name[+]
  * use = #maiden
  * family = "DOE1"
  * given[0] = "TEST1"
  * given[+] = "USER1"
  * prefix = "Mrs."
* telecom
  * system = #phone
  * value = "555-316-5593"
  * use = #home
* gender = #male
* birthDate = "1967-03-21"
* address
  * line = "231 Kutch Village Apt 76"
  * city = "Wakefield"
  * state = "MA"
  * postalCode = "01880"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#zh "Chinese"