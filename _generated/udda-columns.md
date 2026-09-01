<!-- Generated from schema/registers/udda.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `hfaudd` | character | code | Highest completed education |
| `udd` | character | code | Education code |
| `hf_kilde` | character | code | Source of the education record |
| `hf_vfra` | date | date | Date the education was completed |
| `hfinstnr` | character | code | Institution that awarded the education |

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `hfaudd` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/disced15-audd) |

- **`hfaudd`:** This is an identifier, not a scale. The level (short, medium, long) has to be looked up in a separate table, and cannot be read off the digits: 4112 is an electrician, and taking the first two digits as a level code makes it a long higher education. DST documents the ongoing-education codes separately as DISCED-15 UDD.

</details>

**Worth knowing:**

- **`hfaudd`:** A code for which education, not for its level. UDDA carries no level column at all, so the level has to come from a lookup table.
- **`udd`:** Not the same code system as hfaudd. Under DISCED-15, AUDD codes describe a completed education and UDD codes one that is ongoing or was interrupted, so a lookup table built for one will not fit the other.
- **`hfinstnr`:** The guide previously referred to this column as `INSTNR`. DST's list has no INSTNR; the institution columns are HFINSTNR, ALMINSTNR, ERHINSTNR and IGINSTNR, one per kind of education.
