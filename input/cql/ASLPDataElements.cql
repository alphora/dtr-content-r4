library ASLPDataElements

using QICore version '4.1.1'

include FHIRHelpers version '4.1.000'
include QICoreCommon called QC

include SDHCommon called SC
include ASLPConcepts called Cs

context Patient

/*
  @dataElement: ASLP.A1.DE22 BMI
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Body mass index (BMI)
*/
define "BMI":
  [Observation: Cs."BMI"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: ASLP.A1.DE16 Diagnosis of Obstructive Sleep Apnea
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Diagnosis of Obstructive Sleep Apnea
*/
define "Diagnosis of Obstructive Sleep Apnea":
  SC.MostRecent(
  [Condition: Cs."Diagnosis of Obstructive Sleep Apnea Codes"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
  ).code


/*
  @dataElement: ASLP.A1.DE20 Height
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Height (in inches)
*/
define "Height":
  [Observation: Cs."Height"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: ASLP.A1.DE19 History of Diabetes
  @activity: ASLP.A1 Adult Sleep Studies
  @description: History of Diabetes
*/
define "History of Diabetes":
  [Observation: Cs."History of Diabetes"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: ASLP.A1.DE18 History of Hypertension
  @activity: ASLP.A1 Adult Sleep Studies
  @description: History of Hypertension
*/
define "History of Hypertension":
  [Observation: Cs."History of Hypertension"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: ASLP.A1.DE20 Neck Circumference
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Neck circumference (in inches)
*/
define "Neck Circumference":
  [Observation: Cs."Neck Circumference"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: ASLP.A1.DE1 Sleep Study
  @activity: ASLP.A1 Adult Sleep Studies
  @description: A sleep study procedure being ordered
*/
define "Sleep Study":
  [ServiceRequest: code in Cs."Sleep Study Codes Grouper"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and SR.doNotPerform is not true


/*
  @dataElement: ALSP.A1.DE15 Sleep Study Date
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Date of the procedure
*/
define "Sleep Study Date":
  [ServiceRequest: code in Cs."Sleep Study Codes Grouper] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and SR.doNotPerform is not true


/*
  @dataElement: ASLP.A1.DE21 Weight
  @activity: ASLP.A1 Adult Sleep Studies
  @description: Weight (in pounds)
*/
define "Weight":
  [Observation: Cs."Weight"] O
    where O.status in { 'final', 'amended', 'corrected' }


