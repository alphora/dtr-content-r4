
#### ASLP.A1 Adult Sleep Studies

Data elements for this activity can be collected using the [ASLPA1](Questionnaire-ASLPA1.html)

|Id|Label|Description|Type|Profile Path|
|---|---|---|---|---|
|ASLP.A1.DE22|BMI|Body mass index (BMI)|Quantity|[Observation.value[x]](StructureDefinition-aslp-bmi.html)|
|ASLP.A1.DE16|Diagnosis of Obstructive Sleep Apnea|Diagnosis of Obstructive Sleep Apnea|CodeableConcept|[Condition.code](StructureDefinition-aslp-diagnosis-of-obstructive-sleep-apnea.html)|
|ASLP.A1.DE20|Height|Height (in inches)|Quantity|[Observation.value[x]](StructureDefinition-aslp-height.html)|
|ASLP.A1.DE19|History of Diabetes|History of Diabetes|Boolean|[Observation.value[x]](StructureDefinition-aslp-history-of-diabetes.html)|
|ASLP.A1.DE18|History of Hypertension|History of Hypertension|Boolean|[Observation.value[x]](StructureDefinition-aslp-history-of-hypertension.html)|
|ASLP.A1.DE20|Neck Circumference|Neck circumference (in inches)|Quantity|[Observation.value[x]](StructureDefinition-aslp-neck-circumference.html)|
|ASLP.A1.DE1|Sleep Study|A sleep study procedure being ordered|CodeableConcept|[ServiceRequest.code](StructureDefinition-aslp-sleep-study-order.html)|
|ALSP.A1.DE15|Sleep Study Date|Date of the procedure|dateTime|[ServiceRequest.occurrence[x]](StructureDefinition-aslp-sleep-study-order.html)|
|ASLP.A1.DE21|Weight|Weight (in pounds)|Quantity|[Observation.value[x]](StructureDefinition-aslp-weight.html)|
