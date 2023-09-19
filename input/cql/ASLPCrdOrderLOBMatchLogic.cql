library ASLPCrdOrderLOBMatchLogic

using FHIR version '4.0.1'

include ASLPContext called Ctx
include FHIRHelpers version '4.1.000'

context Patient

define "Is OrderLOBMatch":
  true

define "Not OrderLOBMatch":
  not ("Is OrderLOBMatch")