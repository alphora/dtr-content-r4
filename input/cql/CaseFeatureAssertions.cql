library CaseFeatureAssertions version '0.0.001'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.001' called FHIRHelpers
include Common version '0.0.001' called Common
include Concepts version '0.0.001' called Concepts
include Elements version '0.0.001' called Elements

context Patient

define "Most Recent Asserted BMI":
    Common.MostRecent(
        Elements."BMI Observations"
    )

define "Most Recent BMI":
    Common.CaseFeatureObservation(
        Concepts."BMI Assertion", 
        convert("Most Recent Asserted BMI".value as Quantity) to 'kg/m2',
        "Most Recent Asserted BMI".effective as dateTime, 
        'http://canonical-base/StructureDefinition/MostRecentBMI'
    )
