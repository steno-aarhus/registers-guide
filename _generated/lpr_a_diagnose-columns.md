<!-- Generated from schema/registers/lpr_a_diagnose.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`dw_ek_kontakt`** | character | join key | Contact identifier |
| `diag_kode` | character | code | Diagnosis code |
| `diag_kode_type` | character | code | Diagnosis type |
| `senere_afkraeftet` | character | code | Later retracted |
| `diag_kode_tekst` | character | value | Diagnosis code, text |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (6)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `diag_parent_kode` | character | code | Parent diagnosis code |
| `lprindberetningssystem` | character | code | Reporting system |
| `diag_kode_type_tekst` | character | value | Diagnosis type, text |
| `diag_parent_kode_tekst` | character | value | Parent diagnosis code, text |
| `diag_parent_kode_type` | character | code | Parent diagnosis type |
| `diag_parent_kode_type_tekst` | character | value | Parent diagnosis type, text |

- **`lprindberetningssystem`:** Filter to "LPR3": the table holds rows from two reporting formats, and not doing so duplicates rows.

</details>

**Join key:** `dw_ek_kontakt`.

**Joins to other registers:**

- `dw_ek_kontakt` joins to **LPR_A_KONTAKT** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `diagtype` | `A`, `B`, `G` |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.
- **`diagtype`:** Which types to keep is a case definition, not a technicality. Outcomes and exclusion diagnoses normally use A and B; baseline comorbidity also uses G. Keeping only A drops secondary diagnoses and will undercount conditions. Carry the type column into the extract so the definition can be varied later. The set is taken from the guide and may not be complete.

</details>

**Worth knowing:**

- **`senere_afkraeftet`:** A diagnosis that was subsequently withdrawn. Keeping these counts conditions the patient turned out not to have.
- **`diag_kode_tekst`:** The code spelled out. Convenient for reading, but do not group on it: the text can change between years while the code stays the same.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
