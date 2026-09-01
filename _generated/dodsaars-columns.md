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
<summary>All other columns (10)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_dodskom` | character | code | Municipality of death |
| `c_attart` | character | code | Type of certificate |
| `c_sex` | character | code | Sex |
| `v_alder` | integer | value | Age at death |
| `daar` | integer | date | Year of death |
| `c_bopkom` | character | code | Municipality of residence at death |
| `c_handsted` | character | code | Place of the event |
| `c_liste_14` | character | code | Cause group, 14-item list |
| `c_liste_49` | character | code | Cause group, 49-item list |
| `c_liste_65` | character | code | Cause group, 65-item list |

</details>

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts) |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.
- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.

</details>

**Worth knowing:**

- **`d_dodsdto`:** A date of death exists here, but the register stops in 2001. Censor on DOD instead, which covers the whole period.
- **`c_dod1`:** The underlying cause. Coded in the ICD revision in force at the time of death, so the code system changes inside the register's own lifetime.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
