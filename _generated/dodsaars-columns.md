<!-- Generated from schema/registers/dodsaars.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `d_dodsdto` | date | date | Date of death |
| `c_dodsmaade` | character | code | Manner of death |
| `c_dod1` | character | code | Underlying cause of death |
| `c_dod2` | character | code | Contributing cause of death 2 |
| `c_dod3` | character | code | Contributing cause of death 3 |
| `c_dod4` | character | code | Contributing cause of death 4 |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (27)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_dodskom` | character | code | Municipality of death |
| `c_attart` | character | code | Type of certificate |
| `c_sex` | character | code | Sex |
| `v_alder` | numeric | value | Age at death |
| `daar` | integer | date | Year of death |
| `c_bopkom` | character | code | Municipality of residence at death |
| `c_handsted` | character | code | Place of the event |
| `c_liste_14` | character | code | Cause group, 14-item list |
| `c_liste_49` | character | code | Cause group, 49-item list |
| `c_liste_65` | character | code | Cause group, 65-item list |
| `cprtjek` | character | code | CPR-tjek |
| `cprtype` | character | code | CPR-type |
| `c_aldertim` | numeric | value | Dødsalder i timer |
| `c_atckode1` | character | code | C_ATCKODE1 |
| `c_atckode2` | character | code | C_ATCKODE2 |
| `c_atckode3` | character | code | C_ATCKODE3 |
| `c_atckode4` | character | code | C_ATCKODE4 |
| `c_civstd` | character | code | Civilstand |
| `c_institut` | character | code | Institution for dødsfald |
| `c_obduktio` | character | code | C_OBDUKTIO |
| `c_operatio` | character | code | Operationstilkendegivelse |
| `c_u28dg` | numeric | value | Angivelse af dødsalder under 28 dage |
| `c_ulyktype` | character | code | C_ULYKTYPE |
| `v_aldermdr` | numeric | value | Alder i måneder |
| `v_bopamt` | numeric | value | V_BOPAMT |
| `v_dodsamt` | numeric | value | Dødsstedsamt |
| `v_klok` | numeric | value | Tiden for dødens indtræffelse |

</details>

*DST publishes no labels for 4 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*No published source gives a data type for 29 of these 35 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (4)</summary>

| Code system | Values |
| --- | --- |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |
| `atc` | Not listed here - see [DST's classification](https://atcddd.fhi.no/atc/structure_and_principles/) |
| `icd8` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer) |

- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.
- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.
- **`atc`:** As a rule, filter on the full 7-character code rather than on the level columns: `atc2` holds three characters, so a longer pattern matched against it can never match, and it returns nothing at all with no error. The level columns are well suited to grouping, and to filtering when every code you want is the same length as the column.
- **`icd8`:** A study whose period starts before 1994 is reading two classifications out of one column. ICD-10 codes match nothing in the early years, and the usual substr(c_diag, 2, 4) returns a meaningless fragment of an ICD-8 code rather than failing, so nothing tells you it went wrong.

Where these values come from:

- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).
- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).
- **`atc`:** [WHO ATC/DDD Index](https://atcddd.fhi.no/atc/structure_and_principles/).
- **`icd8`:** [Retired classification, no current DST page](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer).

</details>

**Worth knowing:**

- **`d_dodsdto`:** A date of death exists here, but the register stops in 2001. Censor on DOD instead, which covers the whole period.
- **`c_dod1`:** The underlying cause. Coded in the ICD revision in force at the time of death, so the code system changes inside the register's own lifetime.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
