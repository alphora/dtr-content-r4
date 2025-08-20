library Appointment

using FHIR version '4.0.1'

include FHIRHelpers version '4.1.000'

context Patient


define "Title":
  'Appointment Booking'

define "Description":
  'Information related to appointment booking'

define "Proposed":
    'proposed'

define "Request Items":
    [NutritionOrder]
    union [ServiceRequest]
    union [DeviceRequest]
    union [MedicationRequest]
    union [VisionPrescription]

// define "Next Open Slot":
//   First(
//     [Slot] S
//       where S.status = 'free'
//         and S.start in Interval[Now(), Now() + 14 days]
//     sort by start 
//   )

define "AppointmentList":
    if "Request Items" is null 
    or not exists("Request Items") then
        { 
            FHIR.Extension {
                "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-appointment-with-order' },
                "value": FHIR.string { "value": 'N/A' }
            }
        }
    else
        from "Request Items" request
        // where request is ServiceRequest
        return "GetAppointmentExtension"(request)

define function "GetAppointmentExtension"(requestItem Choice<FHIR.NutritionOrder, FHIR.ServiceRequest, FHIR.DeviceRequest, FHIR.MedicationRequest, FHIR.VisionPrescription>):
// returns FHIR.Extension
    if exists ([Appointment] A
        where A.basedOn.type is "ServiceRequest" ) then 
        FHIR.Extension {
            "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-appointment-with-order' },
            "extension": ({ 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'service type' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'ServiceRequest/' + requestItem.id }
                    }
                },
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'start' },
                    "value": FHIR.date { "value":  Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'end' },
                    "value": FHIR.date { "value": Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'practitioner' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'Practitioner/' + First(requestItem.performer).reference }
                    }
                }
            })
        }
    else if exists ([Appointment] A
        where A.basedOn.type is "NutritionOrder") then 
        FHIR.Extension {
            "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-appointment-with-order' },
            "extension": ({ 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'service type' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'NutritionOrder/' + requestItem.id }
                    }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'start' },
                    "value": FHIR.date { "value":  Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'end' },
                    "value": FHIR.date { "value": Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'practitioner' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'Practitioner/' + requestItem.orderer.reference }
                    }
                }
            })
        }
    else if exists ([Appointment] A
        where A.basedOn.type is "DeviceRequest") then 
        FHIR.Extension {
            "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-appointment-with-order' },
            "extension": ({ 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'service type' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'DeviceRequest/' + requestItem.id }
                    }
                }, 
                 FHIR.Extension {
                    "url": FHIR.uri { "value": 'start' },
                    "value": FHIR.date { "value":  Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'end' },
                    "value": FHIR.date { "value": Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'practitioner' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'Practitioner/' + First(requestItem.performer).reference }
                    }
                }
            })
        }
    else if exists ([Appointment] A
        where A.basedOn.type is "MedicationRequest") then 
        FHIR.Extension {
            "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-appointment-with-order' },
            "extension": ({ 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'service type' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'MedicationRequest/' + requestItem.id }
                    }
                }, 
                 FHIR.Extension {
                    "url": FHIR.uri { "value": 'start' },
                    "value": FHIR.date { "value":  Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'end' },
                    "value": FHIR.date { "value": Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'practitioner' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'Practitioner/' + First(requestItem.performer).reference }
                    }
                }
            })
        }
    else if exists ([Appointment] A
        where A.basedOn.type is "VisionPrescription") then 
        FHIR.Extension {
            "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-appointment-with-order' },
            "extension": ({ 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'service type' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'VisionPrescription/' + requestItem.id }
                    }
                }, 
                 FHIR.Extension {
                    "url": FHIR.uri { "value": 'start' },
                    "value": FHIR.date { "value":  Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'end' },
                    "value": FHIR.date { "value": Today() + 7 days }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'practitioner' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'Practitioner/' + requestItem.prescriber.reference }
                    }
                }
            })
        }
    else if exists ([Appointment] A
        where A.basedOn.type is null) then 
        FHIR.Extension {
            "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-appointment-with-order' },
            "extension": ({ 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'service type' },
                    "value": FHIR.Reference {
                        "reference": FHIR.string { "value": 'Service type is not a ServiceRequest, NutritionOrder, DeviceRequest, MedicationRequest, nor a VisionPrescription' }
                    }
                }, 
                 FHIR.Extension {
                    "url": FHIR.uri { "value": 'start' },
                    "value": FHIR.string { "value":  'date' }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'end' },
                    "value": FHIR.string { "value": 'date' }
                }, 
                FHIR.Extension {
                    "url": FHIR.uri { "value": 'practitioner' },
                    "value": FHIR.string { "value": 'practitioner' }
                }
            })
        }
    else 
        FHIR.Extension {
            "url": FHIR.uri { "value": 'http://hl7.org/fhir/us/davinci-crd/StructureDefinition/profile-appointment-with-order' },
            "value": FHIR.string { "value": 'Needs action. Create Appointment.' }
        }