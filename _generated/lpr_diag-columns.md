<!-- Generated from schema/registers/lpr_diag.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |  |
| `c_diag` | character | code | Diagnosis code |  |
| `c_diagtype` | character | code | Diagnosis type |  |
| `c_tildiag` | character | code | Supplementary diagnosis | 1995 to 2019 |
| `c_diagmod` | character | code | Diagnosis modification | 1977 to 1994 |

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `diagtype` | `A`, `B`, `G` |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.
- **`diagtype`:** Which types to keep is a case definition, not a technicality. Outcomes and exclusion diagnoses normally use A and B; baseline comorbidity also uses G. Keeping only A drops secondary diagnoses and will undercount conditions. Carry the type column into the extract so the definition can be varied later. The set is taken from the guide and may not be complete.

</details>
