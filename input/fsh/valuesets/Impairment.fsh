ValueSet: Impairment
Id: Impairment
Title: "Impairment ValueSet"
Description: "ValueSet for Impairment for Safe Use of Equipment"

* ^status = #active
* ^experimental = false

* codes from system $ICD11 where parent = #MB21
* codes from system $SCT where parent = #386806002
* $SCT#306741005 "Poor manual dexterity (finding)"
* $ICD11#QF23 "Difficulty or need for assistance with mobility"
* $ICD11#QF26 "Difficulty or need for assistance with household tasks"
* codes from system $SCT where parent = #82971005
* codes from system $SCT where parent = #285859009