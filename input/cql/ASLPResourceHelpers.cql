library ASLPResourceHelpers version '0.1.0'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

using FHIR version '4.0.1'

define function BillingExtensionValue(exts List<FHIR.Extension>)
returns FHIR.CodeableConcept:
  First(
    from exts E
      where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
      return E.value as FHIR.CodeableConcept
  )

define function hasBillingExtension(exts List<FHIR.Extension>) 
returns System.Boolean:
  BillingExtensionValue(exts) is not null

define function BillingOptionExtensionPresent(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>)
returns System.Boolean:
  if requestItem is FHIR.MedicationRequest then 
    ((requestItem as FHIR.MedicationRequest).medication) is FHIR.CodeableConcept
    and hasBillingExtension(((requestItem as FHIR.MedicationRequest).medication as FHIR.CodeableConcept).extension)
  else if requestItem is FHIR.VisionPrescription then 
    exists (((requestItem as FHIR.VisionPrescription).lensSpecification) LS 
      where hasBillingExtension(LS.extension)
    )
  else if requestItem is FHIR.ServiceRequest then 
    hasBillingExtension((requestItem as FHIR.ServiceRequest).extension)
  else if requestItem is FHIR.NutritionOrder then 
    hasBillingExtension((requestItem as FHIR.NutritionOrder).oralDiet.extension)
    or hasBillingExtension((requestItem as FHIR.NutritionOrder).enteralFormula.extension)
    or exists (
      ((requestItem as FHIR.NutritionOrder).supplement) S
        where hasBillingExtension(S.extension)
    )
  else if requestItem is FHIR.DeviceRequest then
    hasBillingExtension((requestItem as FHIR.DeviceRequest).extension)
  else if requestItem is FHIR.CommunicationRequest then 
    hasBillingExtension((requestItem as FHIR.CommunicationRequest).extension)
    or exists (((requestItem as FHIR.CommunicationRequest).payload) P
      where hasBillingExtension(P.extension)
    )
  else if requestItem is FHIR.Appointment then 
    hasBillingExtension((requestItem as FHIR.Appointment).extension)
  else if requestItem is FHIR.Task then 
    hasBillingExtension((requestItem as FHIR.Task).extension)
    or exists (((requestItem as FHIR.Task).input) I
      where hasBillingExtension(I.extension)
    )
  else false

define function "ReturnBillingExtensionValueFor"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>)
returns FHIR.CodeableConcept:
  if requestItem is FHIR.NutritionOrder then
    Coalesce(
      BillingExtensionValue((requestItem as FHIR.NutritionOrder).oralDiet.extension),
      BillingExtensionValue((requestItem as FHIR.NutritionOrder).enteralFormula.extension),
      First(
        from ((requestItem as FHIR.NutritionOrder).supplement) S
          let v: BillingExtensionValue(S.extension)
          where v is not null
          return v
      )
    )
  else if requestItem is FHIR.ServiceRequest then
    BillingExtensionValue((requestItem as FHIR.ServiceRequest).extension)
  else if requestItem is FHIR.DeviceRequest then
    BillingExtensionValue((requestItem as FHIR.DeviceRequest).extension)
  else if requestItem is FHIR.MedicationRequest then
    BillingExtensionValue(((requestItem as FHIR.MedicationRequest).medication as FHIR.CodeableConcept).extension)
  else if requestItem is FHIR.VisionPrescription then
    First(
      from ((requestItem as FHIR.VisionPrescription).lensSpecification) L
        let v: BillingExtensionValue(L.extension)
        where v is not null
        return v
    )
  else if requestItem is FHIR.CommunicationRequest then
    Coalesce(
      BillingExtensionValue((requestItem as FHIR.CommunicationRequest).extension),
      First(
        from ((requestItem as FHIR.CommunicationRequest).payload) P
          let v: BillingExtensionValue(P.extension)
          where v is not null
          return v
      )
    )
  else if requestItem is FHIR.Appointment then
    BillingExtensionValue((requestItem as FHIR.Appointment).extension)
  else if requestItem is FHIR.Task then
    First(
      from ((requestItem as FHIR.Task).input) I
        let v: BillingExtensionValue(I.extension)
        where v is not null
        return v
    )
  else null as FHIR.CodeableConcept