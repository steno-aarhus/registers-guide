<!-- Generated from schema/registers/lpr_a_diagnose.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`dw_ek_kontakt`** | character | join key | Contact identifier |
| `diag_kode` | character | code | Diagnosis code |
| `diag_kode_type` | character | code | Diagnosis type |
| `diag_parent_kode` | character | code | Parent diagnosis code |
| `senere_afkraeftet` | character | code | Later retracted |
| `lprindberetningssystem` | character | code | Reporting system |

**Join key:** `dw_ek_kontakt`.

**Joins to other registers:**

- `dw_ek_kontakt` joins to **LPR_A_KONTAKT** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.

</details>

**Worth knowing:**

- **`senere_afkraeftet`:** A diagnosis that was subsequently withdrawn. Keeping these counts conditions the patient turned out not to have.
- **`lprindberetningssystem`:** Filter to "LPR3": the table holds rows from two reporting formats, and not doing so duplicates rows.
