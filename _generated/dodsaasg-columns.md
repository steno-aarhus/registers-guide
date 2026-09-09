<!-- Generated from schema/registers/dodsaasg.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `d_dodsdato` | date | date | Date of death |
| `c_dodtilgrundl_acme` | character | code | Underlying cause of death (ACME) |
| `c_dod_1a` | character | code | Cause of death, certificate line 1a |
| `c_dodsmaade` | character | code | Manner of death |
| `aar` | integer | date | Year |

<details>
<summary>All other columns (35)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_liste14` | character | code | Cause group, 14-item list |
| `c_liste49` | character | code | Cause group, 49-item list |
| `c_dodssted` | character | code | Place of death |
| `cprtjek` | character | code | CPR-tjek |
| `cprtype` | character | code | CPR-type |
| `c_bopamtf07` | character | code | C_BOPAMTF07 |
| `c_bopkom` | character | code | C_BOPKOM |
| `c_bopkomf07` | character | code | C_BOPKOMF07 |
| `c_dodkom` | character | code | C_DODKOM |
| `c_dodregion` | character | code | C_DODREGION |
| `c_dod_1b` | character | code | C_DOD_1B |
| `c_dod_1c` | character | code | C_DOD_1C |
| `c_dod_1d` | character | code | C_DOD_1D |
| `c_dod_21` | character | code | C_DOD_21 |
| `c_dod_22` | character | code | C_DOD_22 |
| `c_dod_23` | character | code | C_DOD_23 |
| `c_dod_24` | character | code | C_DOD_24 |
| `c_dod_25` | character | code | C_DOD_25 |
| `c_dod_26` | character | code | C_DOD_26 |
| `c_dod_27` | character | code | C_DOD_27 |
| `c_dod_28` | character | code | C_DOD_28 |
| `c_findested` | character | code | Findested |
| `c_haendelsessted` | character | code | C_HAENDELSESSTED |
| `c_laegefunktion` | character | code | C_LAEGEFUNKTION |
| `c_listea` | character | code | C_LISTEA |
| `c_listeb` | character | code | C_LISTEB |
| `c_obduktion` | character | code | C_OBDUKTION |
| `c_operation` | character | code | C_OPERATION |
| `c_praecis_dodssted` | character | code | C_PRAECIS_DODSSTED |
| `c_praecis_findested` | character | code | C_PRAECIS_FINDESTED |
| `c_region` | character | code | C_REGION |
| `c_sex` | character | code | C_SEX |
| `d_findedato` | date | date | D_FINDEDATO |
| `d_statdato` | date | date | D_STATDATO |
| `v_alder` | numeric | value | V_ALDER |

</details>

*DST publishes no labels for 3 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*No published source gives a data type for 38 of these 41 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |
| `c_dodsmaade_2002` | `0` Ulykke, `1` Voldshandling, `2` Selvmord, `4` Uoplyst, `5` Naturlig død |
| `c_dodssted` | `-1` Ikke valgt (fordi afdøde er fundet død), `0` Død på sygehus eller hospice, `1` Død på bopælsadressen, `2` Død på kendt adresse, `3` Dødssted uden adresse |

- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.
- **`c_dodsmaade_2002`:** This is the set behind the `c_dodsmaade` column in dodsaasg, and the numbers do not mean what the same numbers mean in `dodsaars`. There, under `c_dodsmaade`, 1 is Naturlig død, 2 is Ulykke and 5 is Uoplyst. Here 1 is Voldshandling, 2 is Selvmord and 5 is Naturlig død. A study that spans 2001 and 2002 is reading two different code sets out of two columns with the same name, and every value maps to something plausible in the other set, so nothing looks wrong. A blank is a registration error, not a missing manner of death.
- **`c_dodssted`:** All five codes are valid from 1 January 2002. The variable says nothing about deaths before that, which is the whole period dodsaars covers.

Where these values come from:

- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).
- **`c_dodsmaade_2002`:** [Kodeark for Doedsaarsagsregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Doedsaarsagsregisteret/17_Kodeark_DAR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=17).
- **`c_dodssted`:** [Kodeark for Doedsaarsagsregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Doedsaarsagsregisteret/17_Kodeark_DAR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=17).

</details>

**Worth knowing:**

- **`d_dodsdato`:** Note the spelling: d_dodsdato here, d_dodsdto in DODSAARS. The two registers do not use the same column names.
- **`c_dodtilgrundl_acme`:** The underlying cause, selected by the ACME algorithm. This is usually the one an analysis wants, rather than the individual certificate lines.
- **`aar`:** A real DST variable in this register, unlike the `year` column the parquet conversion adds to most others. If you have seen `aar` referred to as the partition column elsewhere, this is where the name comes from.
