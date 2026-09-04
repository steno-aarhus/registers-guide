<!-- Generated from schema/registers/dodsaasg.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 2022 to 2022 |
| `d_dodsdato` | date | date | Date of death | 2022 to 2022 |
| `c_dodtilgrundl_acme` | character | code | Underlying cause of death (ACME) | 2022 to 2022 |
| `c_dod_1a` | character | code | Cause of death, certificate line 1a | 2022 to 2022 |
| `c_dodsmaade` | character | code | Manner of death | 2022 to 2022 |
| `aar` | integer | date | Year | 2022 to 2022 |

<details>
<summary>All other columns (35)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `c_liste14` | character | code | Cause group, 14-item list | 2022 to 2022 |
| `c_liste49` | character | code | Cause group, 49-item list | 2022 to 2022 |
| `c_dodssted` | character | code | Place of death | 2022 to 2022 |
| `cprtjek` | character | code | CPR-tjek | 2022 to 2022 |
| `cprtype` | character | code | CPR-type | 2022 to 2022 |
| `c_bopamtf07` | character | code | C_BOPAMTF07 | 2022 to 2022 |
| `c_bopkom` | character | code | C_BOPKOM | 2022 to 2022 |
| `c_bopkomf07` | character | code | C_BOPKOMF07 | 2022 to 2022 |
| `c_dodkom` | character | code | C_DODKOM | 2022 to 2022 |
| `c_dodregion` | character | code | C_DODREGION | 2022 to 2022 |
| `c_dod_1b` | character | code | C_DOD_1B | 2022 to 2022 |
| `c_dod_1c` | character | code | C_DOD_1C | 2022 to 2022 |
| `c_dod_1d` | character | code | C_DOD_1D | 2022 to 2022 |
| `c_dod_21` | character | code | C_DOD_21 | 2022 to 2022 |
| `c_dod_22` | character | code | C_DOD_22 | 2022 to 2022 |
| `c_dod_23` | character | code | C_DOD_23 | 2022 to 2022 |
| `c_dod_24` | character | code | C_DOD_24 | 2022 to 2022 |
| `c_dod_25` | character | code | C_DOD_25 | 2022 to 2022 |
| `c_dod_26` | character | code | C_DOD_26 | 2022 to 2022 |
| `c_dod_27` | character | code | C_DOD_27 | 2022 to 2022 |
| `c_dod_28` | character | code | C_DOD_28 | 2022 to 2022 |
| `c_findested` | character | code | Findested | 2022 to 2022 |
| `c_haendelsessted` | character | code | C_HAENDELSESSTED | 2022 to 2022 |
| `c_laegefunktion` | character | code | C_LAEGEFUNKTION | 2022 to 2022 |
| `c_listea` | character | code | C_LISTEA | 2022 to 2022 |
| `c_listeb` | character | code | C_LISTEB | 2022 to 2022 |
| `c_obduktion` | character | code | C_OBDUKTION | 2022 to 2022 |
| `c_operation` | character | code | C_OPERATION | 2022 to 2022 |
| `c_praecis_dodssted` | character | code | C_PRAECIS_DODSSTED | 2022 to 2022 |
| `c_praecis_findested` | character | code | C_PRAECIS_FINDESTED | 2022 to 2022 |
| `c_region` | character | code | C_REGION | 2022 to 2022 |
| `c_sex` | character | code | C_SEX | 2022 to 2022 |
| `d_findedato` | date | date | D_FINDEDATO | 2022 to 2022 |
| `d_statdato` | date | date | D_STATDATO | 2022 to 2022 |
| `v_alder` | numeric | value | V_ALDER | 2022 to 2022 |

</details>

*DST publishes no labels for 3 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*No published source gives a data type for 38 of these 41 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

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

**Worth knowing:**

- **`d_dodsdato`:** Note the spelling: d_dodsdato here, d_dodsdto in DODSAARS. The two registers do not use the same column names.
- **`c_dodtilgrundl_acme`:** The underlying cause, selected by the ACME algorithm. This is usually the one an analysis wants, rather than the individual certificate lines.
- **`aar`:** A real DST variable in this register, unlike the `year` column the parquet conversion adds to most others. If you have seen `aar` referred to as the partition column elsewhere, this is where the name comes from.
