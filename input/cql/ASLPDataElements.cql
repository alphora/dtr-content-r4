library ASLPDataElements

using QICore version '4.1.0'

include FHIRHelpers version '4.1.000'
include FHIRCommon version '1.1.000' called FC
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
  convert(
    SC.MostRecent(
      [Observation: Cs."BMI"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as System.Quantity
  ) to 'kg/m2' 


// /*
//   @dataElement: ASLP.A1.DE16 Diagnosis of Obstructive Sleep Apnea
//   @activity: ASLP.A1 Adult Sleep Studies
//   @description: Diagnosis of Obstructive Sleep Apnea
// */
define "Diagnosis of Obstructive Sleep Apnea":
  SC.MostRecent(
  [Condition] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
  ).code


// /*
//   @dataElement: ASLP.A1.DE20 Height
//   @activity: ASLP.A1 Adult Sleep Studies
//   @description: Height (in inches)
// */
define "Height":
  convert(
    SC.MostRecent(
      [Observation: Cs."Height"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as System.Quantity
  ) to '[in_i]'


// /*
//   @dataElement: ASLP.A1.DE19 History of Diabetes
//   @activity: ASLP.A1 Adult Sleep Studies
//   @description: History of Diabetes
// */
define "History of Diabetes":
  SC.Has(
    [Observation: Cs."History of Diabetes"] O
      where O.status in { 'final', 'amended', 'corrected' }
  )


// /*
//   @dataElement: ASLP.A1.DE18 History of Hypertension
//   @activity: ASLP.A1 Adult Sleep Studies
//   @description: History of Hypertension
// */
define "History of Hypertension":
  SC.Has(
    [Observation: Cs."History of Hypertension"] O
      where O.status in { 'final', 'amended', 'corrected' }
  )


// /*
//   @dataElement: ASLP.A1.DE20 Neck Circumference
//   @activity: ASLP.A1 Adult Sleep Studies
//   @description: Neck circumference (in inches)
// */
define "Neck Circumference":
  convert(
    SC.MostRecent(
      [Observation: Cs."Neck Circumference"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as System.Quantity
  ) to '[in_i]'   


// /*
//   @dataElement: ASLP.A1.DE1 Sleep Study
//   @activity: ASLP.A1 Adult Sleep Studies
//   @description: A sleep study procedure being ordered
// */
define "Sleep Study":
  (
    [ServiceRequest: code in Cs."Sleep Study Codes Grouper"] SR
      where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
        and SR.doNotPerform is not true
  ).code


// /*
//   @dataElement: ALSP.A1.DE15 Sleep Study Date
//   @activity: ASLP.A1 Adult Sleep Studies
//   @description: Date of the procedure
// */
define "Sleep Study Date":
  (
    [ServiceRequest: code in Cs."Sleep Study Codes Grouper"] SR
      where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
        and SR.doNotPerform is not true
  ).occurrence

// /*
//   @dataElement: ASLP.A1.DE21 Weight
//   @activity: ASLP.A1 Adult Sleep Studies
//   @description: Weight (in pounds)
// */
define "Weight":
  convert(
    SC.MostRecent(
      [Observation: Cs."Weight"] O
        where O.status in { 'final', 'amended', 'corrected' }
    ).value as System.Quantity
  ) to '[lb_av]'


