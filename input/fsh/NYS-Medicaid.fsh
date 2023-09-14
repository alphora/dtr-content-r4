Alias: $PCTOrgIdentifierTypeCS = http://hl7.org/fhir/us/davinci-pct/CodeSystem/PCTOrgIdentifierTypeCS
Alias: $org-type = http://terminology.hl7.org/CodeSystem/organization-type

Instance: NYS-Medicaid
InstanceOf: Organization
Usage: #example
* meta.profile = "http://hl7.org/fhir/us/davinci-pct/StructureDefinition/davinci-pct-organization"
* identifier[0]
  * type = $PCTOrgIdentifierTypeCS#ETIN "Electronic Transmitter Identification Number"
  * value = "ETIN-3200002"
* identifier[+]
  * type = $PCTOrgIdentifierTypeCS#payerid "Payer ID"
  * value = "MCDNY"
* identifier[+]
  * type = $PCTOrgIdentifierTypeCS#IIN "Issuer Identification Number "
  * value = "004740"
* active = true
* name = "New York State Department of Health (NYSDOH)"
* alias = "eMedNY"
* type = $org-type#pay "Payer"
* telecom[0]
  * system = #phone
  * value = "(+1) 800-343-9000"
* address
  * extension
    * url = "http://hl7.org/fhir/us/davinci-pct/StructureDefinition/countrySubdivisionCode"
    * valueCoding = urn:iso:std:iso:3166:-2#US-NY
  * use = #billing
  * line = "PO Box 4610"
  * city = "Rensselaer"
  * state = "NY"
  * postalCode = "12144-4610"
  * country = "USA"