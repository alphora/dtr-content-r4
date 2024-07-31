Profile: DiagnosticTestPriortoHGNS
Parent: Observation
Id: fbpsg-paa-HGNS-screening
Title: "Diagnostic test prior to HGNS"
Description: "Diagnostic testing prior to planned hypoglossal nerve stimulator implantation (HGNS)"
* insert CommonextensionsStrucutureDefinition
* code = fbpsg-paa-screening-codes#diagnostic-test-prior-to-HGNS "Diagnostic test prior to HGNS"
  * ^short = "Diagnostic test prior to HGNS"
  * ^definition = "Diagnostic test prior to HGNS"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has undergone diagnostic testing prior to planned hypoglossal nerve stimulator implantation with a known diagnosis of OSA?"
  * ^definition = "Patient has undergone diagnostic testing prior to planned hypoglossal nerve stimulator implantation with a known diagnosis of OSA?"

Profile: HistoryCentralSleepApnea
Parent: Observation
Id: fbpsg-paa-history-CSA-screening
Title: "History of CSA"
Description: "History of Central Sleep Apnea (CSA)"
* insert CommonextensionsStrucutureDefinition
* code = fbpsg-paa-screening-codes#history-of-CSA "History of central sleep apnea (CSA)"
  * ^short = "History of central sleep apnea (CSA)"
  * ^definition = "History of central sleep apnea (CSA)"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has history of Central Sleep Apnea(CSA)?"
  * ^definition = "Patient has history of Central Sleep Apnea(CSA)?"

Profile: CentralSleepApnea
Parent: Observation
Id: fbpsg-paa-CSA-screening
Title: "Clinical features associated with CSA"
Description: "Clinical features associated with Central Sleep Apnea (CSA)"
* insert CommonextensionsStrucutureDefinition
* code = $ICD10#G47.31 "Primary central sleep apnea"
  * ^short = "Primary central sleep apnea"
  * ^definition = "A condition associated with multiple episodes of sleep apnea which are distinguished from obstructive sleep apnea (sleep apnea, obstructive) by the complete cessation of efforts to breathe. This disorder is associated with dysfunction of central nervous system centers that regulate respiration."
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has Central Sleep Apnea(CSA)?"
  * ^definition = "Patient has Central Sleep Apnea(CSA)?"

Profile: HistoryNarcolepsy
Parent: Observation
Id: fbpsg-paa-history-narcolepsy-screening
Title: "History of Narcolepsy"
Description: "History of narcolepsy when a MSLT is planned"
* insert CommonextensionsStrucutureDefinition
* code = fbpsg-paa-screening-codes#history-of-narcolepsy "History of narcolepsy"
  * ^short = "History of narcolepsy"
  * ^definition = "History of narcolepsy"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has history of narcolepsy?"
  * ^definition = "Patient has history of narcolepsy?"

Profile: Narcolepsy
Parent: Observation
Id: fbpsg-paa-narcolepsy-screening
Title: "Narcolepsy"
Description: "Narcolepsy when a MSLT is planned"
* insert CommonextensionsStrucutureDefinition
* code = $ICD10#G47.41 "Narcolepsy"
  * ^short = "Narcolepsy"
  * ^definition = "A condition characterized by recurrent episodes of daytime somnolence and lapses in consciousness (microsomnias) that may be associated with automatic behaviors and amnesia. Cataplexy; sleep paralysis, and hypnagogic hallucinations frequently accompany narcolepsy. The pathophysiology of this disorder includes sleep-onset rapid eye movement (rem) sleep, which normally follows stage iii or iv sleep. (from neurology 1998 feb;50(2 suppl 1):s2-s7)"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has narcolepsy?"
  * ^definition = "Patient has narcolepsy?"

Profile: HistoryObesityHypoventilationSyndrome
Parent: Observation
Id: fbpsg-paa-history-OHS-screening
Title: "History of Obesity hypoventilation syndrome (OHS)"
Description: "History of Obesity hypoventilation syndrome (OHS) which cannot be attributed to other conditions such as hypothyroidism, neuromuscular weakness, pleural pathology, pulmonary disease or skeletal restriction"
* insert CommonextensionsStrucutureDefinition
* code = fbpsg-paa-screening-codes#history-of-OHS "History of Obesity hypoventilation syndrome (OHS)"
  * ^short = "History of Obesity hypoventilation syndrome (OHS)"
  * ^definition = "History of Obesity hypoventilation syndrome (OHS)"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has History of Obesity hypoventilation syndrome (OHS)?"
  * ^definition = "Patient has History of Obesity hypoventilation syndrome (OHS)?"

Profile: ObesityHypoventilationSyndrome
Parent: Observation
Id: fbpsg-paa-OHS-screening
Title: "Obesity hypoventilation syndrome (OHS)"
Description: "Obesity hypoventilation syndrome (OHS) which cannot be attributed to other conditions such as hypothyroidism, neuromuscular weakness, pleural pathology, pulmonary disease or skeletal restriction"
* insert CommonextensionsStrucutureDefinition
* code = $ICD10#E66.2 "Morbid (severe) obesity with alveolar hypoventilation"
  * ^short = "Morbid (severe) obesity with alveolar hypoventilation"
  * ^definition = "Morbid (severe) obesity with alveolar hypoventilation"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has Obesity hypoventilation syndrome (OHS)?"
  * ^definition = "Patient has Obesity hypoventilation syndrome (OHS)?"

