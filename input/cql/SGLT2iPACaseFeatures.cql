library SGLT2iPACaseFeatures version '1.0.0'

using FHIR version '4.0.1'

include SGLT2iPAFHIR version '1.0.0' called SPF
include FHIRHelpers version '4.0.1' called FHIRHelpers
include FHIRCommon version '1.1.000' called FC
include SGLT2iPAConcepts called Concepts
include CaseFeatureCommon called CFC

context Patient

define "Most Recent Diagnosis Of Diabetes":
  SPF.GetFirstObs([Observation: FHIRHelpers.ToCode(First(Concepts."Qualifying Diagnosis of Diabetes Assertion".coding))])

define "Qualifying Diabetes Diagnosis":
  if not "Most Recent Diagnosis Of Diabetes" is null
    then "Most Recent Diagnosis Of Diabetes"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying Diagnosis of Diabetes Assertion",
      SPF."Has Diagnosis of Diabetes", 
      FHIRHelpers.ToDateTime("Most Recent Diagnosis Of Diabetes".effective as FHIR.dateTime),
      'http://example.org/sdh/demo/sglt2i/StructureDefinition/sglt2i-diabetes-diagnosis-casefeature-definition',
      CFC.MostRecent(SPF."Diabetes Conditions"),
      ''
    )

define "Has Diabetes Diagnosis Value":
  "Qualifying Diabetes Diagnosis".value.value as System.Boolean

define "Has Diabetes Diagnosis":
  IsTrue("Has Diabetes Diagnosis Value")

define "Does Not Have Diabetes Diagnosis":
  IsFalse("Has Diabetes Diagnosis Value")

define "Diabetes Diagnosis Unknown":
  IsNull("Has Diabetes Diagnosis Value")

define "Most Recent A1c > 8":
  SPF.GetFirstObs([Observation: FHIRHelpers.ToCode(First(Concepts."Most Recent A1c > 8 Assertion".coding))])

define "Qualifying A1c > 8":
  if not "Most Recent A1c > 8" is null
    then "Most Recent A1c > 8"
  else
    CFC.CaseFeatureObservation(
      Concepts."Most Recent A1c > 8 Assertion",
      SPF."Has Most Recent A1c > 8", 
      FHIRHelpers.ToDateTime("Most Recent A1c > 8".effective as FHIR.dateTime),
      'http://example.org/sdh/demo/sglt2i/StructureDefinition/sglt2i-qualifying-a1c-casefeature-definition',
      SPF.GetFirstObs(SPF."A1c Observations"),
      ''
    )

define "Has Qualifying A1c > 8 Value":
  "Qualifying A1c > 8".value.value as System.Boolean

define "Has Qualifying A1c > 8":
  IsTrue("Has Qualifying A1c > 8 Value")

define "Does Not Have Qualifying A1c > 8":
  IsFalse("Has Qualifying A1c > 8 Value")

define "Qualifying A1c Unknown":
  IsNull("Has Qualifying A1c > 8 Value")

define "Most Recent Two eGFR < 90 With Dates 3 Months Apart":
  CFC.MostRecent([Observation: FHIRHelpers.ToCode(First(Concepts."Qualifying Two eGFR < 90 With Dates 3 Months Apart Assertion".coding))])

define "Qualifying Two eGFR < 90 With Dates 3 Months Apart":
  if not "Most Recent Two eGFR < 90 With Dates 3 Months Apart" is null
    then "Most Recent Two eGFR < 90 With Dates 3 Months Apart"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying Two eGFR < 90 With Dates 3 Months Apart Assertion",
      SPF."Has Two eGFR < 90 With Dates 3 Months Apart", 
      FHIRHelpers.ToDateTime("Most Recent Two eGFR < 90 With Dates 3 Months Apart".effective as FHIR.dateTime),
      'http://example.org/sdh/demo/sglt2i/StructureDefinition/sglt2i-two-qualifying-egfr-casefeature-definition',
      SPF.GetFirstObs(SPF."Two eGFR < 90 With Dates 3 Months Apart"),
      ''
    )

define "Has Two eGFR < 90 With Dates 3 Months Apart Value":
  "Qualifying Two eGFR < 90 With Dates 3 Months Apart".value.value as System.Boolean

