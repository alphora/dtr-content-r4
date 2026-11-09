library ASLPCrdAppointmentWarningsLogic version '0.1.0'

using FHIR version '4.0.1'

include hl7.fhir.uv.cql.FHIRHelpers version '4.0.1' called FHIRHelpers
include ASLPContext version '0.1.0' called Ctx

context Patient

define "CPT System":
  'http://www.ama-assn.org/go/cpt'

/* ==========================================================================
   CHECK 1 - TIMING INTERVAL VIOLATION
   ========================================================================== */
    // minimum days between services with the same CPT code. CPT codes not listed here are NOT checked. 
    // ServiceRequest.status values that count as "a prior service"

define "Minimum Interval Config":
  {
    Tuple { cptCode: '95810', minIntervalDays: 365 },
    Tuple { cptCode: '95811', minIntervalDays: 365 },
    Tuple { cptCode: '95806', minIntervalDays: 180 },
    Tuple { cptCode: '95800', minIntervalDays: 180 }
  }

define "Prior Service Statuses":
  { 'completed' }

define function "Minimum Interval Days"(codeValue System.String) 
returns System.Integer:
    First(("Minimum Interval Config") C 
        where C.cptCode = codeValue 
        return C.minIntervalDays
    )

// CPT codings for the appointment (via basedOn ServiceRequest.code or serviceType)
define function "Appointment CPT Codes"(appt FHIR.Appointment) 
returns List<System.Code>:
  (Ctx.GetCode(appt).coding) c
    where c.system.value = "CPT System"
    return FHIRHelpers.ToCode(c)

define function "ServiceRequest Date"(sr FHIR.ServiceRequest) 
returns System.DateTime:
    Coalesce(
        Coalesce(
            (sr.occurrence as FHIR.dateTime).value,
            (sr.occurrence as FHIR.Period).end.value,
            (sr.occurrence as FHIR.Period).start.value
        ),
        Coalesce(
            Max(((sr.occurrence as FHIR.Timing).event) E return E.value),
            ((sr.occurrence as FHIR.Timing).repeat.bounds as FHIR.Period).end.value,
            ((sr.occurrence as FHIR.Timing).repeat.bounds as FHIR.Period).start.value
        )
    )

// The ServiceRequest this appointment is being booked for must not count as a "prior" service
define function "Appointment Based On"(appt FHIR.Appointment, sr FHIR.ServiceRequest) 
returns System.Boolean:
  exists ((appt.basedOn) b
    where Last(Split(b.reference.value, '/')) = sr.id.value
  )

define function "Prior Service Dates"(appt FHIR.Appointment, codeValue System.String)
returns List<System.DateTime>:
  (
    (Ctx."Provider"."ServiceRequests" union [ServiceRequest]) SR
      where SR.status.value in "Prior Service Statuses"
        and exists ((SR.code.coding) c
          where c.system.value = "CPT System" 
          and c.code.value = codeValue
        )
        and not "Appointment Based On"(appt, SR)
      return "ServiceRequest Date"(SR)
  ) occ
    where occ is not null
      and occ < appt.start.value
    return occ

define function "Last Service Date"(appt FHIR.Appointment, codeValue System.String)
returns System.Date:
  date from Max("Prior Service Dates"(appt, codeValue))

define function "Requested Date"(appt FHIR.Appointment)
returns System.Date:
  date from appt.start.value

define function "Elapsed Days Since Last Service"(appt FHIR.Appointment, codeValue System.String)
returns System.Integer:
  days between "Last Service Date"(appt, codeValue) and "Requested Date"(appt)

define function "Timing Violations For"(appt FHIR.Appointment):
  ("Appointment CPT Codes"(appt)) cpt
    where "Minimum Interval Days"(cpt.code) is not null
      and "Last Service Date"(appt, cpt.code) is not null
      and "Elapsed Days Since Last Service"(appt, cpt.code) < "Minimum Interval Days"(cpt.code)
    return Tuple {
      cptCode: cpt.code,
      lastServiceDate: "Last Service Date"(appt, cpt.code),
      requestedDate: "Requested Date"(appt),
      elapsedDays: "Elapsed Days Since Last Service"(appt, cpt.code),
      minIntervalDays: "Minimum Interval Days"(cpt.code)
    }

define "Timing Interval Violations":
    Flatten(Ctx."Appointments List" appt 
        return "Timing Violations For"(appt)
    )

define "Timing Interval Violation Exists":
  exists "Timing Interval Violations"

define "Timing Interval Violation Description":
  'The requested appointment falls within the minimum interval since the last service with the same CPT code. '
    + Combine(
        ("Timing Interval Violations") V
          return 'CPT ' + V.cptCode
            + ': last service ' + ToString(V.lastServiceDate)
            + ', requested ' + ToString(V.requestedDate)
            + ' (' + ToString(V.elapsedDays) + ' of ' + ToString(V.minIntervalDays) + ' required days).',
        ' '
      )

/* ==========================================================================
   RULE 2 - OUT-OF-NETWORK LOCATION
   ========================================================================== */
    //// Check 2: extension(s) on Location that carry the network name/code as string/code.
    // if Coverage.network is missing, true => warn anyway, false => skip the check

define "Location Network Extension URL":
  'http://example.org/sdh/dtr/aslp/StructureDefinition/location-network'

