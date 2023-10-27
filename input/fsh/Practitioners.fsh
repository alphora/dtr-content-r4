Alias: $organization-type = http://terminology.hl7.org/CodeSystem/organization-type

Instance: ASLP-Practitioner-1
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/Practitioner"
* meta.tag = $organization-type#pay "Payor"
* identifier[+]
  * system = "http://hl7.org/fhir/sid/us-npi"
  * value = "1234567890"
* name[+]
  * family = "George"
    * extension[+]
      * url = "http://hl7.org/fhir/NameUse"
      * valueString = "OR"
  * given = "Curious"
  * suffix = "DR."
* telecom[+]
  * system = #phone
  * value = "+33 (237) 998327"
* address[+]
  * use = #work
  * type = #both
  * line = "17 Central Park Av"
  * city = "New York"
  * state = "NY"
  * postalCode = "10019"
  * period.start = "2010-10-10"
* gender = #male
* birthDate = "1989-08-17" 
* active = true

Instance: ASLP-Practitioner-2
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner"
* meta.tag = $organization-type#pay "Payor"
* identifier[+]
  * system = "http://hl7.org/fhir/sid/us-npi"
  * value = "0987654321"
* name[+]
  * family = "Pine"
  * given = "Chris"
  * prefix = "DR."
* telecom[+]
  * system = #phone
  * value = "415-830-2461"
* address[+]
  * use = #work
  * line = "10 Health av"
  * city = "San Francisco"
  * state = "CA"
  * postalCode = "94118"
  * period.start = "2009-09-09"
* gender = #male
* birthDate = "1972-08-24" 
* active = true

Instance: ASLP-Practitioner-3
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner"
* identifier[+]
  * system = "http://hl7.org/fhir/sid/us-npi"
  * value = "9876123450"
* name[+]
  * family = "Grey"
  * given = "Meredith"
  * prefix = "DR."
* telecom[+]
  * system = #phone
  * value = "385-490-1112"
* address[+]
  * use = #work
  * line = "579 Healthy st"
  * city = "Salt Lake City"
  * state = "UT"
  * postalCode = "84050"
  * period.start = "2010-06-01"
* gender = #female
* birthDate = "1982-08-24" 
* active = true

Instance: ASLP-Practitioner-4
InstanceOf: Practitioner
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner"
* identifier[+]
  * system = "http://hl7.org/fhir/sid/us-npi"
  * value = "1029384766"
* name[+]
  * family = "Chang"
  * given = "Christina"
  * prefix = "DR."
* telecom[+]
  * system = #phone
  * value = "212-999-1122"
* address[+]
  * use = #work
  * line = "579 Doctor rd"
  * city = "New York"
  * district = "Soho"
  * state = "NY"
  * postalCode = "10012"
  * period.start = "2010-04-10"
* gender = #female
* birthDate = "1982-08-24" 
* active = true