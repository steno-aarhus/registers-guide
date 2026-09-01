<!-- Generated from schema/registers/t_psyk_adm.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| **`recnum`** | character | join key | Contact identifier |
| `c_pattype` | character | code | Contact type |
| `c_adiag` | character | code | Primary diagnosis |
| `d_inddto` | date | date | Admission date |
| `d_uddto` | date | date | Discharge date |

<details>
<summary>All other columns (8)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_indm` | character | code | Admission mode |
| `c_udm` | character | code | Discharge mode |
| `c_sgh` | character | code | Hospital |
| `c_afd` | character | code | Department |
| `c_spec` | character | code | Specialty |
| `v_indtime` | integer | value | Admission hour |
| `v_indminut` | integer | value | Admission minute |
| `v_udtime` | integer | value | Discharge hour |

</details>

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_DIAG** (one-to-many).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `pattype` | `0` Heldoegns indlaeggelse, `1` Deldoegns indlaeggelse, `2` Ambulant, `3` Skadestue, `4` Dagpatient, `5` Natpatient |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`pattype`:** Do not read this as a simple three-way split. The emergency-room coding changed around 2014: before then an ER visit is mostly `"3"`, afterwards it usually arrives as `"2"` with an acute admission mode in `c_indm`. Classifying on `c_pattype` alone therefore counts ER visits as outpatient for the later years. The extraction chapter has the full rule.
- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.

</details>

**Worth knowing:**

- **`pnr`:** DST's variable list calls this column PNR. Some deliveries rename it: in DARTER it arrives as `v_cpr`. The name is a product of the data processing, not of the register, so check colnames() and rename to pnr.
- **`recnum`:** DST's variable list calls this column RECNUM, the same name the somatic lpr_adm uses. Some deliveries rename it: in DARTER the contact table has `k_recnum` and the diagnosis table has `v_recnum`, two names for one key. Rename both to recnum before joining.
- **`c_pattype`:** Present here even where the somatic lpr_adm extract leaves it out, so the psychiatric side of a study can be classified when the somatic side cannot. Do not assume symmetry between the two extracts.