Profile: HistoryTraumaticBrainInjury
Parent: Observation
Id: fbpsg-paa-history-TBI-screening
Title: "History of traumatic brain injury (TBI) with EDS"
Description: "History of traumatic brain injury (TBI) with EDS"
* insert CommonextensionsStrucutureDefinition
* code = $ICD10#Z87.820 "Personal history of traumatic brain injury"
  * ^short = "Personal history of traumatic brain injury"
  * ^definition = "Personal history of traumatic brain injury"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has history of traumatic brain injury (TBI) with EDS?"
  * ^definition = "Patient has history of traumatic brain injury (TBI) with EDS?"

Profile: IdiopathicCentralNervousSystemHypersomnia
Parent: Observation
Id: fbpsg-paa-idiopathic-CNS-hypersomnia-screening
Title: "Idiopathic central nervous system hypersomnia"
Description: "Idiopathic central nervous system hypersomnia when a MSLT is planned"
* insert CommonextensionsStrucutureDefinition
* code = $ICD10#G47.11 "Idiopathic hypersomnia with long sleep time"
  * ^short = "Idiopathic hypersomnia with long sleep time"
  * ^definition = "A sleep disorder of central nervous system origin characterized by prolonged nocturnal sleep and periods of daytime drowsiness. Affected individuals experience difficulty with awakening in the morning and may have associated sleep drunkenness, automatic behaviors, and memory disturbances. This condition differs from narcolepsy in that daytime sleep periods are longer, there is no association with cataplexy, and the multiple sleep latency onset test does not record sleep-onset rapid eye movement sleep. (from chokroverty, sleep disorders medicine, 1994, pp319-20; psychiatry clin neurosci 1998 apr:52(2):125-129)"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has idiopathic central nervous system hypersomnia when a multiple sleep latency test (MSLT) is planned?"
  * ^definition = "Patient has idiopathic central nervous system hypersomnia when a multiple sleep latency test (MSLT) is planned?"

Profile: MissionCriticalProfession
Parent: Observation
Id: fbpsg-paa-mission-critical-profession-screening
Title: "Mission critical profession"
Description: "Mission critical profession"
* insert CommonextensionsStrucutureDefinition
* code = fbpsg-paa-screening-codes#mission-critical-profession "Mission critical profession"
  * ^short = "Mission critical profession"
  * ^definition = "Mission critical profession"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has a mission critical profession?"
  * ^definition = "Patient has a mission critical profession?"

Profile: Parasomnias
Parent: Observation
Id: fbpsg-paa-parasomnias-screening
Title: "Parasomnias"
Description: "Parasomnias that are unusual or atypical because of the duration, frequency or time of the behavior"
* insert CommonextensionsStrucutureDefinition
* code = $ICD10#G47.5 "Parasomnia"
  * ^short = "Parasomnia"
  * ^definition = "Movements or behaviors associated with sleep, sleep stages, or partial arousals from sleep that may impair sleep maintenance. Parasomnias are generally divided into four groups: arousal disorders, sleep-wake transition disorders, parasomnias of rem sleep, and nonspecific parasomnias. (from thorpy, sleep disorders medicine, 1994, p191)"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has Parasomnias that are unusual or atypical?"
  * ^definition = "Patient has Parasomnias that are unusual or atypical?"

Profile: ParoxysmalArousals
Parent: Observation
Id: fbpsg-paa-paroxysmal-arousals-screening
Title: "Paroxysmal arousals"
Description: "Paroxysmal arousals or other sleep disruptions thought to be seizure related"
* insert CommonextensionsStrucutureDefinition
* code = $ICD10#G47.6 "Sleep related movement disorders"
  * ^short = "Sleep related movement disorders"
  * ^definition = "Sleep related movement disorders"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has Paroxysmal arousals or other sleep disruption thought to be seizure related?"
  * ^definition = "Patient has Paroxysmal arousals or other sleep disruption thought to be seizure related?"

Profile: PeriodicLimbMovementDisorder
Parent: Observation
Id: fbpsg-paa-periodic-limb-movement-disorder-screening
Title: "Periodic limb movement disorder"
Description: "Periodic limb movement disorder"
* insert CommonextensionsStrucutureDefinition
* code = $ICD10#G47.61 "Periodic limb movement disorder"
  * ^short = "Periodic limb movement disorder"
  * ^definition = "Excessive periodic leg movements during sleep that cause micro-arousals and interfere with the maintenance of sleep. This condition induces a state of relative sleep deprivation which manifests as excessive daytime hypersomnolence. The movements are characterized by repetitive contractions of the tibialis anterior muscle, extension of the toe, and intermittent flexion of the hip, knee and ankle. (Adams et al., Principles of Neurology, 6th ed, p387)"
* value[x] 1..1 MS
* value[x] only boolean
  * ^short = "Patient has Periodic limb movement disorder?"
  * ^definition = "Patient has Periodic limb movement disorder?"