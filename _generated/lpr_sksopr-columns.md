<!-- Generated from schema/registers/lpr_sksopr.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_opr` | character | code | Procedure code |
| `c_oprart` | character | code | Procedure type |
| `c_osgh` | character | code | Hospital performing the procedure |
| `c_tilopr` | character | code | Supplementary code |
| `d_odto` | date | date | Procedure date |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (5)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_oafd` | character | code | Department performing the procedure |
| `leverancedato` | date | date | Delivery date |
| `version` | character | code | Version |
| `v_ominut` | numeric | value | Procedure start, minute |
| `v_otime` | numeric | value | Procedure start, hour |

- **`c_oafd`:** Not unique on its own: combine it with c_osgh to get the 7-character hospital-department code (SHAK). Department names change over time, so look up the name valid on d_odto.
- **`v_ominut`:** Minute (0-59) of the start time, from 1998. Combine with v_otime; before 1998 only the date exists.
- **`v_otime`:** Hour (0-23) of the start time, from 1998.

</details>

*No published source gives a data type for 8 of these 12 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

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
- **`oprart`:** Counting rows in the procedure table counts add-on codes and sub-procedures as procedures. If you want one row per operation, filter to `V` or `P` first. All four codes run from 1996, but Sundhedsdatastyrelsen's variable documentation (DocumentationExtended?id=5, t_sksopr, c_oprart) notes that `V` was no longer mandatory for contacts completed in 2004, so `V` does not give one main operation per contact in every year. The same column name in lpr_sksube is only a `+`/blank add-on marker and does not use this code system.

Where these values come from:

- **`sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`oprart`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).

</details>

**Worth knowing:**

- **`recnum`:** Sundhedsdatastyrelsen states that recnum is unique only within one update of the register. A contact can get a new recnum when the register is updated, and a recnum can be reused for a different contact. Join tables only within the same delivery, and never store recnum as a lasting id for a contact.
- **`c_opr`:** The SKS procedure code. Surgical codes start with K. Operations from 1 January 1996 only, in the Nordic classification (NCSP). Operations before that date are in lpr_opr under the old classification, and the split is by operation date, not by contact. So a contact that runs across New Year 1995/1996 can have operations in both tables: read both for those contacts. Look up the code text valid on d_odto.
- **`c_oprart`:** A '+' row is not an operation. It only marks that the operation in c_opr has an add-on code in c_tilopr; the operation's own type is on the row above with the same recnum and c_opr. Sundhedsdatastyrelsen also notes that V (main operation of the contact) was no longer mandatory for contacts completed in 2004, so filtering on V does not give one operation per contact across all years.
- **`c_osgh`:** Hospital code from the SHAK classification. Names change over time, so look up the name valid on d_odto.
- **`c_tilopr`:** Add-on code to the operation in c_opr on the same row (marked by c_oprart '+'). Almost any SKS code can be used as an add-on.
- **`d_odto`:** The date the operation started. Unlike lpr_diag, this table has its own date, so the operation date does not have to be taken from the contact.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
