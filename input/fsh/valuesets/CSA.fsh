ValueSet: CSA
Id: CSA
Title: "CSA ValueSet"
Description: "ICD 11 codes for Central sleep apnoea in adults"

* ^status = #active
* ^experimental = false

* $ICD11#7A40.0 "Primary central sleep apnoea"
* $ICD11#7A40.3 "Central sleep apnea with Cheyne-Stokes breathing"
* $ICD11#7A40.5 "Central sleep apnoea due to high-altitude periodic breathing"
* $ICD11#7A40.6 "Central sleep apnoea due to a medication or substance"
* include codes from system $SCT where concept is-a #27405005