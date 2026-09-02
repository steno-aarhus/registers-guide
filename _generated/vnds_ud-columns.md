<!-- Generated from schema/registers/vnds_ud.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 2025 to 1900 |
| `haend_dato` | date | date | Date of emigration | 2025 to 1900 |
| `udv_land` | character | code | Country emigration to | 2025 to 1900 |
| `udvmd` | character | date | Month of emigration | 2025 to 1900 |

<details>
<summary>All other columns (18)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `adresse_id` | character | code |  | 2025 to 1900 |
| `alder_haend` | integer | value |  | 2025 to 1900 |
| `alder_ult` | integer | value |  | 2025 to 1900 |
| `bank_statsb` | character | code |  | 2025 to 1900 |
| `civst` | character | code |  | 2025 to 1900 |
| `cprtjek` | character | value |  | 2025 to 1900 |
| `cprtype` | character | value |  | 2025 to 1900 |
| `foedreg_kode` | character | code |  | 2025 to 1900 |
| `foed_dag` | date | date |  | 2025 to 1900 |
| `foed_land` | character | code |  | 2025 to 1900 |
| `ie_type` | character | code |  | 2025 to 1900 |
| `koen` | integer | code |  | 2025 to 1900 |
| `kom` | character | code |  | 2025 to 1900 |
| `opr_land` | character | code |  | 2025 to 1900 |
| `referencetid` | date | date |  | 2025 to 1900 |
| `reg` | character | code |  | 2025 to 1900 |
| `statsb` | character | code |  | 2025 to 1900 |
| `version` | character | value |  | 2025 to 1900 |

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

*The Type column is read off the column name for 22 of these 22 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

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

Where these values come from:

- **`civst`:** [DST's variable list for BEF](https://www.dst.dk/da/Statistik/dokumentation/Times/cpr-oplysninger/civst).
- **`koen`:** [DST's variable list for BEF](https://www.dst.dk/extranet/ForskningVariabellister/BEF%20-%20Befolkningen.html).
- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts).
- **`reg`:** [DST's regional classification](https://www.dst.dk/extranet/ForskningVariabellister/BEF%20-%20Befolkningen.html).

</details>
