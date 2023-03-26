<!-----

Yay, no errors, warnings, or alerts!

Conversion time: 0.688 seconds.


Using this Markdown file:

1. Paste this output into your source file.
2. See the notes and action items below regarding this conversion run.
3. Check the rendered output (headings, lists, code blocks, tables) for proper
   formatting and use a linkchecker before you publish this page.

Conversion notes:

* Docs to Markdown version 1.0β34
* Sun Mar 26 2023 09:54:06 GMT-0700 (PDT)
* Source doc: Untitled document
* Tables are currently converted to HTML tables.
----->



<table>
  <tr>
   <td><strong>Concept</strong>
   </td>
   <td><strong>Description</strong>
   </td>
   <td><strong>FHIR Resource</strong>
   </td>
   <td><strong>Profile</strong>
   </td>
   <td><strong>CodeSystem</strong>
   </td>
   <td><strong>ValueSet/Code</strong>
   </td>
   <td><strong>Terminology Constraint</strong>
   </td>
   <td><strong>Date Constraint</strong>
   </td>
   <td><strong>Other Element Constraint</strong>
   </td>
   <td><strong>VSAC Link</strong>
   </td>
   <td><strong>Metadata</strong>
   </td>
   <td><strong>Source</strong>
   </td>
   <td><strong>Notes</strong>
   </td>
  </tr>
  <tr>
   <td>Eligibility Request Date
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Eligibility Request Time
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Procedure Code
   </td>
   <td>
   </td>
   <td>Procedure.code
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>Define "Sleep Studies" value set to identify codes of potential sleep studies
   </td>
  </tr>
  <tr>
   <td>Procedure Date
   </td>
   <td>
   </td>
   <td>Procedure.date
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Diagnosis of Obstructive Sleep Apnea
   </td>
   <td>
   </td>
   <td>Condition.code in "Sleep Apnea”
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>Define "Sleep Apnea" with at least ICD10#G47.33|Obstructive Sleep Apnea (OSA)
   </td>
  </tr>
  <tr>
   <td>History of Hypertension
   </td>
   <td>
   </td>
   <td>Condition.code in "Hypertension"
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>History of Diabetes
   </td>
   <td>
   </td>
   <td>Condition.code in "Diabetes"
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Neck Circumference (in inches)
   </td>
   <td>
   </td>
   <td>Observation.value as Quantity
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>LOINC code for Neck Circumference in inches
   </td>
  </tr>
  <tr>
   <td>Height (in inches)
   </td>
   <td>
   </td>
   <td>Observation.value as Quantity
   </td>
   <td>Vital Signs Height profile
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>Weight (in pounds)
   </td>
   <td>
   </td>
   <td>Observation.value as Quantity
   </td>
   <td>Vital Signs Weight profile
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
  <tr>
   <td>BMI 
   </td>
   <td>
   </td>
   <td>Observation.value as Quantity
   </td>
   <td>Vital Signs BMI profile
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
   <td>
   </td>
  </tr>
</table>

