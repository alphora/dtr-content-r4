library DemoSleepStudiesAdult version '0.0.001'

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'
include CaseFeatures version '0.0.001' called CaseFeatures

define "BMI":
	CaseFeatures.MostRecentBMI
	