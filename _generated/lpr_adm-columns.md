<!-- Generated from schema/registers/lpr_adm.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `pnr` | character | identifier | Personal identifier |
| `d_inddto` | date | date | Date of admission |
| `d_uddto` | date | date | Date of discharge |
| `c_pattype` | character | code | Patient type |
| `c_spec` | character | code | Specialty |
| `c_sgh` | character | code | Hospital |
| `c_afd` | character | code | Department |
| `c_adiag` | character | code | Action diagnosis |
| `v_alder` | integer | value | Age at the start of the contact |

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_DIAG** (one-to-many).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.

</details>

**Worth knowing:**

- **`recnum`:** The key every other LPR2 dataset joins on. It identifies a contact, not a person.
- **`c_adiag`:** A copy of the contact's action diagnosis. Use lpr_diag instead: it holds every diagnosis on the contact, not only the action one.
