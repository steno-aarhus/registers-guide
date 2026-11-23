<!-- Generated from schema/registers/uddf.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 2025 to 2025 |
| `hfaudd` | character | code | Highest completed education | 2025 to 2025 |
| `hf_vfra` | date | date | Date the education was reached | 2025 to 2025 |

<details>
<summary>All other columns (6)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `cprtjek` | character | value | CPR check | 2025 to 2025 |
| `cprtype` | character | value | CPR type | 2025 to 2025 |
| `hf_kilde` | character | code | Source of the education record | 2025 to 2025 |
| `hf_vtil` | date | date | Date the education stops being the highest | 2025 to 2025 |
| `instnr` | character | code | Institution number | 2025 to 2025 |
| `version` | character | value | Version | 2025 to 2025 |

- **`hf_kilde`:** Same variable and value set as hf_kilde in UDDA, see there for the source priorities and the codes for imputed immigrant education.

</details>

*No published source gives a data type for 9 of these 9 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `hfaudd` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/disced15-audd) |

- **`hfaudd`:** This is an identifier, not a scale. The level (short, medium, long) has to be looked up in a separate table, and cannot be read off the digits: 4112 is an electrician, and taking the first two digits as a level code makes it a long higher education. DST documents the ongoing-education codes separately as DISCED-15 UDD.

Where these values come from:

- **`hfaudd`:** [DST's DISCED-15 classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/disced15-audd).

</details>

**Worth knowing:**

- **`hfaudd`:** DST builds UDDA once a year from UDDF: UDDA is the education register for the population at 30 September, and UDDF holds the dated spells it is built from. Because each spell has a start and an end date, the education can be read at any date, not only at 30 September. DST can run earlier years again. It states that the status registers for all years are re-run if production changes materially, and that late reports from the institutions change earlier years, most of all the latest one. DST's register history for UDDF has an update of 4 October 2017 with new information on immigrants' brought-along education for 2005 to 2016. Two extractions made at different times can therefore differ for the same year, so record the date of yours.
- **`hf_vfra`:** DST gives both dates as Oracle dates of the form 31jun2004:00:00:00. hf_vfra is when the education was reached. hf_vtil is when it stops being the highest education because a new education then becomes the highest. DST writes no value set for either.
