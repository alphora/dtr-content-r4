library CaseFeatureInferences version '0.0.001'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.001' called FHIRHelpers
include Common version '0.0.001' called Common
include Concepts version '0.0.001' called Concepts
include Elements version '0.0.001' called Elements

context Patient

define "Most Recent Weight":
    convert(
        Common.MostRecent(Elements."Weight Observations").value as Quantity
    ) to 'kg'

define "Most Recent Height":
    convert(
        Common.MostRecent(Elements."Height Observations").value as Quantity
    ) to 'm2'

define "Calculated BMI Value":
    "Most Recent Weight" / "Most Recent Height"

define "Most Recent BMI":
    Common.CaseFeatureObservation(
        Concepts."BMI Inference", 
        "Calculated BMI Value",
        Now(),
        'http://canonical-base/StructureDefinition/MostRecentBMI'
    )
