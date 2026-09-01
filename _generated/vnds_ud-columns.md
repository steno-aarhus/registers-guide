<!-- Generated from schema/registers/vnds_ud.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `haend_dato` | date | date | Date of emigration |
| `udv_land` | character | code | Country emigration to |
| `udvmd` | character | date | Month of emigration |

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

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (4)</summary>

| Code system | Values |
| --- | --- |
| `civst` | `U` Ugift, `G` Gift (+ separeret), `F` Skilt, `E` Enke/Enkemand, `P` Registreret partnerskab, `O` Ophævet partnerskab, `L` Længstlevende af 2 partnere, `D` Død, `9` Uoplyst civilstand |
| `koen` | `1` Mand, `2` Kvinde |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts) |
| `reg` | `0` Uoplyst, `81` Nordjylland, `82` Midtjylland, `83` Syddanmark, `84` Hovedstaden, `85` Sjælland |

- **`civst`:** Codes P, O and L came in with the registered-partnership act of 1 October 1989; before that the set was smaller. Registered partnerships could no longer be entered into from 15 June 2012.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.
- **`reg`:** Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.

</details>
