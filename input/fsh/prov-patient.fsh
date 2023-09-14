Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $v3-MaritalStatus = http://terminology.hl7.org/CodeSystem/v3-MaritalStatus
Alias: $org-type = http://terminology.hl7.org/CodeSystem/organization-type

Instance: provider-patient-1
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[0]
  * system = "https://hl7.org/fhir/memberidentifier"
  * value = "N0000024"
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000015"
* identifier[+]
  * system = "http://hl7.org/fhir/CodeSystem/sid/us-medicaid"
  * value = "004740" // IIN for NYS Medicaid
* identifier[+]
  * system = "http://hl7.org/fhir/sid/us-medicard"
  * value = "N0000024B"
* identifier[+]
  * system = "http://hl7.org/fhir/CodeSystem/sid/us-legacy-medicare"
  * value = "N0000024C"
* identifier[+]
  * system = "http://hl7.org/fhir/CodeSystem/sid/diamond-id"
  * value = "N0000024D"
* identifier[+]
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "N0000024D"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "N000002002"
* active = true
* name
  * use = #official
  * text = "The Donald"
  * family = "Trump"
  * given = "Donald"
* gender = #male
* birthDate = "1938-04-30"
* address
  * type = #physical
  * line = "123 FAKE ST"
  * city = "STERLING"
  * state = "VA"
  * postalCode = "20165"
  * country = "US"

Instance: provider-patient-2
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000016"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "85e086aa-c117-6cbf-e2b4-4a9e621a73c1"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-34-8854"
* name
  * use = #official
  * family = "Homenick806"
  * given[0] = "Dianna917"
  * given[+] = "Kiersten731"
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

Instance: provider-patient-4
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000017"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
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
* name
  * use = #official
  * family = "Rutherford999"
  * given[0] = "Sebrina910"
  * given[+] = "Mabelle762"
  * prefix = "Ms."
* telecom
  * system = #phone
  * value = "555-203-6945"
  * use = #home
* gender = #female
* birthDate = "2001-01-22"
* address
  * line = "375 VonRueden Underpass Apt 19"
  * city = "Carver"
  * state = "MA"
  * postalCode = "00000"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#S "Never Married"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: provider-patient-3
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000018"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
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
  * family = "Vandervort697"
  * given[0] = "Georgette866"
  * given[+] = "Tawanda156"
  * prefix = "Mrs."
* name[+]
  * use = #maiden
  * family = "Shields502"
  * given[0] = "Georgette866"
  * given[+] = "Tawanda156"
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

Instance: provider-patient-5
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000019"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
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
  * family = "Murazik203"
  * given[0] = "Calvin845"
  * given[+] = "Jason347"
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

Instance: provider-patient-6
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000020"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
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
  * family = "Hermiston71"
  * given[0] = "Letty680"
  * given[+] = "Kelle203"
  * prefix = "Mrs."
* name[+]
  * use = #maiden
  * family = "Reynolds644"
  * given[0] = "Letty680"
  * given[+] = "Kelle203"
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

Instance: provider-patient-7
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000021"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "b07c1502-1711-a3bc-32c9-efcb17db5cd1"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-11-9455"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99967738"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X23610090X"
* name
  * use = #official
  * family = "Hauck852"
  * given[0] = "Virgil85"
  * given[+] = "Jean712"
  * prefix = "Mr."
* telecom
  * system = #phone
  * value = "555-628-1973"
  * use = #home
* gender = #male
* birthDate = "1983-03-22"
* address
  * line = "1085 Doyle Bypass Apt 98"
  * city = "Boston"
  * state = "MA"
  * postalCode = "02116"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#S "S"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: provider-patient-8
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000022"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "bd1a533b-41da-14e8-259b-d3198a7daa9a"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-82-1290"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99979356"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X82606338X"
* name
  * use = #official
  * family = "Legros616"
  * given[0] = "David908"
  * given[+] = "Cliff504"
  * prefix = "Mr."
* telecom
  * system = #phone
  * value = "555-906-7871"
  * use = #home
* gender = #male
* birthDate = "1965-06-19"
* address
  * line = "223 Koelpin Highlands Suite 89"
  * city = "Belmont"
  * state = "MA"
  * postalCode = "02472"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: provider-patient-9
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000023"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "d84fe117-55ea-1362-c171-89aa39f15954"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-83-5908"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99957056"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X83104519X"
* name[0]
  * use = #official
  * family = "Effertz744"
  * given[0] = "Myung778"
  * given[+] = "Buena501"
  * prefix = "Mrs."
* name[+]
  * use = #maiden
  * family = "Rodriguez71"
  * given[0] = "Myung778"
  * given[+] = "Buena501"
  * prefix = "Mrs."
* telecom
  * system = #phone
  * value = "555-967-1295"
  * use = #home
* gender = #female
* birthDate = "1968-09-20"
* address
  * line = "785 Frami Rue"
  * city = "Newton"
  * state = "MA"
  * postalCode = "02461"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#en-US "English"

Instance: provider-patient-10
InstanceOf: USCorePatientProfile
Usage: #example
* meta.tag = $org-type#prov
* identifier[+]
  * system = "https://prior-auth.org/fhir/memberidentifier"
  * value = "N0000024"
* identifier[+]
  * type = $v2-0203#MR "Medical Record Number"
    * text = "Medical Record Number"
  * system = "http://hospital.smarthealthit.org"
  * value = "99d796bc-bc78-2a9e-1c05-e8328b9a783c"
* identifier[+]
  * type = $v2-0203#SS "Social Security Number"
    * text = "Social Security Number"
  * system = "http://hl7.org/fhir/sid/us-ssn"
  * value = "999-29-1098"
* identifier[+]
  * type = $v2-0203#DL "Driver's License"
    * text = "Driver's License"
  * system = "urn:oid:2.16.840.1.113883.4.3.25"
  * value = "S99997472"
* identifier[+]
  * type = $v2-0203#PPN "Passport Number"
    * text = "Passport Number"
  * system = "http://standardhealthrecord.org/fhir/StructureDefinition/passportNumber"
  * value = "X6292705X"
* name[0]
  * use = #official
  * family = "Hoppe518"
  * given = "Vicki422"
  * prefix = "Mrs."
* name[+]
  * use = #maiden
  * family = "Steuber698"
  * given = "Vicki422"
  * prefix = "Mrs."
* telecom
  * system = #phone
  * value = "555-610-5069"
  * use = #home
* gender = #female
* birthDate = "1979-05-30"
* address
  * line = "551 Konopelski Annex Apt 3"
  * city = "Montague"
  * state = "MA"
  * postalCode = "00000"
  * country = "US"
* maritalStatus = $v3-MaritalStatus#M "M"
* communication.language = urn:ietf:bcp:47#en-US "English"