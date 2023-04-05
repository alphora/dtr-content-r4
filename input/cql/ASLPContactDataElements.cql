library ASLPContactDataElements

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'
include FHIRCommon called FC

include SDHCommon called SC
include ASLPConcepts called Cs

context Encounter

/*
  @dataElement: ASLP.A1.DE22 BMI
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Body mass index (BMI)
*/
define "BMI":
  SC.MostRecent(
  [Observation: Cs."BMI"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Last(Split(O.encounter.reference, '/')) = Encounter.id
  ).value as FHIR.Quantity


/*
  @dataElement: ASLP.A1.DE16 Diagnosis of Obstructive Sleep Apnea
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Diagnosis of Obstructive Sleep Apnea
*/
define "Diagnosis of Obstructive Sleep Apnea":
  [Condition: Cs."Diagnosis of Obstructive Sleep Apnea Codes"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
      and Last(Split(C.encounter.reference, '/')) = Encounter.id


/*
  @dataElement: ASLP.A1.DE20 Height
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Height (in inches)
*/
define "Height":
  SC.MostRecent(
  [Observation: Cs."Height"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Last(Split(O.encounter.reference, '/')) = Encounter.id
  ).value as FHIR.Quantity


/*
  @dataElement: ASLP.A1.DE19 History of Diabetes
  @activity: ASLP.A1 Adult Sleep Studies
  @description: History of Diabetes
*/
define "History of Diabetes":
  SC.MostRecent(
  [Observation: Cs."History of Diabetes"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Last(Split(O.encounter.reference, '/')) = Encounter.id
  ).value as FHIR.boolean


/*
  @dataElement: ASLP.A1.DE18 History of Hypertension
  @activity: ASLP.A1 Adult Sleep Studies
  @description: History of Hypertension
*/
define "History of Hypertension":
  SC.MostRecent(
  [Observation: Cs."History of Hypertension"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Last(Split(O.encounter.reference, '/')) = Encounter.id
  ).value as FHIR.boolean


/*
  @dataElement: ASLP.A1.DE20 Neck Circumference
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Neck circumference (in inches)
*/
define "Neck Circumference":
  SC.MostRecent(
  [Observation: Cs."Neck Circumference"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Last(Split(O.encounter.reference, '/')) = Encounter.id
  ).value as FHIR.Quantity


/*
  @dataElement: ASLP.A1.DE1 Sleep Study
  @activity: ASLP.A1 Adult Sleep Studies
  @description: A sleep study procedure being ordered
*/
define "Sleep Study":
  [ServiceRequest: Cs."Sleep Study Codes Grouper"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and SR.doNotPerform is not true
      and Last(Split(SR.encounter.reference, '/')) = Encounter.id


/*
  @dataElement: ALSP.A1.DE15 Sleep Study Date
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Date of the procedure
*/
define "Sleep Study Date":
  [ServiceRequest: Cs."Sleep Study Codes Grouper"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and SR.doNotPerform is not true
      and Last(Split(SR.encounter.reference, '/')) = Encounter.id


/*
  @dataElement: ASLP.A1.DE21 Weight
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Weight (in pounds)
*/
define "Weight":
  SC.MostRecent(
  [Observation: Cs."Weight"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Last(Split(O.encounter.reference, '/')) = Encounter.id
  ).value as FHIR.Quantity