define "Has Two eGFR < 90 With Dates 3 Months Apart":
  IsTrue("Has Two eGFR < 90 With Dates 3 Months Apart Value")

define "Does Not Have Two eGFR < 90 With Dates 3 Months Apart":
  IsFalse("Has Two eGFR < 90 With Dates 3 Months Apart Value")

define "Unknown Two eGFR < 90 With Dates 3 Months Apart":
  IsNull("Has Two eGFR < 90 With Dates 3 Months Apart Value")

define "Most Recent Two uACR > 30 With Dates 3 Months Apart":
  SPF.GetFirstObs([Observation: FHIRHelpers.ToCode(First(Concepts."Qualifying Two uACR > 30 With Dates 3 Months Apart Assertion".coding))])

define "Qualifying Two uACR > 30 With Dates 3 Months Apart":
  if not "Most Recent Two uACR > 30 With Dates 3 Months Apart" is null
    then "Most Recent Two uACR > 30 With Dates 3 Months Apart"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying Two uACR > 30 With Dates 3 Months Apart Assertion",
      SPF."Has Two uACR > 30 With Dates 3 Months Apart", 
      FHIRHelpers.ToDateTime("Most Recent Two uACR > 30 With Dates 3 Months Apart".effective as FHIR.dateTime),
      'http://example.org/sdh/demo/sglt2i/StructureDefinition/sglt2i-two-qualifying-uacr-casefeature-definition',
      SPF.GetFirstObs(SPF."Two uACR > 30 With Dates 3 Months Apart"),
      ''
    )

define "Has Two uACR > 30 With Dates 3 Months Apart Value":
  "Qualifying Two uACR > 30 With Dates 3 Months Apart".value.value as System.Boolean

define "Has Two uACR > 30 With Dates 3 Months Apart":
  IsTrue("Has Two uACR > 30 With Dates 3 Months Apart Value")

define "Does Not Have Two uACR > 30 With Dates 3 Months Apart":
  IsFalse("Has Two uACR > 30 With Dates 3 Months Apart Value")

define "Unknown Two uACR > 30 With Dates 3 Months Apart":
  IsNull("Has Two uACR > 30 With Dates 3 Months Apart Value")

define "Most Recent Qualifying CKD Diagnosis":
  SPF.GetFirstObs([Observation: FHIRHelpers.ToCode(First(Concepts."Qualifying CKD Diagnosis Assertion".coding))])

define "Qualifying CKD Diagnosis":
  if not "Most Recent Qualifying CKD Diagnosis" is null
    then "Most Recent Qualifying CKD Diagnosis"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying CKD Diagnosis Assertion",
      SPF."Has CKD Diagnosis", 
      FHIRHelpers.ToDateTime("Most Recent Qualifying CKD Diagnosis".effective as FHIR.dateTime),
      'http://example.org/sdh/demo/sglt2i/StructureDefinition/sglt2i-ckd-diagnosis-casefeature-definition',
      CFC.MostRecent(SPF."CKD Diagnosis"),
      ''
    )

define "Has Qualifying CKD Diagnosis Value":
  "Qualifying CKD Diagnosis".value.value as System.Boolean

define "Has Qualifying CKD Diagnosis":
  IsTrue("Has Qualifying CKD Diagnosis Value")

define "Does Not Have CKD Diagnosis":
  IsFalse("Has Qualifying CKD Diagnosis Value")

define "CKD Diagnosis Unknown":
  IsNull("Has Qualifying CKD Diagnosis Value")

define "Most Recent eGFR < 90":
  SPF.GetFirstObs([Observation: FHIRHelpers.ToCode(First(Concepts."Qualifying Most Recent eGFR < 90 Assertion".coding))])

define "Qualifying Most Recent eGFR < 90":
  if not "Most Recent eGFR < 90" is null
    then "Most Recent eGFR < 90"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying Most Recent eGFR < 90 Assertion",
      SPF."Has eGFR < 90", 
      FHIRHelpers.ToDateTime("Most Recent eGFR < 90".effective as FHIR.dateTime),
      'http://example.org/sdh/demo/sglt2i/StructureDefinition/sglt2i-qualifying-recent-egfr-casefeature-definition',
      SPF.GetFirstObs(SPF."eGFR Observations < 90"),
      ''
    )

