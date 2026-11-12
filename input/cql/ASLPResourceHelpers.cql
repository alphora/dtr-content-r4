library ASLPResourceHelpers version '0.1.0'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

using FHIR version '4.0.1'

define function GetCode(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>)
returns FHIR.CodeableConcept:
  if (item is FHIR.ServiceRequest) then
    if (item as FHIR.ServiceRequest).code is FHIR.CodeableConcept then 
      (item as FHIR.ServiceRequest).code as FHIR.CodeableConcept 
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.DeviceRequest) then
    if (item as FHIR.DeviceRequest).code is FHIR.CodeableConcept then
      (item as FHIR.DeviceRequest).code as FHIR.CodeableConcept
    else if (item as FHIR.DeviceRequest).code is FHIR.Reference then
      if exists ([Device]) then
        from [Device] D
            where ((item as FHIR.DeviceRequest).code as FHIR.Reference).reference = 'Device/' + D.id
            or ((item as FHIR.DeviceRequest).code as FHIR.Reference).reference = 'Device/' + FHIRHelpers.ToString(D.id)
            // or D.id in ref.reference
        return D.type
      else
        null as FHIR.CodeableConcept
      // ([Device: id ~ ((item as FHIR.DeviceRequest).code as FHIR.Reference).reference]).type
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.NutritionOrder) then
    if (item as FHIR.NutritionOrder).enteralFormula.baseFormulaType is FHIR.CodeableConcept then 
      (item as FHIR.NutritionOrder).enteralFormula.baseFormulaType as FHIR.CodeableConcept
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.MedicationRequest) then 
    if (item as FHIR.MedicationRequest).medication is FHIR.CodeableConcept then
      (item as FHIR.MedicationRequest).medication as FHIR.CodeableConcept
    else if (item as FHIR.MedicationRequest).medication is FHIR.Reference then
      if exists ([Medication]) then 
          First(
            from [Medication] M 
            where ((item as FHIR.MedicationRequest).medication as FHIR.Reference).reference = 'Medication/' + M.id
            or ((item as FHIR.MedicationRequest).medication as FHIR.Reference).reference = 'Medication/' + FHIRHelpers.ToString(M.id)
            // or M.id in ref.reference
            return M.code
          )
      else 
        null as FHIR.CodeableConcept
      // ([MedicationRequest: id ~ ((item as FHIR.MedicationRequest).medication as FHIR.Reference).reference])
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.VisionPrescription) then 
    if (exists ((item as FHIR.VisionPrescription).lensSpecification) LS 
      where exists ((LS.extension) E 
        where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
      )
    ) then 
        First(
          from ((item as FHIR.VisionPrescription).lensSpecification) LS 
          let billingExt: First(
              (LS.extension) E
                where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
                  and E.value is not null
          )
            where billingExt is not null
          return billingExt.value as FHIR.CodeableConcept
        )         
    else if exists ((item as FHIR.VisionPrescription).lensSpecification) LS
      where not exists ((LS.extension) E 
        where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
      ) then
          First(
            from ((item as FHIR.VisionPrescription).lensSpecification) LS 
              where exists ((LS.extension) E 
                where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
              )
              and LS.product is not null
            return 
              LS.product
          )
    else
      null as FHIR.CodeableConcept
  else if (item is FHIR.Appointment) then 
    if exists ((item as FHIR.Appointment).basedOn) then 
      if exists ([ServiceRequest]) then
        First(
          from ([ServiceRequest]) SR
            where exists (((item as FHIR.Appointment).basedOn) b 
                where b.reference = 'ServiceRequest/' + SR.id 
                or EndsWith(b.reference, '/' + SR.id)
            )
          return 
            SR.code
        )
      else 
        null as FHIR.CodeableConcept
    else if exists ((item as FHIR.Appointment).serviceType) then 
      First((item as FHIR.Appointment).serviceType)
    else 
      null as FHIR.CodeableConcept
  else if (item is FHIR.Task) then 
    (item as FHIR.Task).code
  else null as FHIR.CodeableConcept

define function hasBillingExtension(exts List<FHIR.Extension>) returns System.Boolean:
  exists(
    exts E 
      where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
  )

define function BillingOptionExtensionPresent(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>):
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
  else null

define function "ReturnBillingExtensionValueFor"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>)
returns FHIR.CodeableConcept:
  if requestItem is FHIR.NutritionOrder then
    Coalesce(
      (
        First(
          from (requestItem as FHIR.NutritionOrder).oralDiet.extension E
            where hasBillingExtension((requestItem as FHIR.NutritionOrder).oralDiet.extension)
          return E.value as FHIR.CodeableConcept
        )
      ),
      (
        First(
          from (requestItem as FHIR.NutritionOrder).enteralFormula.extension E
            where hasBillingExtension((requestItem as FHIR.NutritionOrder).enteralFormula.extension)
          return E.value as FHIR.CodeableConcept
        )
      ),
      (
        First(
          flatten (
            (requestItem as FHIR.NutritionOrder).supplement S
              return S.extension
          ) E
            where hasBillingExtension(E)
            return E.value as FHIR.CodeableConcept
        )
      )
    )
  else if requestItem is FHIR.ServiceRequest then
    (
      First(
        from (requestItem as FHIR.ServiceRequest).extension E
          where hasBillingExtension((requestItem as FHIR.ServiceRequest).extension)
        return E.value as FHIR.CodeableConcept
      )
    )
  else if requestItem is FHIR.DeviceRequest then
    (
      First(
        from (requestItem as FHIR.DeviceRequest).extension E
          where hasBillingExtension((requestItem as FHIR.DeviceRequest).extension)
        return E.value as FHIR.CodeableConcept
      )
    )
  else if requestItem is FHIR.MedicationRequest then
    (
      First(
        from ((requestItem as FHIR.MedicationRequest).medication as FHIR.CodeableConcept).extension E
          where hasBillingExtension(((requestItem as FHIR.MedicationRequest).medication as FHIR.CodeableConcept).extension)
        return E.value as FHIR.CodeableConcept
      )
    )
  else if requestItem is FHIR.VisionPrescription then
    (
      First(
        from (requestItem as FHIR.VisionPrescription).lensSpecification L
          where hasBillingExtension(L.extension)
        return L.extension.value as FHIR.CodeableConcept
      )
    )
  else if requestItem is FHIR.CommunicationRequest then 
    (
      First(
        from (requestItem as FHIR.CommunicationRequest).payload P
          where hasBillingExtension(P.extension)
        return P.extension.value as FHIR.CodeableConcept
      )
    )
  else if requestItem is FHIR.Appointment then 
    (
      First(
        from (requestItem as FHIR.Appointment).extension E
          where hasBillingExtension((requestItem as FHIR.Appointment).extension)
        return E.value as FHIR.CodeableConcept
      )
    )
  else if requestItem is FHIR.Task then
    (
      First(
        from (requestItem as FHIR.Task).input I
          where hasBillingExtension(I.extension)
        return I.extension.value as FHIR.CodeableConcept
      )
    )
  else null as FHIR.CodeableConcept