define "Plan-Net Network Extension URL":
  'http://hl7.org/fhir/us/davinci-pdex-plan-net/StructureDefinition/network-reference'

define "Warn When Network Cannot Be Determined":
  true

define "Network Coverage":
    Coalesce(
        First(Ctx."Payor"."Coverages"), 
        First(Ctx."Provider"."Coverages")
    )

define "Coverage Network":
  "Network Coverage".network.value

define "All Locations":
  Ctx."Provider"."Locations" 
  union [Location]

define "All Organizations":
  Ctx."Provider"."Organizations" 
  union Ctx."Payor"."Organizations" 
  union [Organization]

define function "Network Organizations"(loc FHIR.Location) 
returns List<FHIR.Organization>:
  "All Organizations" O
    where exists ((loc.extension) E
      where E.url.value = "Plan-Net Network Extension URL"
        and EndsWith((E.value as FHIR.Reference).reference.value, 'Organization/' + O.id.value)
    )

define function "Network Organization Names"(loc FHIR.Location)
returns List<System.String>:
  (("Network Organizations"(loc)) O
    return O.name.value
  )

define function "Network Organization Identifiers"(loc FHIR.Location)
returns List<System.String>:
  ((("Network Organizations"(loc)).identifier) I
    return I.value.value
  )

define function "Network Extension Strings"(loc FHIR.Location)
returns List<System.String>:
  ((loc.extension) E
    where E.url.value = "Location Network Extension URL"
    return Coalesce(
      (E.value as FHIR.string).value,
      (E.value as FHIR.code).value
    )
  )
  
// Every string by which this Location can be tied to a network:
//  - simple string/code location-network extension
//  - name and identifiers of Organization(s) referenced via the Plan-Net network-reference extension
define function "Network Strings"(loc FHIR.Location)
returns List<System.String>:
  "Network Extension Strings"(loc)
    union "Network Organization Names"(loc)
    union "Network Organization Identifiers"(loc)

define function "Location Network Keys"(locationId System.String) 
returns List<System.String>:
    Flatten(("All Locations") L 
        where L.id.value = locationId 
        return "Network Strings"(L)
    )

define function "Location In Network"(locationId System.String) 
returns System.Boolean:
    exists (("Location Network Keys"(locationId)) K 
        where K ~ "Coverage Network"
    )

define function "Location Reference IDs"(appt FHIR.Appointment) 
returns List<System.String>:
  (appt.participant) p
    where p.actor.reference.value is not null
      and PositionOf('Location/', p.actor.reference.value) >= 0
    return Last(Split(p.actor.reference.value, '/'))

define function "Out Of Network Locations For"(appt FHIR.Appointment) 
returns List<System.String>:
  ("Location Reference IDs"(appt)) locId
    where ("Coverage Network" is not null or "Warn When Network Cannot Be Determined")
      and not "Location In Network"(locId)
    return locId

define "Out Of Network Locations":
    Flatten(Ctx."Appointments List" appt 
        return "Out Of Network Locations For"(appt)
    )

define "Out Of Network Location Exists":
  exists "Out Of Network Locations"

define "Out Of Network Location Description":
  'The following location(s) are out of network with the patient coverage network ('
    + Coalesce("Coverage Network", 'not specified') + '): '
    + Combine(("Out Of Network Locations") L return 'Location/' + L, ', ')
    + '.'

/* ==========================================================================
   RULE 3 - MISSING REQUIRED PRACTITIONER (PrimaryPerformer)
   ========================================================================== */
    // Check 3: participant.type code(s) that identify the PrimaryPerformer slice

define "Participation Type System":
  'http://terminology.hl7.org/CodeSystem/v3-ParticipationType'

define "Primary Performer Codes":
  { 'PPRF' }

define function "Primary Performer Participants"(appt FHIR.Appointment):
  (appt.participant) p
    where exists ((p.type) t
      where exists ((t.coding) c
        where c.system.value = "Participation Type System"
          and c.code.value in "Primary Performer Codes"
      )
    )

define function "Valid Practitioner Reference"(actor FHIR.Reference) 
returns System.Boolean:
  actor is not null
    and actor.reference.value is not null
    and (
      PositionOf('Practitioner/', actor.reference.value) >= 0
      or PositionOf('PractitionerRole/', actor.reference.value) >= 0
    )
    and (
        exists (
            (Ctx."Provider"."Practitioners" 
            union Ctx."Provider"."PractitionerRoles") R
                where EndsWith(actor.reference.value, '/' + R.id.value)
        )
    )

define function "Has Valid Primary Performer"(appt FHIR.Appointment) 
returns System.Boolean:
  exists (("Primary Performer Participants"(appt)) p
    where "Valid Practitioner Reference"(p.actor)
  )

define "Appointments Missing Primary Performer":
  Ctx."Appointments List" appt
    where not "Has Valid Primary Performer"(appt)
    return Coalesce(appt.id.value, '(new appointment)')

define "Missing Required Practitioner Exists":
  exists "Appointments Missing Primary Performer"

define "Missing Required Practitioner Description":
  'A PrimaryPerformer participant with a valid Practitioner or PractitionerRole reference is required but missing on: '
    + Combine("Appointments Missing Primary Performer", ', ')
    + '.'