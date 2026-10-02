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
| `c_oafd` | character | code | Department performing the procedure |
| `leverancedato` | date | date | Delivery date |
| `version` | character | code | Version |
| `v_ominut` | numeric | value | Procedure start, minute |
| `v_otime` | numeric | value | Procedure start, hour |

- **`c_oprart`:** Not the same column as c_oprart in lpr_sksopr. Here it is only an indicator: '+' when the procedure has an add-on code in c_tilopr, blank otherwise. The V/P/D values of the oprart code system do not occur.
- **`c_osgh`:** Hospital code from the SHAK classification. Names change over time, so look up the name valid on d_odto.
- **`c_tilopr`:** Add-on code to the procedure in c_opr (marked by c_oprart '+'). Almost any SKS code can be used as an add-on.
- **`c_oafd`:** Not unique on its own: combine it with c_osgh to get the 7-character hospital-department code (SHAK). Department names change over time, so look up the name valid on d_odto.
- **`v_ominut`:** Minute (0-59) of the start time, from 1999. Combine with v_otime; before 1999 only the date exists.
- **`v_otime`:** Hour (0-23) of the start time, from 1999.

</details>

*No published source gives a data type for 8 of these 12 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`sks`:** The codes are hierarchical, so a prefix match selects a whole branch. That also makes it easy to select more than you meant: check how many characters your intended group actually needs before filtering with starts_with().

Where these values come from:

- **`sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).

</details>

**Worth knowing:**

- **`recnum`:** Sundhedsdatastyrelsen states that recnum is unique only within one update of the register. A contact can get a new recnum when the register is updated, and a recnum can be reused for a different contact. Join tables only within the same delivery, and never store recnum as a lasting id for a contact.
- **`c_opr`:** Check that you actually have this column. DST documents it for every year 1999-2019, but a delivery can arrive with only recnum, d_odto and year, which leaves no way to tell one procedure from another. Without it the table is unusable, and no filtering recovers it. Every SKS code that is neither a diagnosis (D) nor an operation (K): examinations, non-surgical treatments and administrative codes. Look up the code text valid on d_odto.
- **`d_odto`:** The date the procedure started.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
