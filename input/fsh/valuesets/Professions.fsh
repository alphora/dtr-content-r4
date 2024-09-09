ValueSet: Profession
Id: Profession
Title: "Profession ValueSet"
Description: "ValueSet for Mission Critical Profession"

* ^status = #active
* ^experimental = false

* $ICD11#XE3TU "Occupation - legislators, senior officials, managers"
* $ICD11#XE59Y "Occupation - professionals"
* $ICD11#XE5G8 "Occupation - armed forces"
* include codes from system $SCT where concept is-a #308040008
* include codes from system $SCT where concept is-a #236320001
* include codes from system $SCT where concept is-a #265981008
* include codes from system $SCT where concept is-a #223366009