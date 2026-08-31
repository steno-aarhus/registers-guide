<!-- Generated from schema/registers/lmdb.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `eksd` | date | date | Dispensing date |
| `atc` | character | code | ATC code, full 7 characters |
| `atc1` | character | code | ATC level 1 (1 character) |
| `atc2` | character | code | ATC level 2 (3 characters) |
| `atc3` | character | code | ATC level 3 (4 characters) |
| `atc4` | character | code | ATC level 4 (5 characters) |
| `vnr` | character | code | Item number (product key) |
| `indo` | character | code | Indication code |
| `apk` | numeric | value | Number of packages |
| `packsize` | numeric | value | Package size |
| `strnum` | numeric | value | Strength, numeric |
| `strunit` | character | value | Unit for the numeric strength |
| `aldr` | integer | value | Age at dispensing |
| `year` | integer | date | Dispensing year |

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `atc` | Not listed here - see [DST's classification](https://atcddd.fhi.no/atc/structure_and_principles/) |

- **`atc`:** As a rule, filter on the full 7-character code rather than on the level columns: `atc2` holds three characters, so a longer pattern matched against it can never match, and it returns nothing at all with no error. The level columns are well suited to grouping, and to filtering when every code you want is the same length as the column.

</details>

**Worth knowing:**

- **`pnr`:** DST's variable list calls this `PNR12`. The column read through fastreg is `pnr`. Check `colnames()` on your own extract.
- **`eksd`:** The date the prescription was collected at the pharmacy. Not the date it was prescribed, and not evidence that the medicine was taken.
- **`vnr`:** The only reliable way to isolate one specific product. Two brands with the same active substance share an ATC code but have different item numbers.
- **`indo`:** Recorded only when the prescriber picks an indication from the drop-down. Typed as free text it is not carried over, so the column is often empty.
- **`year`:** Not confirmed against DST's variable list. The LMDB parquet is partitioned by year, so this is very likely the partition column rather than a DST variable - the same situation as `aar` in BEF, which was confirmed to come from fastreg. Treat it as such until checked.
