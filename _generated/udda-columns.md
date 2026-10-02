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

- **`hf_kilde`:** DST ranks the sources by how trustworthy they are, and a higher-priority source always wins, whatever education level it reports. Priority 1: adult education (1), the membership register of IDA, the Danish engineers' union (5), the Danish Health Authority's authorisation register (8), the agency for recognising foreign qualifications (11), Greenland (12), the Danish Maritime Authority (13), PhD (14) and Elev3 (15). Priority 2: the 1970 census (2) and immigrants' own answers about education brought from abroad (3, 17). Priority 3: the education that gave access to further study (19). Priority 4: immigrants' education imputed by DST (9, 18). SEPLINE (Clinical Epidemiology) treats 9, 10 and 18 as imputed and groups them as missing in individual-level analyses; all three are immigrants' education imputed by DST. The value set also has two retired imputed codes from the old pupil registers, 7 (Elev1) and 16 (Elev3), which SEPLINE does not mention.
- **`hfinstnr`:** The guide previously referred to this column as `INSTNR`. DST's list has no INSTNR; the institution columns are HFINSTNR, ALMINSTNR, ERHINSTNR and IGINSTNR, one per kind of education.
- **`almaudd`:** The general-education track only. hfaudd is the highest completed education of any kind, so the two answer different questions and are not interchangeable.
- **`ig_vfra`:** Pairs with udd: this is when the ongoing education began. An education with a start and no completion is either still running or was interrupted, and the register does not distinguish the two.

</details>

*No published source gives a data type for 17 of these 18 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

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

- **`hfaudd`:** A code for which education, not for its level. UDDA carries no level column at all, so the level has to come from a lookup table.
- **`udd`:** Not the same code system as hfaudd. Under DISCED-15, AUDD codes describe a completed education and UDD codes one that is ongoing or was interrupted, so a lookup table built for one will not fit the other. DST flags a data break within this variable. A UDD code normally stays with the same programme, which is why DST names it as the code to follow a programme over time, but DST has occasionally merged two codes into one or split one into two. The 8-digit classification code attached to a UDD code can change (nursing, for example, moved from short to medium-length higher education), so DST advises keeping the UDD code in historical data and applying the latest classification to every year. DST stores the codes as numbers, so leading zeros are dropped.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
