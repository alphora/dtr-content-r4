library ASLPDataElements

using USCore version '3.1.1'
using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'
include USCoreCommon called UC

include SDHCommon called SC
include ASLPConcepts called Cs

parameter "Device Request" List<FHIR.DeviceRequest>
parameter "Device Request Id" List<System.String>
parameter "Medication Request" List<USCore.MedicationRequestProfile>
parameter "Medication Request Id" List<System.String>
parameter "Nutrition Order" List<FHIR.NutritionOrder>
parameter "Nutrition Order Id" List<System.String>
  // TODO: remove defaults for production use
  default { 'required-NutritionOrder', 'not-required-NutritionOrder', 'NutritionOrder', 'NutritionOrder2' }
parameter "Service Request" List<FHIR.ServiceRequest>
parameter "Service Request Id" List<System.String> 
  // TODO: remove defaults for production use
  default { 'required-SleepStudy', 'not-required-SleepStudy', 'SleepStudy', 'SleepStudy2' }
parameter "Coverage Id" List<System.String>

context Patient

define "BMI":
  convert(
    UC.MostRecent(
      [USCore."observation-bmi"] B
        where B.status in { 'final', 'amended', 'corrected' }
    ).value
  ) to 'kg/m2' 

define "Diagnosis of Obstructive Sleep Apnea":
  UC.MostRecent(
  [USCore."Condition": Cs."Diagnosis of Obstructive Sleep Apnea Codes"] C 
    where C.isActive()
    and C.isConfirmed()
  ).code

define "Height":
  convert(
    UC.MostRecent(
      [USCore."observation-bodyheight"] BH
        where BH.status in { 'final', 'amended', 'corrected' }
    ).value 
  ) to '[in_i]'

define "History of Diabetes":
  Coalesce(
    SC.Has(
    [USCore."Condition": Cs."History of Diabetes"] C
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
    [USCore."Condition": Cs."History of Hypertension"] C
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
    [FHIR.ServiceRequest] SR
      where SR.id in "Service Request Id",
    { null as FHIR.ServiceRequest }
  )
    union Coalesce("Service Request", { null as FHIR.ServiceRequest })

define "Sleep Study Code":
  ("Sleep Study").code

define "Sleep Study Date":
  ("Sleep Study").occurrence

define "Nutrition Order":
  Coalesce(
    [FHIR.NutritionOrder] NutOrder
      where NutOrder.id in "Nutrition Order Id",
    { null as FHIR.NutritionOrder }
  )
    union Coalesce("Nutrition Order", { null as FHIR.NutritionOrder })

define "Nutrition Order Code":
  ("Nutrition Order").code

define "Nutrition Order Date":
  ("Nutrition Order").occurrence

define "Weight":
  convert(
    UC.MostRecent(
      [USCore."observation-bodyweight"] W
        where W.status in { 'final', 'amended', 'corrected' }
    ).value 
  ) to '[lb_av]'
