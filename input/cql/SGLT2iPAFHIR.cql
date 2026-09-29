library SGLT2iPAFHIR version '1.0.0'

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'
include SupplementalDataElementsFHIR4 version '2.0.000' called SDE
include MATGlobalCommonFunctionsFHIR4 version '6.1.000' called GF
include CaseFeatureCommon version '1.1.000' called CFC

valueset "Diabetes": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.103.12.1001'
// TODO: trim this valueset to only diabetes with complications
valueset "HbA1c": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.11.1024'
valueset "Diabetes Medication": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1190.58'
valueset "eGFR": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.6929.2.1000'
valueset "uACR": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.6929.2.1002'
valueset "Dialysis": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1248.197'
valueset "CKD": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1110.53'
valueset "ConditionClinical": 'http://terminology.hl7.org/CodeSystem/condition-clinical'

parameter "Measurement Period" Interval<System.DateTime>
  default Interval[@2025-12-31T00:00:00.0, @2026-12-31T00:00:00.0)

parameter ErrorLevel String default 'Warning'

context Patient

define "SDE Ethnicity":
  SDE."SDE Ethnicity"

define "SDE Payer":
  SDE."SDE Payer"

define "SDE Race":
  SDE."SDE Race"

define "SDE Sex":
  SDE."SDE Sex"

// *****************************************************************************
// Prior Diagnosis of Diabetes
// *****************************************************************************

define "Diabetes Conditions":
  ([Condition: "Diabetes"] C 
    // where 
    //   not(
    //     C.clinicalStatus ~ GF."inactive" 
    //       or C.clinicalStatus ~ GF."resolved"
    //   )
    //   and not(
    //     C.verificationStatus ~ GF."unconfirmed" 
    //       or C.verificationStatus ~ GF."refuted" 
    //       or C.verificationStatus ~ GF."entered-in-error"
    //   )
  )

define "Has Diagnosis of Diabetes":
  exists("Diabetes Conditions")
  and "Diabetes Conditions" is not null

define "Most Recent Diabetes Condition":
  GetFirstCond("Diabetes Conditions")

// define "Diabetes Rationale":
//   'Onset: ' + (start of FHIRCommon.ToInterval(CFC.MostRecent("Diabetes Conditions" as List<FHIR.Condition>).onset)).rationaleString() + ', Diagnosis Code: ' + CFC.MostRecent("Diabetes Conditions" as List<FHIR.Condition>).code.rationaleString()

// *****************************************************************************
// Most Recent A1c >8
// *****************************************************************************

define "A1c Observations":
  [Observation: "HbA1c"]
    // TODO: lookback period?

define "Most Recent A1c":
  GetFirstObs("A1c Observations")

define "Most Recent A1c > 8%":
  GetFirstObs(
    "A1c Observations" A1cObs 
      where A1cObs.value > 8 '%'
  )

define "Has Most Recent A1c > 8":
  "Most Recent A1c > 8%" is not null

// *****************************************************************************
// A1c >8% on while on at least 2 prior Diabetes Medications for at least 6 mos.
// *****************************************************************************
// TODO: currently out-of-scope
// TODO: determine what is meant by "medication regimen changed"

// define "Metformin MedicationRequests":
//   [MedicationRequest: "Diabetes Medication - metformin"]

// define "Metformin Usage Interval":
//   "Medication Usage Interval"("Metformin MedicationRequests")

// define "Glipizide MedicationRequests":
//   [MedicationRequest: "Diabetes Medication - glipizide"]

// define "Glipizide Usage Interval":
//   "Medication Usage Interval"("Glipizide MedicationRequests")

// define "Diabetes MedicationRequests":
//    "Metformin MedicationRequests"
//      union "Glipizide MedicationRequests"

// define "Diabetes Medication Usage Interval":
//   "Medication Usage Interval"("Diabetes MedicationRequests")

// define function "Medication Usage Interval"(medicationRequests List<MedicationRequest>)
// returns Interval<System.Date>:
//   Last(
//     (
//       collapse(
//         medicationRequests MR
//           return MR.medicationRequestPeriod()
//       )
//     )
//   )

// *****************************************************************************
// A1c < 1% reduction despite new Diabetes medication (on for at least 6 mos.)
// *****************************************************************************
// TODO: currently out-of-scope

// define "Most Recent A1c before Metformin":
//   (
//     "A1c Observations" A1c
//     where A1c.effective on or before start of "Metformin Usage Interval"
//   ).mostRecent()

// define "A1c reduction due to Metformin":
//   ("Most Recent A1c before Metformin".value as FHIR.Quantity) - ("Most Recent A1c".value as FHIR.Quantity)

