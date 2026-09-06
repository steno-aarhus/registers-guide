<!-- Generated from schema/registers/dodsaarsager.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `doedsdato` | date | date | Date of death |
| `doedsaarsag_tilgrundliggende` | character | code | Underlying cause of death |
| `doedsaarsag_kode_1` | character | code | Cause of death, code 1 |
| `doedsmaade_kode` | character | code | Manner of death |

<details>
<summary>All other columns (34)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `doedsaarsag_liste_14_kode` | character | code | Cause group, 14-item list |
| `doedsaarsag_liste_49_kode` | character | code | Cause group, 49-item list |
| `doedssted_kode` | character | code | Place of death |
| `dw_ek_borger` | character | code | Citizen key |
| `flag_valideret` | character | code | Validated flag |
| `borger_alder_doedsstatus` | numeric | value |  |
| `borger_bo_kom_doedsstatus` | character | code |  |
| `borger_bo_reg_doedsstatus` | character | code |  |
| `borger_koen_doedsstatus` | character | code |  |
| `cprtjek` | character | code |  |
| `cprtype` | character | code |  |
| `doedsaarsag_gruppering_a_kode` | character | code |  |
| `doedsaarsag_gruppering_b_kode` | character | code |  |
| `doedsaarsag_kode_2` | character | code |  |
| `doedsaarsag_kode_3` | character | code |  |
| `doedsaarsag_kode_4` | character | code |  |
| `doedsaarsag_kode_a` | character | code |  |
| `doedsaarsag_kode_b` | character | code |  |
| `doedsaarsag_kode_c` | character | code |  |
| `doedsaarsag_kode_d` | character | code |  |
| `doedsstatusdato` | date | date |  |
| `doedssted_praecisering_kode` | character | code |  |
| `doedstidspunkt` | date | date |  |
| `findedato` | date | date |  |
| `findested_kode` | character | code |  |
| `findested_praecisering_kode` | character | code |  |
| `findetidspunkt` | date | date |  |
| `haendelsessted_kode` | character | code |  |
| `hospice` | character | code |  |
| `laegefunktion_kode` | character | code |  |
| `obduktionstype_kode` | character | code |  |
| `sygehus_org_reg` | character | code |  |
| `sygehus_shaksghkode` | character | code |  |
| `sygehus_sorkode` | character | code |  |

- **`dw_ek_borger`:** An LPR3-style surrogate key alongside pnr. Not present in the two older cause-of-death registers.

</details>

*DST publishes no labels for 10 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*No published source gives a data type for 39 of these 39 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |

- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.

Where these values come from:

- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).

</details>
