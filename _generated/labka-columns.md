<!-- Generated from schema/registers/labka.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`cpr`** | character | join key | Personal identifier |
| `samplingdate` | date | date | Sampling date |
| `analysiscode` | character | code | Analyte code |
| `value` | character | value | Result |
| `unit` | character | code | Unit |

<details>
<summary>All other columns (6)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `samplingtime` | character | value | Sampling time |
| `biomarker_name` | character | value | Biomarker name |
| `referenceinterval_lowerlimit` | character | value | Reference interval, lower limit |
| `referenceinterval_upperlimit` | character | value | Reference interval, upper limit |
| `laboratorium_id` | character | code | Laboratory identifier |
| `rekvirent_id` | character | code | Requester identifier |

- **`samplingtime`:** Reported to the hour and minute, per Arendt et al. 2020.
- **`biomarker_name`:** A text name alongside the code, per Arendt et al. 2020. The national register has no equivalent column.

</details>

*No published source gives a data type for 11 of these 11 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `cpr`.

**Worth knowing:**

- **`cpr`:** Described in the literature as the CPR number, not necessarily delivered in the same pseudonymised `pnr` form as a DST register. Confirm how it arrives, and what encryption/pseudonymisation applies, before joining it to anything else in your project.
- **`analysiscode`:** NPU, the Danish DNK modification of it, or a laboratory's own local code - the same three-way split as the national laboratory register (see [Laboratory results](register-reference.qmd#lab-forsker)).
- **`value`:** Numeric results and text-written non-numeric results both, same pitfall as the national register: do not `as.numeric()` this column without splitting the two first.
