<!-- Generated from schema/registers/dodsaarsager.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 2024 to 2024 |
| `doedsdato` | date | date | Date of death | 2024 to 2024 |
| `doedsaarsag_tilgrundliggende` | character | code | Underlying cause of death | 2024 to 2024 |
| `doedsaarsag_kode_1` | character | code | Cause of death, code 1 | 2024 to 2024 |
| `doedsmaade_kode` | character | code | Manner of death | 2024 to 2024 |

<details>
<summary>All other columns (34)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `doedsaarsag_liste_14_kode` | character | code | Cause group, 14-item list | 2024 to 2024 |
| `doedsaarsag_liste_49_kode` | character | code | Cause group, 49-item list | 2024 to 2024 |
| `doedssted_kode` | character | code | Place of death | 2024 to 2024 |
| `dw_ek_borger` | character | code | Citizen key | 2024 to 2024 |
| `flag_valideret` | character | code | Validated flag | 2024 to 2024 |
| `borger_alder_doedsstatus` | numeric | value |  | 2024 to 2024 |
| `borger_bo_kom_doedsstatus` | character | code |  | 2024 to 2024 |
| `borger_bo_reg_doedsstatus` | character | code |  | 2024 to 2024 |
| `borger_koen_doedsstatus` | character | code |  | 2024 to 2024 |
| `cprtjek` | character | code |  | 2024 to 2024 |
| `cprtype` | character | code |  | 2024 to 2024 |
| `doedsaarsag_gruppering_a_kode` | character | code |  | 2024 to 2024 |
| `doedsaarsag_gruppering_b_kode` | character | code |  | 2024 to 2024 |
| `doedsaarsag_kode_2` | character | code |  | 2024 to 2024 |
| `doedsaarsag_kode_3` | character | code |  | 2024 to 2024 |
| `doedsaarsag_kode_4` | character | code |  | 2024 to 2024 |
| `doedsaarsag_kode_a` | character | code |  | 2024 to 2024 |
| `doedsaarsag_kode_b` | character | code |  | 2024 to 2024 |
| `doedsaarsag_kode_c` | character | code |  | 2024 to 2024 |
| `doedsaarsag_kode_d` | character | code |  | 2024 to 2024 |
| `doedsstatusdato` | date | date |  | 2024 to 2024 |
| `doedssted_praecisering_kode` | character | code |  | 2024 to 2024 |
| `doedstidspunkt` | date | date |  | 2024 to 2024 |
| `findedato` | date | date |  | 2024 to 2024 |
| `findested_kode` | character | code |  | 2024 to 2024 |
| `findested_praecisering_kode` | character | code |  | 2024 to 2024 |
| `findetidspunkt` | date | date |  | 2024 to 2024 |
| `haendelsessted_kode` | character | code |  | 2024 to 2024 |
| `hospice` | character | code |  | 2024 to 2024 |
| `laegefunktion_kode` | character | code |  | 2024 to 2024 |
| `obduktionstype_kode` | character | code |  | 2024 to 2024 |
| `sygehus_org_reg` | character | code |  | 2024 to 2024 |
| `sygehus_shaksghkode` | character | code |  | 2024 to 2024 |
| `sygehus_sorkode` | character | code |  | 2024 to 2024 |

- **`dw_ek_borger`:** An LPR3-style surrogate key alongside pnr. Not present in the two older cause-of-death registers.

</details>

*DST publishes no labels for 10 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*No published source gives a data type for 39 of these 39 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.

Where these values come from:

- **`icd10`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).

</details>
