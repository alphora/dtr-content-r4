library ASLPResourceHelpers version '0.1.0'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1'

using FHIR version '4.0.1'

// define function GetCode(item Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription, FHIR.CommunicationRequest, FHIR.Appointment, FHIR.Task>)
// returns FHIR.CodeableConcept:
//   if (item is FHIR.ServiceRequest) then
//     if (item as FHIR.ServiceRequest).code is FHIR.CodeableConcept then 
//       (item as FHIR.ServiceRequest).code as FHIR.CodeableConcept 
//     else 
//       null as FHIR.CodeableConcept
//   else if (item is FHIR.DeviceRequest) then
//     if (item as FHIR.DeviceRequest).code is FHIR.CodeableConcept then
//       (item as FHIR.DeviceRequest).code as FHIR.CodeableConcept
//     else if (item as FHIR.DeviceRequest).code is FHIR.Reference then
//       if exists ([Device]) then
//         First(
//           [Device] D
//             where FHIRHelpers.ToString(((item as FHIR.DeviceRequest).code as FHIR.Reference).reference) = 'Device/' + FHIRHelpers.ToString(D.id)
//             return D.type
//         )
//       else
//         null as FHIR.CodeableConcept
//       // ([Device: id ~ ((item as FHIR.DeviceRequest).code as FHIR.Reference).reference]).type
//     else 
//       null as FHIR.CodeableConcept
//   else if (item is FHIR.NutritionOrder) then
//     if (item as FHIR.NutritionOrder).enteralFormula.baseFormulaType is FHIR.CodeableConcept then 
//       (item as FHIR.NutritionOrder).enteralFormula.baseFormulaType as FHIR.CodeableConcept
//     else if exists ((item as FHIR.NutritionOrder).supplement) then
//       First(
//         from ((item as FHIR.NutritionOrder).supplement) S
//           where S.type is not null
//         return S.type
//       )
//     else if ((item as FHIR.NutritionOrder).oralDiet) is not null 
//       and exists ((item as FHIR.NutritionOrder).oralDiet.type) then
//         First((item as FHIR.NutritionOrder).oralDiet.type)
//     else 
//       null as FHIR.CodeableConcept
//   else if (item is FHIR.MedicationRequest) then 
//     if (item as FHIR.MedicationRequest).medication is FHIR.CodeableConcept then
//       (item as FHIR.MedicationRequest).medication as FHIR.CodeableConcept
//     else if (item as FHIR.MedicationRequest).medication is FHIR.Reference then
//       if exists (
//         ContextProvider."Provider"."Medications"
//         union [Medication]
//       ) then 
//           First(
//             (ContextProvider."Provider"."Medications" union [Medication]) M
//               where FHIRHelpers.ToString(((item as FHIR.MedicationRequest).medication as FHIR.Reference).reference) = 'Medication/' + FHIRHelpers.ToString(M.id)
//               return M.code
//           )
//       else 
//         null as FHIR.CodeableConcept
//       // ([MedicationRequest: id ~ ((item as FHIR.MedicationRequest).medication as FHIR.Reference).reference])
//     else 
//       null as FHIR.CodeableConcept
//   else if (item is FHIR.VisionPrescription) then 
//     if (exists (
//       ((item as FHIR.VisionPrescription).lensSpecification) LS
//         where exists (LS.extension E 
//           where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
//         )
//       )
//     ) then 
//         First(
//           from ((item as FHIR.VisionPrescription).lensSpecification) LS 
//           let billingExt: First(
//               (LS.extension) E
//                 where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
//                   and E.value is not null
//           )
//             where billingExt is not null
//           return billingExt.value as FHIR.CodeableConcept
//         )  
//     else if exists (
//       ((item as FHIR.VisionPrescription).lensSpecification) LS
//         where not exists (
//           LS.extension E
//             where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
//         )
//     ) then
//       First(
//         from ((item as FHIR.VisionPrescription).lensSpecification) LS
//           where not exists (
//             LS.extension E
//               where E.url = 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/ext-billing-options'
//           )
//           and LS.product is not null
//         return LS.product
//       )       
//     else
//       null as FHIR.CodeableConcept
//   else if (item is FHIR.Appointment) then 
//     if exists ((item as FHIR.Appointment).basedOn) then 
//       if exists (
//         ContextProvider."Provider"."ServiceRequests"
//         union ("draftOrders" O
//           where O is FHIR.ServiceRequest
//           return O as FHIR.ServiceRequest
//         )
//         union [ServiceRequest] 
//       ) then
//         First(
//           (
//             ContextProvider."Provider"."ServiceRequests" 
//             union ("draftOrders" O
//               where O is FHIR.ServiceRequest
//               return O as FHIR.ServiceRequest
//             )
//             union [ServiceRequest]
//           ) SR
//             where exists (((item as FHIR.Appointment).basedOn) b
//               where b.reference is not null
//               and FHIRHelpers.ToString(b.reference) = 'ServiceRequest/' + FHIRHelpers.ToString(SR.id)
//             )
//         ).code
//       else if exists ((item as FHIR.Appointment).serviceType) then 
//         First((item as FHIR.Appointment).serviceType)
//       else
//         null as FHIR.CodeableConcept 
//     else if exists ((item as FHIR.Appointment).serviceType) then 
//       First((item as FHIR.Appointment).serviceType)
//     else 
//       null as FHIR.CodeableConcept
//   else if (item is FHIR.Task) then 
//     (item as FHIR.Task).code
//   else null as FHIR.CodeableConcept

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