// define "A1c reduction due to Metformin < 1 %":
//   "A1c reduction due to Metformin" < 1 '%'

// *****************************************************************************
// Evidence of CKD
// *****************************************************************************

define "Has Evidence of CKD":
  // 2 eGFR’s <90 with dates>3 mos. apart AND 2 uACR’s >30 twice, with dates>3 mos. apart
  ("Has Two eGFR < 90 With Dates 3 Months Apart" 
    and "Has Two uACR > 30 With Dates 3 Months Apart"
  )
  // OR CKD Diagnosis AND most recent eGFR<90 AND most recent uACR>30
  or ("Has CKD Diagnosis" 
    and "Most Recent eGFR".value < 90 'mL/min/{1.73_m2}' 
    and "Most Recent uACR".value > 30 'mg/g'
  )
  // OR On Dialysis
  or "On Dialysis"

define "eGFR Observations":
  [Observation: "eGFR"]
    // TODO: lookback period?

define "Most Recent eGFR":
  GetFirstObs("eGFR Observations")

define "Most Recent eGFR < 90":
   GetFirstObs("eGFR Observations < 90")

define "Has eGFR < 90":
   "Most Recent eGFR < 90" is not null

define "eGFR Observations < 90":
  "eGFR Observations" Obs
    where Obs.value < 90 'mL/min/{1.73_m2}'

// TODO: Do these need to be consecutive?
define "Two eGFR < 90 With Dates 3 Months Apart":
  "eGFR Observations < 90" EGFR1
  with "eGFR Observations < 90" EGFR2
  such that date from (start of FHIRHelpers.ToInterval(EGFR2.effective)) > date from ((start of FHIRHelpers.ToInterval(EGFR1.effective)) + 3 months)

define "Has Two eGFR < 90 With Dates 3 Months Apart":
  exists("Two eGFR < 90 With Dates 3 Months Apart")

define "uACR Observations":
  [Observation: "uACR"]
    // TODO: lookback period?

define "Most Recent uACR":
  GetFirstObs("uACR Observations")

define "Most Recent uACR > 30":
  GetFirstObs("uACR Observations > 30")

define "Has Recent uACR > 30":  
  "Most Recent uACR > 30" is not null

define "uACR Observations > 30":
  "uACR Observations" Obs
    where Obs.value > 30 'mg/g'

// TODO: Do these need to be consecutive?
define "Two uACR > 30 With Dates 3 Months Apart":
  "uACR Observations > 30" uACR1
    with "uACR Observations > 30" uACR2
    such that date from start of FHIRHelpers.ToInterval(uACR2.effective) > date from (start of FHIRHelpers.ToInterval(uACR1.effective) + 3 months)

define "Has Two uACR > 30 With Dates 3 Months Apart":
  exists("Two uACR > 30 With Dates 3 Months Apart")

define "CKD Diagnosis": 
  ([Condition: "CKD"] 
    // where exists (C.clinicalStatus.coding c 
    //   where not (FHIRHelpers.ToCode(c) in {GF."inactive", GF."resolved"})
    // )
    // and exists (C.verificationStatus.coding c2 
    //   where not (FHIRHelpers.ToCode(c2) in {GF."unconfirmed", GF."refuted", GF."entered-in-error"})
    // )
  )

define "Most Recent CKD Condition":
  GetFirstCond("CKD Diagnosis")

define "Has CKD Diagnosis":
  exists("CKD Diagnosis")
  or "CKD Diagnosis" is not null

define "Dialysis Procedures": 
  [Procedure: "Dialysis"] D 
    where not (D.status in {'not-done', 'on-hold', 'stopped', 'entered-in-error'})

define "On Dialysis":
  exists("Dialysis Procedures")
  and "Dialysis Procedures" is not null


// *****************************************************************************
// String Interpolation functions
// *****************************************************************************
define fluent function rationaleString(c FHIR.CodeableConcept)
returns System.String:
  Combine(
    (c.coding cd return cd.system.value.mapSystem() + '|' + cd.code.value),
    ';'
  )

define fluent function mapSystem(s System.String)
returns System.String:
  case s
    when 'http://snomed.info/sct' then 'SCT'
    when 'http://hl7.org/fhir/sid/icd-10-cm' then 'ICD-10'
    when 'http://www.nlm.nih.gov/research/umls/rxnorm' then 'RXNORM'
    when 'http://loinc.org' then 'LOINC'
    else s
  end

// define fluent function rationaleString(d FHIR.dateTime)
// returns System.String:
//   ToString(date from FHIRHelpers.ToDateTime(d))