define "Has Qualifying eGFR < 90 Value":
  "Qualifying Most Recent eGFR < 90".value.value as System.Boolean

define "Has Qualifying eGFR < 90":
  IsTrue("Has Qualifying eGFR < 90 Value")

define "Does Not Have Qualifying eGFR < 90":
  IsFalse("Has Qualifying eGFR < 90 Value")

define "Qualifying eGFR < 90 Unknown":
  IsNull("Has Qualifying eGFR < 90 Value")

define "Most Recent uACR > 30":
  SPF.GetFirstObs([Observation: FHIRHelpers.ToCode(First(Concepts."Qualifying Most Recent uACR > 30 Assertion".coding))])

define "Qualifying Most Recent uACR > 30":
  if not "Most Recent uACR > 30" is null
    then "Most Recent uACR > 30"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying Most Recent uACR > 30 Assertion",
      SPF."Has Recent uACR > 30", 
      FHIRHelpers.ToDateTime("Most Recent uACR > 30".effective as FHIR.dateTime),
      'http://example.org/sdh/demo/sglt2i/StructureDefinition/sglt2i-qualifying-recent-uacr-casefeature-definition',
      SPF.GetFirstObs(SPF."uACR Observations > 30"),
      ''
    )

define "Has Qualifying uACR > 30 Value":
  "Qualifying Most Recent uACR > 30".value.value as System.Boolean

define "Has Qualifying uACR > 30":
  IsTrue("Has Qualifying uACR > 30 Value")

define "Does Not Have Qualifying uACR > 30":
  IsFalse("Has Qualifying uACR > 30 Value")

define "Qualifying uACR > 30 Unknown":
  IsNull("Has Qualifying uACR > 30 Value")

define "Most Recent Dialysis Procedure":
  SPF.GetFirstObs([Observation: FHIRHelpers.ToCode(First(Concepts."Qualifying Dialysis Procedure Assertion".coding))])

define "Qualifying Dialysis Procedure":
  if not "Most Recent Dialysis Procedure" is null
    then "Most Recent Dialysis Procedure"
  else
    CFC.CaseFeatureObservation(
      Concepts."Qualifying Dialysis Procedure Assertion",
      SPF."On Dialysis", 
      FHIRHelpers.ToDateTime("Most Recent Dialysis Procedure".effective as FHIR.dateTime),
      'http://example.org/sdh/demo/sglt2i/StructureDefinition/sglt2i-dialysis-casefeature-definition',
      CFC.MostRecent(SPF."Dialysis Procedures"),
      ''
    )

define "Has Qualifying Dialysis Procedure Value":
  "Qualifying Dialysis Procedure".value.value as System.Boolean

define "Has Qualifying Dialysis Procedure":
  IsTrue("Has Qualifying Dialysis Procedure Value")

define "Does Not Have Qualifying Dialysis Procedure":
  IsFalse("Has Qualifying Dialysis Procedure Value")

define "Qualifying Dialysis Procedure Unknown":
  IsNull("Has Qualifying Dialysis Procedure Value")




//Approval Logic
define "LineBreak": 
  '\r\n'

//Not Approved Response
define "Not Approved Detail": 
  ' Prior Authorization DENIED.'
    + "LineBreak" + 'Reasoning:'
    + Coalesce(
      if "Does Not Have Diabetes Diagnosis" then "LineBreak" + '- Individual does not have a diagnosis of diabetes.' else null,
      "Not Approved A1c",
      "Not Approved eGFR/uACR Evidence of CKD",
      "Not Approved CKD/eGFR/uACR Evidence of CKD",
      "Not Approved Dialysis"
    )

define "Not Approved A1c":
  if "Does Not Have Qualifying A1c > 8" 
    then "LineBreak" + '- Individual does not have a most recent A1c > 8.'
  else
   ''

define "Not Approved eGFR/uACR Evidence of CKD": 
  if "Does Not Have Two eGFR < 90 With Dates 3 Months Apart"
    then "LineBreak" + '- Individual does not have two eGFRs < 90 with dates 3 months apart.'
  else 
    if "Has Two eGFR < 90 With Dates 3 Months Apart" and "Does Not Have Two uACR > 30 With Dates 3 Months Apart"
      then "LineBreak" + '- Individual does not have two uACRs > 30 with dates 3 months apart.'
  else
    ''

