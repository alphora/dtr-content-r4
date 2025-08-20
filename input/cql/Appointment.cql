library Appointment

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'

context Patient

define "Next Open Slot":
  First(
    [Slot] S
      where S.status = 'free'
        and S.start in Interval[Now(), Now() + 14 days]
    sort by start 
  )

define "ProposedAppointment": FHIR.Appointment {
  status = 'proposed',
  serviceType = { "RequestedServiceType" },
  start = if "NextOpenSlot" is null then null else "NextOpenSlot".start,
  end   = if "NextOpenSlot" is null then null else "NextOpenSlot".end,
  participant = {
    FHIR.Appointment.participant {
      actor = ToReference(Patient),          // subject
      status = 'needs-action'
    },
    FHIR.Appointment.participant {
      actor = "RequestedPractitioner",
      status = 'needs-action'
    },
    FHIR.Appointment.participant {
      actor = "RequestedLocation",
      status = 'needs-action'
    }
  }
}

//there is a service request 
    //appointment.basedOn = servicerequest
    //create appointment