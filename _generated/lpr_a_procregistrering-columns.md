<!-- Generated from schema/registers/lpr_a_procregistrering.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`dw_ek_kontakt`** | character | join key | Contact identifier | 2025 to 1899 |
| `proc_kode` | character | code | Procedure code | 2025 to 1899 |
| `proc_starttidspunkt` | datetime | date | Procedure start | 2025 to 1899 |
| `proc_kode_type` | character | code | Procedure code type | 2025 to 1899 |
| `proc_sluttidspunkt` | datetime | date | Procedure end | 2025 to 1899 |
| `proc_parent_kode` | character | code | Parent procedure code | 2025 to 1899 |
| `dw_ek_forloeb` | character | code | Course identifier | 2025 to 1899 |
| `flag_proc_uden_kont` | character | code | Procedure without a contact | 2025 to 1899 |
| `lprindberetningssystem` | character | code | Reporting system | 2025 to 1899 |

<details>
<summary>All other columns (11)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `dw_ek_procedureregistrering` | character | identifier | Procedure registration identifier | 2025 to 1899 |
| `dw_sk_sygehusophold` | character | code | Hospital stay identifier | 2025 to 1899 |
| `proc_indb_tidspunkt` | datetime | date | Reporting time | 2025 to 1899 |
| `proc_kode_tekst` | character | value | Procedure code, text | 2025 to 1899 |
| `proc_kode_type_tekst` | character | value | Procedure code type, text | 2025 to 1899 |
| `proc_parent_kode_tekst` | character | value | Parent procedure code, text | 2025 to 1899 |
| `proc_parent_kode_type` | character | code | Parent procedure code type | 2025 to 1899 |
| `proc_parent_kode_type_tekst` | character | value | Parent procedure code type, text | 2025 to 1899 |
| `proc_lpr_entity_id` | character | code | LPR entity identifier | 2025 to 1899 |
| `prod_enh` | character | code | Performing unit | 2025 to 1899 |
| `prod_inst` | character | code | Performing institution | 2025 to 1899 |

- **`proc_indb_tidspunkt`:** When the procedure was reported, not when it happened. Recent months look incomplete because reporting lags.

</details>

*DST publishes no labels for 20 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*The Type column is read off the column name for 20 of these 20 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `dw_ek_kontakt`.

**Joins to other registers:**

- `dw_ek_kontakt` joins to **LPR_A_KONTAKT** (many-to-one).

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

- **`dw_ek_kontakt`:** The key to lpr_a_kontakt, which is where pnr lives. This table carries no person identifier of its own.
- **`proc_starttidspunkt`:** A datetime, not a date. as.Date() it before comparing with an index date.
- **`proc_kode_type`:** "P" marks a procedure, "+" an add-on code. An add-on code modifies the procedure above it and is not a procedure in its own right, so counting all rows overcounts.
- **`proc_parent_kode`:** LPR3 nests procedures the same way it nests diagnoses: an add-on code points at the procedure it belongs to.
- **`dw_ek_forloeb`:** One level above the contact. Where dw_ek_kontakt is empty, this is the only route back to a person, and it reaches a whole course of treatment rather than a single contact.
- **`flag_proc_uden_kont`:** Flags a procedure with no contact attached. Those rows cannot be joined to lpr_a_kontakt at all, so a plain inner join drops them silently.
- **`lprindberetningssystem`:** Filter to "LPR3" when combining with LPR2, or contacts reported under both systems are counted twice.
