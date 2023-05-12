library ASLPCrd

using FHIR version '4.0.1'

include ASLPConcepts called Cx
include ASLPDataElements called Dx
include FHIRHelpers version '4.1.000'

context Patient

define "Is Prior Auth Required":
    "Is Sleep Study Service Request" and "Has Comorbidities"

define "Has Comorbidities":
 Dx."History of Diabetes" or Dx."History of Hypertension"

define "Is Sleep Study Service Request":
    exists (Dx."Sleep Study" S where S.code in Cx."Home Based Testing Sleep Studies Codes")

define "Get Card Summary":
  if "Is Prior Auth Required" then
    'Patient requires prior authoriztion for a sleep study'
  else
    'Patient does not require prior authorization for a sleep study'

define "Get Card Detail":
  if "Is Prior Auth Required" then
    'Patient requires prior authorization due to: ' + Rationale + '. ' +
    'Please open your DTR application and complete Questionniare'
  else
    'Patient does not require prior authorization.'

define "Rationale":
  Coalesce({
    if Dx."History of Diabetes" then 'history of diabetes' else null,
    if Dx."History of Hypertension" then 'history of hypertension' else null,
    'no rationale provided'
  })


define "Get Card Indicator":
  if "Is Prior Auth Required" then
    'warning'
  else
    'info'