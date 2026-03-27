# ASLPCrd-CdsHook — CRD Decision Tree

## Execution Flow

```mermaid
flowchart TD
    START([PlanDefinition/$r5.apply\nASLPCrd-CdsHook]) --> MULTI
    MULTI[ASLPCrd-MultipleRequest\nCoverageExtensionList] --> LOOP

    LOOP[for each item in draftOrders\nGetCrdResult] --> CRD8

    CRD8{CRD-8\nInsufficient or Ambiguous?\ntoo many coverages OR\nSR subject ≠ Provider Patient}
    CRD8 -->|yes| OUT8[auth-needed\nSubmit Prior Authorization Form]
    CRD8 -->|no| CRD81

    CRD81{CRD-8.1\nRequest item is null?}
    CRD81 -->|yes| OUT81[conditional\nError — No order found]
    CRD81 -->|no| CRD83

    CRD83{CRD-8.3\nUnsupported resource type?\ne.g. VisionPrescription}
    CRD83 -->|yes| OUT83[conditional\nUnable to Process Request]
    CRD83 -->|no| CRD2

    CRD2{CRD-2\nMember Not Eligible?\nname or DOB mismatch}
    CRD2 -->|yes| OUT2[auth-needed\nMember Not Found]
    CRD2 -->|no| CRD31

    CRD31{CRD-3.1\nProvider NPI not in payer network?\nrequester or performer NPI missing}
    CRD31 -->|yes| OUT31[auth-needed\nProvider Not in Network]
    CRD31 -->|no| CRD32

    CRD32{CRD-3.2\nLOB Mismatch?\nPayor org name mismatch\nvia Coverage.payor}
    CRD32 -->|yes| OUT32[auth-needed\nLine Of Business Mismatch]
    CRD32 -->|no| CRD32B

    CRD32B{CRD-3.2b\nLOB NPI Chain Mismatch?\nOrg name/NPI mismatch\nvia PractitionerRole}
    CRD32B -->|yes| OUT32B[auth-needed\nLine Of Business Mismatch]
    CRD32B -->|no| CRD4

    CRD4{CRD-4\nGold Card Status?\nhardcoded false}
    CRD4 -->|yes — never| OUT4[no-auth\nProvider is Gold Carded]
    CRD4 -->|no| CRD7

    CRD7{CRD-7\nRoutine Procedure?\ncode in routine valueset}
    CRD7 -->|yes| OUT7[no-auth\nNo Prior Auth Required]
    CRD7 -->|no| CRD5

    CRD5{CRD-5/6\nOn Prior Auth List?\ncode in priorauth-grouper valueset}
    CRD5 -->|yes| OUT5[auth-needed\nPrior Authorization Required]
    CRD5 -->|no| OUT6[not-covered\nCode Not Found]
```

---

## CRD Checks Reference Table

> **Data sources:**
> - **Provider** = inline `Provider Context` Bundle in the `$r5.apply` request parameters
> - **Payer** = live retrieves from `dataEndpoint` (payer FHIR server) scoped to `subject` patient

| Order | CRD | Name | Condition Message | Provider Field | Payer Field | Comparison | pa-needed | covered |
|-------|-----|------|-------------------|---------------|-------------|------------|-----------|---------|
| 1 | **CRD-8** | Subject / Context Validation | "Insufficient or ambiguous data — too many coverages or SR subject does not match Provider Patient" | `SR.subject.reference` → `"Patient/provider-patient-1"` | `Provider Context Bundle: Patient.id.value` → `"provider-patient-1"` | `GetSubjectID(SR) !~ Provider.Patient.id` ⚠️ broken: `Patient/` prefix mismatch | `auth-needed` | `conditional` |
| 2 | **CRD-8.1** | Empty Request | "No order found" | `requestItem is null` | — | null check | `conditional` | `conditional` |
| 3 | **CRD-8.3** | Unsupported Resource Type | "Unable to process request electronically" | `GetResourceType(SR)` | `UnsupportedResourceTypes = {'VisionPrescription'}` | `resourceType in list` | `conditional` | `conditional` |
| 4 | **CRD-2** | Member Eligibility | "Member not found — name or DOB mismatch" | `Provider.Patient.name.family`<br>`Provider.Patient.birthDate` | `Payor.Patient.name.family`<br>`Payor.Patient.birthDate` | family name lists **intersect** AND `days between DOB = 0` | `auth-needed` | `conditional` |
| 5 | **CRD-3.1** | Provider NPI Match | "Provider is not in the network" | SR → `Provider.Practitioners`<br>→ `identifier[system=us-npi].value` | `Payor.Practitioners`<br>→ `identifier[system=us-npi].value` | provider NPIs **included in** payer NPIs (requester AND performer) | `auth-needed` | `conditional` |
| 6 | **CRD-3.2** | LOB Match (org-level) | "Line of business mismatch" | `Provider.Coverage.payor.reference`<br>→ `Provider.Organization.name` | `Payor.Coverage.payor.reference`<br>→ `Payor.Organization.name` | `ProviderOrg.name ~ PayorOrg.name` ⚠️ broken: `R = O.id.value` missing `Organization/` prefix | `auth-needed` | `conditional` |
| 7 | **CRD-3.2b** | LOB Match (NPI chain) | "Line of business mismatch via PractitionerRole" | SR requester/performer → `Provider.PractitionerRole`<br>→ `organization.reference` → org name/NPI | `Payor.Organization` via provider Coverage | `org.name ~` or `org.getNpi() ~` ⚠️ broken: `PractitionerRole.practitioner.reference` vs `Practitioner.id` prefix | `auth-needed` | `conditional` |
| 8 | **CRD-4** | Gold Card Status | "Provider has gold card — no auth needed" | — | — | hardcoded `false` — never fires | `no-auth` | `covered` |
| 9 | **CRD-7** | Routine Procedure | "No prior auth required — routine procedure" | `SR.code` | valueset `http://terminology.smilecdr.com/cs/routine` | `SR.code in "Routine Procedure Valueset"` | `no-auth` | `covered` |
| 10 | **CRD-5** | On Prior Auth List | "Prior authorization required" | `SR.code` | valueset `http://terminology.smilecdr.com/cs/priorauth-grouper` | `SR.code in "Prior Auth Required for Procedure Grouper"` | `auth-needed` | `conditional` |
| 11 | **CRD-6** | Code Not Found | "Code not recognized — contact payer" | `SR.code` | same valueset — not found | `NOT in` prior auth list | `conditional` | `not-covered` |

### Notes on open bugs (⚠️)

| CRD | Bug | Fix |
|-----|-----|-----|
| CRD-8 | `SR.subject.reference` returns `"Patient/provider-patient-1"` but comparison is against bare `"provider-patient-1"` | Strip `Patient/` prefix in `GetSubjectID()` or at comparison site |
| CRD-3.2 | `R = O.id.value` where `R` is `"Organization/provider-payorganization-1"` and `O.id.value` is `"provider-payorganization-1"` | Change to `R = 'Organization/' + O.id.value` in `ASLPCrdOrderLOBMatchLogic.cql:51` |
| CRD-3.2b | `PractitionerRole.practitioner.reference.value` is `"Practitioner/payer-practitioner-pp2"` compared against `Practitioner.id.value` which is `"payer-practitioner-pp2"` | Change to `'Practitioner/' + RequesterPractitioner.id.value` in `ASLPCrdProviderNpiMatchLogic.cql:147` |
