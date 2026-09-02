<!-- Generated from schema/registers/lab_dm_forsker.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`patient_cpr`** | character | join key | Personal identifier |
| `samplingdate` | date | date | Sampling date |
| `analysiscode` | character | code | Analyte code |
| `value` | character | value | Result |
| `unit` | character | code | Unit |

<details>
<summary>All other columns (9)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `samplingtime` | character | value | Sampling time |
| `resulttype` | character | code | Result type |
| `laboratorium_idcode` | character | code | Laboratory identifier |
| `referenceinterval_lowerlimit` | character | value | Reference interval, lower limit |
| `referenceinterval_upperlimit` | character | value | Reference interval, upper limit |
| `resultvalidation` | character | code | Result validation |
| `rekvirent_id` | character | code | Requester identifier |
| `rekvirent_idtype` | character | code | Requester identifier type |
| `operator` | character | code | Operator |

- **`samplingtime`:** Not in the narrower `lab_forsker` table.
- **`resulttype`:** Whether the result is numeric or alphanumeric. Use it to split the two before converting anything.
- **`laboratorium_idcode`:** A MedCom laboratory code. Coverage starts at different dates per laboratory, so this column is what tells you whether a gap in a series is clinical or administrative.
- **`resultvalidation`:** Not in the narrower `lab_forsker` table.
- **`operator`:** Carries the "less than" or "greater than" sign when a result is reported as below or above a detection limit. Ignoring it turns a censored value into an exact one.

</details>

*The Type column is read off the column name for 13 of these 14 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `patient_cpr`.

**Worth knowing:**

- **`patient_cpr`:** Results carrying only a replacement CPR number are filtered out before the research table is built, so every row here has a real personal identifier. The narrower `laboratorieproevesvar` table calls this column `cprnummer`.
- **`samplingdate`:** When the sample was taken, not when the result was reported. This guide previously called the column `samplingdato`, which does not exist.
- **`analysiscode`:** Which analysis was done, coded in NPU or the Danish DNK terminology. This is the column the guide used to call `npu`, which does not exist. Only NPU- and DNK-coded results reach the research table, about 95 per cent of all results: anything coded with a laboratory's own local code is absent.
- **`value`:** Text, not a number. Alongside numeric results the table holds a fixed set of words: POSITIV, NEGATIV, NORMAL, IKKE PAAVIST, PAAVIST, INGEN VAEKST, FORHOEJET and the blood-type codes. as.numeric() turns every one of those into NA without warning, which drops exactly the samples where something was found. The narrower `laboratorieproevesvar` table calls this column `samplevalue`.
- **`unit`:** Never compare values across laboratories without checking this. Different equipment and sample material mean the same analyte code can need different interpretation, within one laboratory over time as well.
