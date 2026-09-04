<!-- Generated from schema/registers/udda.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 1980 to 2025 |
| `hfaudd` | character | code | Highest completed education | 1980 to 2025 |
| `udd` | character | code | Education code | 1980 to 2025 |
| `hf_vfra` | date | date | Date the education was completed | 1980 to 2025 |
| `year` | integer | date | Register year |  |

<details>
<summary>All other columns (13)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `hf_kilde` | character | code | Source of the education record | 1980 to 2025 |
| `hfinstnr` | character | code | Institution that awarded the education | 1980 to 2025 |
| `almaudd` | character | code | Highest completed general education | 1980 to 2025 |
| `erhaudd` | character | code | Highest completed vocational education | 1980 to 2025 |
| `alm_vfra` | date | date | Date the general education was obtained | 1980 to 2025 |
| `erh_vfra` | date | date | Date the vocational education was obtained | 1980 to 2025 |
| `ig_vfra` | date | date | Start date of the ongoing education | 1980 to 2025 |
| `alminstnr` | character | code | Institution, general education | 1980 to 2025 |
| `erhinstnr` | character | code | Institution, vocational education | 1980 to 2025 |
| `iginstnr` | character | code | Institution, ongoing education | 1980 to 2025 |
| `cprtjek` | character | code | CPR check | 2005 to 2025 |
| `cprtype` | character | code | CPR type | 2005 to 2025 |
| `version` | character | code | Module data version | 2005 to 2025 |

- **`hfinstnr`:** The guide previously referred to this column as `INSTNR`. DST's list has no INSTNR; the institution columns are HFINSTNR, ALMINSTNR, ERHINSTNR and IGINSTNR, one per kind of education.
- **`almaudd`:** The general-education track only. hfaudd is the highest completed education of any kind, so the two answer different questions and are not interchangeable.
- **`ig_vfra`:** Pairs with udd: this is when the ongoing education began. An education with a start and no completion is either still running or was interrupted, and the register does not distinguish the two.

</details>

*No published source gives a data type for 17 of these 18 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

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

- **`hfaudd`:** A code for which education, not for its level. UDDA carries no level column at all, so the level has to come from a lookup table.
- **`udd`:** Not the same code system as hfaudd. Under DISCED-15, AUDD codes describe a completed education and UDD codes one that is ongoing or was interrupted, so a lookup table built for one will not fit the other.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