define "Not Approved CKD/eGFR/uACR Evidence of CKD":
  if "Does Not Have CKD Diagnosis"
    then "LineBreak" + '- Individual does not have a qualifying diagnosis of CKD.'
  else 
    if "Has Qualifying CKD Diagnosis" and "Does Not Have Qualifying eGFR < 90"
      then "LineBreak" + '- Individual does not have a most recent eGFR < 90.'
  else 
    if "Has Qualifying CKD Diagnosis" and "Has Qualifying eGFR < 90" and "Does Not Have Qualifying uACR > 30"
      then "LineBreak" + '- Individual does not have a most recent uACR > 30.'
  else
    ''

define "Not Approved Dialysis":
  if "Does Not Have Qualifying Dialysis Procedure"
    then "LineBreak" + '- Individual is not on dialysis.'
  else 
    ''

//Not Approved Null Response
define "Temporarily Not Approved":
  'Prior Authorization PENDING.'
    + "LineBreak" + 'Reasoning:'
    + Coalesce(
      if "Diabetes Diagnosis Unknown" then 'Please enter the following: Diagnosis of diabetes' else null, 
      "Null A1c",
      "Null Two Qualifying eGFR/uACR",
      "Null CKD diagnosis, eGFR, or uACR"
      "Null Dialysis"
    )

define "Null A1c":
  if "Qualifying A1c Unknown"
    then "LineBreak" + ' - Please enter the following: A1c' 
  else 
    ''

define "Null Two Qualifying eGFR/uACR":
  if "Unknown Two eGFR < 90 With Dates 3 Months Apart" 
    then "LineBreak" + ' - Please enter the following: two eGFR < 90 with dates 3 months apart' 
  else 
    if "Unknown Two uACR > 30 With Dates 3 Months Apart"
      then "LineBreak" + 'Please enter the following: two uACR > 30 with dates 3 months apart' 
  else 
    ''

define "Null CKD diagnosis, eGFR, or uACR":
  if "CKD Diagnosis Unknown"
    then "LineBreak" + 'Please enter the following: diagnosis of CKD' 
  else 
    if "Qualifying eGFR < 90 Unknown" 
      then "LineBreak" + ' - Please enter the following: eGFR that is less than 90' 
  else 
    if "Qualifying uACR > 30 Unknown"
      then "LineBreak" + 'Please enter the following: uACR that is greater than 30' 
  else 
    ''

define "Null Dialysis":
  if "Qualifying Dialysis Procedure Unknown"
    then "LineBreak" + ' - Please enter the following: if patient is on dialysis' 
  else 
    ''

//Approved Response
define "Approved Detail":
  'Prior Authorization APPROVED.'
    + "LineBreak" + 'Reasoning:'
    + "Approved Diabetes Diagnosis"
    + "Approved A1c"
    + "Approved 2 Qualifying eGFR and 2 Qualifying uACR"
    + "Approved CKD Diagnosis With 1 Qualifying eGFR and 1 Qualifying uACR"
    + "Approved Dialysis"

define "Approved Diabetes Diagnosis":
  if "Has Diabetes Diagnosis"
    then "LineBreak" + '- Has qualifying diabetes diagnosis'
  else 
    ''

define "Approved A1c":
  if "Has Qualifying A1c > 8"
    then "LineBreak" + '- Individual has qualifying A1c level of > 8'
  else
    ''

define "Approved 2 Qualifying eGFR and 2 Qualifying uACR":
  if "Has Two eGFR < 90 With Dates 3 Months Apart" and "Has Two uACR > 30 With Dates 3 Months Apart"
    then "LineBreak" + '- Individual has two qualifying eGFR < 90 with dates 3 months apart and two qualifying uACR > 30 with dates 3 months apart'
  else 
    ''

define "Approved CKD Diagnosis With 1 Qualifying eGFR and 1 Qualifying uACR":
  if "Has Qualifying CKD Diagnosis" and "Has Qualifying eGFR < 90" and "Has Qualifying uACR > 30"
    then "LineBreak" + '- Individual has a qualifying diagnosis of CKD, a most recent eGFR < 90, and a most recent uACR > 30'
  else 
    ''

define "Approved Dialysis":
  if "Has Qualifying Dialysis Procedure"
    then "LineBreak" + '- Individual is on dialysis'
  else 
    ''