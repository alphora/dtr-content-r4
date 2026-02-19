library ASLPDataElements

using USCore version '7.0.0'
using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include hl7.fhir.uv.cql.FHIRCommon version '2.0.0'
include hl7.fhir.us.cql.USCoreElements called UCE

include SDHCommon called SC
include ASLPConcepts called Cs

parameter "Coverage" FHIR.Coverage
parameter "Request" Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.Appointment, FHIR.Encounter>
  // TODO: remove defaults and Id params for production use
parameter "RequestId" List<System.String>
  default { 'required-SleepStudy', 'not-required-SleepStudy', 'SleepStudy', 'SleepStudy2' }

context Patient

define "BMI":
  convert(
    Last(
      UCE."All Body Mass Index Measurements" B
        where B.status in { 'final', 'amended', 'corrected' }
        sort by effective
    ).value as FHIR.Quantity
  ) to 'kg/m2' 

define "Diagnosis of Obstructive Sleep Apnea":
  (
  [FHIR."Condition": Cs."Diagnosis of Obstructive Sleep Apnea Codes"] C
    where C.isActive()
    and C.isConfirmed()
  ).mostRecent().code

define "Height":
  convert(
    Last(
      UCE."All Body Height Measurements" BH
        where BH.status in { 'final', 'amended', 'corrected' }
        sort by effective
    ).value
  ) to '[in_i]'

define "History of Diabetes":
  Coalesce(
    SC.Has(
    [FHIR."Condition": Cs."History of Diabetes"] C
      where C.isActive()
      and C.isConfirmed()
    ),
    SC.Has(
      //TODO no general Observation type in USCore modelinfo
    [FHIR.Observation: Cs."History of Diabetes"] O
      where O.status in { 'final', 'amended', 'corrected' }
      and (convert(O.value as FHIR.Quantity) to 'mmol/L').value > 7.5
    )
  )

define "History of Hypertension":
  SC.Has(
    [FHIR."Condition": Cs."History of Hypertension"] C
      where C.isActive()
      and C.isConfirmed()
  )

define "Neck Circumference":
  convert(
    SC.MostRecent(
      [FHIR.Observation: Cs."Neck Circumference"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as FHIR.Quantity
  ) to '[in_i]'   

define "Sleep Study":
  Coalesce(
    First([FHIR.ServiceRequest] SR
      where SR.id in "RequestId"),
    "Request" as FHIR.ServiceRequest,
    null as FHIR.ServiceRequest
  )

define "Sleep Study Code":
  ("Sleep Study").code

define "Sleep Study Date":
  ("Sleep Study").occurrence

define "Weight":
  convert(
    Last(
      UCE."All Body Weight Measurements" W
        where W.status in { 'final', 'amended', 'corrected' }
        sort by effective
    ).value 
  ) to '[lb_av]'
