ValueSet: Impairment
Id: Impairment
Title: "Impairment ValueSet"
Description: "ValueSet for Impairment for Safe Use of Equipment"

* ^status = #active
* ^experimental = false

* include codes from system $SCT where concept is-a #386806002
* $SCT#306741005 "Poor manual dexterity (finding)"
* $ICD11#QF23 "Difficulty or need for assistance with mobility"
* $ICD11#QF26 "Difficulty or need for assistance with household tasks"
* include codes from system $SCT where concept is-a #82971005
* include codes from system $SCT where concept is-a #285859009