// *****************************************************************************
// CumulativeMedicationDuration functions
// *****************************************************************************
// define fluent function medicationRequestPeriod(medicationRequest MedicationRequest):
//   medicationRequest R
//     let
//       dosage: singleton from R.dosageInstruction,
//       doseAndRate: singleton from dosage.doseAndRate,
//       timing: dosage.timing,
//       frequency: Coalesce(timing.repeat.frequencyMax, timing.repeat.frequency),
//       period: Quantity(timing.repeat.period, timing.repeat.periodUnit),
//       doseRange: doseAndRate.dose,
//       doseQuantity: doseAndRate.dose,
//       dose: Coalesce(end of doseRange, doseQuantity),
//       dosesPerDay: Coalesce(ToDaily(frequency, period), Count(timing.repeat.timeOfDay), 1.0),
//       boundsPeriod: FHIRCommon.ToInterval(timing.repeat.bounds) as Interval<DateTime>,
//       daysSupply: (convert R.dispenseRequest.expectedSupplyDuration to days).value,
//       quantity: R.dispenseRequest.quantity,
//       refills: Coalesce(R.dispenseRequest.numberOfRepeatsAllowed, 0),
//       startDate:
//         Coalesce(
//           date from start of boundsPeriod,
//           date from R.authoredOn,
//           date from start of R.dispenseRequest.validityPeriod
//         ),
//       totalDaysSupplied: Coalesce(daysSupply, quantity.value / (dose.value * dosesPerDay)) * (1 + refills)
//     return
//       if startDate is not null and totalDaysSupplied is not null then
//         Interval[startDate, startDate + Quantity(totalDaysSupplied - 1, 'day') ]
//       else if startDate is not null and boundsPeriod."high" is not null then
//         Interval[startDate, date from end of boundsPeriod]
//       else
//         null

/*
  Calculates daily frequency given frequency within a period
*/
define function ToDaily(frequency System.Integer, period System.Quantity):
  case period.unit
    when 'h' then frequency * (24.0 / period.value)
    when 'min' then frequency * (24.0 / period.value) * 60
    when 's' then frequency * (24.0 / period.value) * 60 * 60
    when 'd' then frequency * (24.0 / period.value) / 24
    when 'wk' then frequency * (24.0 / period.value) / (24 * 7)
    when 'mo' then frequency * (24.0 / period.value) / (24 * 30) /* assuming 30 days in month */
    when 'a' then frequency * (24.0 / period.value) / (24 * 365) /* assuming 365 days in year */
    when 'hour' then frequency * (24.0 / period.value)
    when 'minute' then frequency * (24.0 / period.value) * 60
    when 'second' then frequency * (24.0 / period.value) * 60 * 60
    when 'day' then frequency * (24.0 / period.value) / 24
    when 'week' then frequency * (24.0 / period.value) / (24 * 7)
    when 'month' then frequency * (24.0 / period.value) / (24 * 30) /* assuming 30 days in month */
    when 'year' then frequency * (24.0 / period.value) / (24 * 365) /* assuming 365 days in year */
    when 'hours' then frequency * (24.0 / period.value)
    when 'minutes' then frequency * (24.0 / period.value) * 60
    when 'seconds' then frequency * (24.0 / period.value) * 60 * 60
    when 'days' then frequency * (24.0 / period.value) / 24
    when 'weeks' then frequency * (24.0 / period.value) / (24 * 7)
    when 'months' then frequency * (24.0 / period.value) / (24 * 30) /* assuming 30 days in month */
    when 'years' then frequency * (24.0 / period.value) / (24 * 365) /* assuming 365 days in year */
    else Message(null, true, 'CMDLogic.ToDaily.UnknownUnit', ErrorLevel, 'Unknown unit ' & period.unit)
  end

define function Quantity(value Decimal, unit String):
  if value is not null then
    System.Quantity { value: value, unit: unit }
  else
    null

define function GetFirstObs(ObsList List<FHIR.Observation>):
  First(
    ObsList Obs
      sort by (
        if effective is FHIR.dateTime then
          FHIRHelpers.ToDateTime(effective as FHIR.dateTime)
        else if effective is FHIR.instant then
          FHIRHelpers.ToDateTime(effective as FHIR.instant)
        else if effective is FHIR.Period then
          start of (effective as FHIR.Period)
        else if issued is not null then
          FHIRHelpers.ToDateTime(issued)
        else null
      ) desc 
  )

define function GetFirstCond(CondList List<FHIR.Condition>):
  First(
    CondList C
    sort by (
      if onset is FHIR.dateTime then 
        (onset as FHIR.dateTime)
      else if onset is FHIR.Period then 
        start of (onset as FHIR.Period) 
      else
        recordedDate as FHIR.dateTime
    ) desc
  )