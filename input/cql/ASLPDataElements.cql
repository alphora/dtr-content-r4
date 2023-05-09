library ASLPDataElements

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'
include FHIRCommon version '1.1.000' called FC

include SDHCommon called SC
include ASLPConcepts called Cs

parameter "Device Request" List<FHIR.DeviceRequest>
parameter "Device Request Id" List<System.String>
parameter "Medication Request" List<FHIR.MedicationRequest>
parameter "Medication Request Id" List<System.String>
parameter "Nutrition Order" List<FHIR.NutritionOrder>
parameter "Nutrition Order Id" List<System.String>
parameter "Service Request" List<FHIR.ServiceRequest>
parameter "Service Request Id" List<System.String> 
  default { 'SleepStudy', 'SleepStudy2' }
parameter "Coverage Id" List<System.String>

context Patient

define "BMI":
  convert(
    SC.MostRecent(
      [Observation: Cs."BMI"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as FHIR.Quantity
  ) to 'kg/m2' 

define "Diagnosis of Obstructive Sleep Apnea":
  SC.MostRecent(
  [Condition: Cs."Diagnosis of Obstructive Sleep Apnea Codes"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
  ).code

define "Height":
  convert(
    SC.MostRecent(
      [Observation: Cs."Height"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as FHIR.Quantity
  ) to '[in_i]'

define "History of Diabetes":
  Coalesce(
    SC.Has(
    [Condition: Cs."History of Diabetes"] C
      where C.clinicalStatus in FC."Active Condition"
        and C.verificationStatus ~ FC."confirmed"
    ),
    SC.Has(
    [Observation: Cs."History of Diabetes"] O
      where O.status in { 'final', 'amended', 'corrected' }
      and (convert(O.value as FHIR.Quantity) to 'mmol/L').value > 7.5
    )
  )

define "History of Hypertension":
  SC.Has(
    [Condition: Cs."History of Hypertension"] C
      where C.clinicalStatus in FC."Active Condition"
        and C.verificationStatus ~ FC."confirmed"
  )

define "Neck Circumference":
  convert(
    SC.MostRecent(
      [Observation: Cs."Neck Circumference"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as FHIR.Quantity
  ) to '[in_i]'   

define "Sleep Study":
  [ServiceRequest: code in Cs."Sleep Study Codes Grouper"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and SR.doNotPerform is not true

define "Sleep Study Code":
  ("Sleep Study").code

define "Sleep Study Date":
  ("Sleep Study").occurrence

define "Weight":
  convert(
    SC.MostRecent(
      [Observation: Cs."Weight"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as FHIR.Quantity
  ) to '[lb_av]'
