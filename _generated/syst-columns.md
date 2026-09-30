<!-- Generated from schema/registers/syst.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `spec4` | character | code | Specialty, 4-digit |
| `sumydl` | numeric | value | Sum of number of services |
| `sumbru` | numeric | value | Sum of gross fees |

<details>
<summary>All other columns (4)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `kontakt` | numeric | value | Contact |
| `sikgrup` | character | code | Insurance group |
| `barnmak` | character | code | Child marker |
| `kommune` | character | code | Municipality of residence |

- **`barnmak`:** Until 1 January 1996, services to a child under 16 were reported under the parent's CPR-number (Sahl Andersen et al. 2011, Scand J Public Health 39(Suppl 7):34-37). See the same column in SYSI.
- **`kommune`:** All years are before the 2007 municipal reform, so these are the old municipality codes. The same number can mean a different municipality after 2007.

</details>

*No published source gives a data type for 7 of these 8 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |

- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality - confirmed for two reused codes against a current-only DST source: 707 is Norddjurs today, not its pre-2007 meaning, and likewise 849 is Jammerbugt. `lookup:` below covers only this post-2007 set (99 entries), not the full 278-code `values_from` file. Christiansø (411) is included in `lookup:` even though it is not a municipality (see description above): it is a real value a `kom` column can hold, and DST's own current-only classification lists it as its own area code alongside the 98 municipalities. Excluding it would just move the "unhandled code" problem this fix is meant to solve onto that one value.

Where these values come from:

- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).

</details>

**Worth knowing:**

- **`spec4`:** DST documents neither the structure nor a value set for this code, and it is not the same code as the 6-digit speciale in SYSI and SSSY. Do not assume the first two digits are spec2 without checking.
- **`sumbru`:** DST documents no unit for this column. bruhon in SYSI is in øre until 2004 and in kroner from 2005, so check which unit this sum is in before comparing it with anything.
