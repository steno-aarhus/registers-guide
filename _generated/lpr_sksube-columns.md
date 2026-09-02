<!-- Generated from schema/registers/lpr_sksube.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_opr` | character | code | Procedure code |
| `d_odto` | date | date | Procedure date |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (8)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_oprart` | character | code | Procedure type |
| `c_osgh` | character | code | Hospital performing the procedure |
| `c_tilopr` | character | code | Supplementary code |
| `c_oafd` | character | code | Procedurende afdeling (undersøgelse &amp; behandling) |
| `leverancedato` | date | date |  |
| `version` | character | code | Version |
| `v_ominut` | numeric | value | Procedureminut (undersøgelse &amp; behandling) |
| `v_otime` | numeric | value | Proceduretime (undersøgelse &amp; behandling) |

</details>

*The Type column is read off the column name for 8 of these 12 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `oprart` | `V` Vigtigste operation i afsluttet kontakt, `P` Vigtigste operation i operativt indgreb, `D` Deloperation, `+` Tillaegskode |

- **`sks`:** The codes are hierarchical, so a prefix match selects a whole branch. That also makes it easy to select more than you meant: check how many characters your intended group actually needs before filtering with starts_with().
- **`oprart`:** Counting rows in the procedure table counts add-on codes and sub-procedures as procedures. If you want one row per operation, filter to `V` or `P` first. All four codes run from 1996 with no breaks.

Where these values come from:

- **`sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`oprart`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).

</details>

**Worth knowing:**

- **`c_opr`:** Check that you actually have this column. DST documents it for every year 1999-2019, but a delivery can arrive with only recnum, d_odto and year, which leaves no way to tell one procedure from another. Without it the table is unusable, and no filtering recovers it.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
