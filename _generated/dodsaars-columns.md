<!-- Generated from schema/registers/dodsaars.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 2001 to 2001 |
| `d_dodsdto` | date | date | Date of death | 2001 to 2001 |
| `c_dodsmaade` | character | code | Manner of death | 2001 to 2001 |
| `c_dod1` | character | code | Underlying cause of death | 2001 to 2001 |
| `c_dod2` | character | code | Contributing cause of death 2 | 2001 to 2001 |
| `c_dod3` | character | code | Contributing cause of death 3 | 2001 to 2001 |
| `c_dod4` | character | code | Contributing cause of death 4 | 2001 to 2001 |
| `year` | integer | date | Register year |  |

<details>
<summary>All other columns (27)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `c_dodskom` | character | code | Municipality of death | 2001 to 2001 |
| `c_attart` | character | code | Type of certificate | 2001 to 2001 |
| `c_sex` | character | code | Sex | 2001 to 2001 |
| `v_alder` | numeric | value | Age at death | 2001 to 2001 |
| `daar` | integer | date | Year of death | 2001 to 2001 |
| `c_bopkom` | character | code | Municipality of residence at death | 2001 to 2001 |
| `c_handsted` | character | code | Place of the event | 2001 to 2001 |
| `c_liste_14` | character | code | Cause group, 14-item list | 2001 to 2001 |
| `c_liste_49` | character | code | Cause group, 49-item list | 2001 to 2001 |
| `c_liste_65` | character | code | Cause group, 65-item list | 2001 to 2001 |
| `cprtjek` | character | code | CPR-tjek | 2001 to 2001 |
| `cprtype` | character | code | CPR-type | 2001 to 2001 |
| `c_aldertim` | numeric | value | Dødsalder i timer | 2001 to 2001 |
| `c_atckode1` | character | code | C_ATCKODE1 | 2001 to 2001 |
| `c_atckode2` | character | code | C_ATCKODE2 | 2001 to 2001 |
| `c_atckode3` | character | code | C_ATCKODE3 | 2001 to 2001 |
| `c_atckode4` | character | code | C_ATCKODE4 | 2001 to 2001 |
| `c_civstd` | character | code | Civilstand | 2001 to 2001 |
| `c_institut` | character | code | Institution for dødsfald | 2001 to 2001 |
| `c_obduktio` | character | code | C_OBDUKTIO | 2001 to 2001 |
| `c_operatio` | character | code | Operationstilkendegivelse | 2001 to 2001 |
| `c_u28dg` | numeric | value | Angivelse af dødsalder under 28 dage | 2001 to 2001 |
| `c_ulyktype` | character | code | C_ULYKTYPE | 2001 to 2001 |
| `v_aldermdr` | numeric | value | Alder i måneder | 2001 to 2001 |
| `v_bopamt` | numeric | value | V_BOPAMT | 2001 to 2001 |
| `v_dodsamt` | numeric | value | Dødsstedsamt | 2001 to 2001 |
| `v_klok` | numeric | value | Tiden for dødens indtræffelse | 2001 to 2001 |

</details>

*DST publishes no labels for 4 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*The Type column is read off the column name for 29 of these 35 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `atc` | Not listed here - see [DST's classification](https://atcddd.fhi.no/atc/structure_and_principles/) |

- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.
- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.
- **`atc`:** As a rule, filter on the full 7-character code rather than on the level columns: `atc2` holds three characters, so a longer pattern matched against it can never match, and it returns nothing at all with no error. The level columns are well suited to grouping, and to filtering when every code you want is the same length as the column.

Where these values come from:

- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).
- **`icd10`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`atc`:** [WHO ATC/DDD Index](https://atcddd.fhi.no/atc/structure_and_principles/).

</details>

**Worth knowing:**

- **`d_dodsdto`:** A date of death exists here, but the register stops in 2001. Censor on DOD instead, which covers the whole period.
- **`c_dod1`:** The underlying cause. Coded in the ICD revision in force at the time of death, so the code system changes inside the register's own lifetime.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
