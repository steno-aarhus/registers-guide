<!-- Generated from schema/registers/lmdb.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 1995-Q2 to 2025-Q2 |
| `eksd` | date | date | Dispensing date | 1995-Q2 to 2025-Q2 |
| `atc` | character | code | ATC code, full 7 characters | 1995-Q2 to 2025-Q2 |
| `atc1` | character | code | ATC level 1 (1 character) | 1995-Q2 to 2025-Q2 |
| `atc2` | character | code | ATC level 2 (3 characters) | 1995-Q2 to 2025-Q2 |
| `atc3` | character | code | ATC level 3 (4 characters) | 1995-Q2 to 2025-Q2 |
| `atc4` | character | code | ATC level 4 (5 characters) | 1995-Q2 to 2025-Q2 |
| `vnr` | character | code | Item number (product key) | 1995-Q2 to 2025-Q2 |
| `indo` | character | code | Indication code | 2004-Q2 to 2025-Q2 |
| `apk` | numeric | value | Number of packages | 1995-Q2 to 2025-Q2 |
| `packsize` | numeric | value | Package size | 1995-Q2 to 2025-Q2 |
| `strnum` | numeric | value | Strength, numeric | 1995-Q2 to 2025-Q2 |
| `strunit` | character | value | Unit for the numeric strength | 1995-Q2 to 2025-Q2 |
| `aldr` | integer | value | Age at dispensing |  |
| `year` | integer | date | Dispensing year |  |

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `atc` | Not listed here - see [DST's classification](https://atcddd.fhi.no/atc/structure_and_principles/) |

- **`atc`:** As a rule, filter on the full 7-character code rather than on the level columns: `atc2` holds three characters, so a longer pattern matched against it can never match, and it returns nothing at all with no error. The level columns are well suited to grouping, and to filtering when every code you want is the same length as the column.

</details>

**Worth knowing:**

- **`pnr`:** DST's variable list calls this column `PNR12`. Check whether your variable is named `pnr` or `pnr12`.
- **`eksd`:** The date the prescription was collected at the pharmacy. Not the date it was prescribed, and not evidence that the medicine was taken.
- **`vnr`:** The only reliable way to isolate one specific product. Two brands with the same active substance share an ATC code but have different item numbers.
- **`indo`:** Recorded only when the prescriber picks an indication from the drop-down. Typed as free text it is not carried over, so the column is often empty.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
