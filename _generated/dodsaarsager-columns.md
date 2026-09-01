<!-- Generated from schema/registers/dodsaarsager.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `doedsdato` | date | date | Date of death |
| `doedsaarsag_tilgrundliggende` | character | code | Underlying cause of death |
| `doedsaarsag_kode_1` | character | code | Cause of death, code 1 |
| `doedsmaade_kode` | character | code | Manner of death |

<details>
<summary>All other columns (5)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `doedsaarsag_liste_14_kode` | character | code | Cause group, 14-item list |
| `doedsaarsag_liste_49_kode` | character | code | Cause group, 49-item list |
| `doedssted_kode` | character | code | Place of death |
| `dw_ek_borger` | character | code | Citizen key |
| `flag_valideret` | character | code | Validated flag |

- **`dw_ek_borger`:** An LPR3-style surrogate key alongside pnr. Not present in the two older cause-of-death registers.

</details>

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.

</details>
