library CaseFeatures version '0.0.001'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.001' called FHIRHelpers
include Common version '0.0.001' called Common
include CaseFeatureAssertions version '0.0.001' called Assertions
include CaseFeatureInferences version '0.0.001' called Inferences

context Patient

define "Most Recent BMI":
    Coalesce(Assertions."Most Recent BMI", Inferences."Most Recent BMI")
