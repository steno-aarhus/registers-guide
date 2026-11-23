<!-- Generated from schema/registers/vnds_ind.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `haend_dato` | date | date | Date of immigration |
| `indv_land` | character | code | Country immigration from |
| `indvmd` | character | date | Month of immigration |

<details>
<summary>All other columns (18)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `adresse_id` | character | code |  |
| `alder_haend` | integer | value |  |
| `alder_ult` | integer | value |  |
| `bank_statsb` | character | code |  |
| `civst` | character | code |  |
| `cprtjek` | character | value |  |
| `cprtype` | character | value |  |
| `foedreg_kode` | character | code |  |
| `foed_dag` | date | date |  |
| `foed_land` | character | code |  |
| `ie_type` | character | code |  |
| `koen` | integer | code |  |
| `kom` | character | code |  |
| `opr_land` | character | code |  |
| `referencetid` | date | date |  |
| `reg` | character | code |  |
| `statsb` | character | code |  |
| `version` | character | value |  |

- **`adresse_id`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`alder_haend`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`alder_ult`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`bank_statsb`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`cprtjek`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`cprtype`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`foedreg_kode`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`foed_dag`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`foed_land`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`ie_type`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`opr_land`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`referencetid`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`statsb`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.
- **`version`:** DST's variable list gives this column no label, so the schema records the name only. Its meaning has not been sourced.

</details>

*No published source gives a data type for 22 of these 22 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (5)</summary>

| Code system | Values |
| --- | --- |
| `civst` | `U` Ugift, `G` Gift (+ separeret), `F` Skilt, `E` Enke/Enkemand, `P` Registreret partnerskab, `O` Ophævet partnerskab, `L` Længstlevende af 2 partnere, `D` Død, `9` Uoplyst civilstand |
| `ie_type` | `1` Personer med dansk oprindelse, `2` Indvandrere, `3` Efterkommere, `9` Uoplyst |
| `koen` | `1` Mand, `2` Kvinde, `9` Uoplyst |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |
| `reg` | `0` Uoplyst, `81` Region Nordjylland, `82` Region Midtjylland, `83` Region Syddanmark, `84` Region Hovedstaden, `85` Region Sjælland |

- **`civst`:** Codes P, O and L came in with the registered-partnership act of 1 October 1989; before that the set was smaller. Registered partnerships could no longer be entered into from 15 June 2012.
- **`ie_type`:** DST's current high-quality page for IE_TYPE states that the variable has no value set. The codes here come from DST's herkomst classification, which does publish them.
- **`koen`:** DST's classification KOEN_V1_1980 also defines `9` for not stated, which a delivery may not contain but a value set should. Sex is taken from the tenth digit of the CPR number: even is female, odd is male.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality - confirmed for two reused codes against a current-only DST source: 707 is Norddjurs today, not its pre-2007 meaning, and likewise 849 is Jammerbugt. `lookup:` below covers only this post-2007 set (99 entries), not the full 278-code `values_from` file. Christiansø (411) is included in `lookup:` even though it is not a municipality (see description above): it is a real value a `kom` column can hold, and DST's own current-only classification lists it as its own area code alongside the 98 municipalities. Excluding it would just move the "unhandled code" problem this fix is meant to solve onto that one value.
- **`reg`:** DST's classification has no code for unknown. Code 0 is kept as a working assumption. Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.

Where these values come from:

- **`civst`:** [DST's variable list for BEF](https://www.dst.dk/da/Statistik/dokumentation/Times/cpr-oplysninger/civst).
- **`ie_type`:** [DST's herkomst classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/herkomst) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/948ef1c3-072c-4d76-ba2b-ce7d34691593csv_da)).
- **`koen`:** [DST's classification KOEN_V1_1980](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/koen) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e267e7c0-d998-4922-b2c4-6b44b15dd149csv_da)).
- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).
- **`reg`:** [DST's classification of regions, landsdele and municipalities](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/5d18d1e0-400b-4505-92ad-6782915980a3csv_da)).

</details>
