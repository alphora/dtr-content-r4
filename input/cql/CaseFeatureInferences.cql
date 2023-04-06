library CaseFeatureInferences version '0.0.001'

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000' called FHIRHelpers
include Common version '0.0.001' called Common
include Concepts version '0.0.001' called Concepts
include Elements version '0.0.001' called Elements

context Patient

define "Most Recent Weight":
    convert(
        Common.MostRecent(Elements."Weight Observations").value as FHIR.Quantity
    ) to 'kg'

define "Most Recent Height":
    convert(
        Common.MostRecent(Elements."Height Observations").value as FHIR.Quantity
    ) to 'm'

define "Calculated BMI Value":
    "Most Recent Weight" / "Most Recent Height".value ^ 2.0 * 703

define "Most Recent BMI":
    Common.CaseFeatureObservation(
        Concepts."BMI Inference", 
        "Calculated BMI Value",
        Now(),
        'http://canonical-base/StructureDefinition/MostRecentBMI'
    )
