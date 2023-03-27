library Elements version '0.0.001'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.001' called FHIRHelpers
include Common version '0.0.001' called Common
include Concepts version '0.0.001' called Concepts

context Patient

define "BMI Observations":
    Common.QualifiedObservations([Observation: Concepts."BMI"])

define "Weight Observations":
    Common.QualifiedObservations([Observation: Concepts."Weight"])
    
define "Height Observations":
    Common.QualifiedObservations([Observation: Concepts."Height"])
