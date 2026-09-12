<!-- Generated from schema/registers/lpr_a_procregistrering_aflys.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `PROC_KODE` | character | code | Procedure code |

<details>
<summary>All other columns (18)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_FORLOEB`** | character | join key | Course identifier |
| **`DW_EK_KONTAKT`** | character | join key | Contact identifier |
| `DW_EK_PROCEDUREREGISTRERING` | character | identifier | Procedure registration identifier |
| **`DW_SK_SYGEHUSOPHOLD`** | character | join key | Hospital stay identifier |
| `FLAG_PROC_UDEN_KONT` | character | code | Procedure without a contact |
| `LPRINDBERETNINGSSYSTEM` | character | code | Reporting system |
| `PROC_INDB_TIDSPUNKT` | datetime | date | Procedure reporting time |
| `PROC_KODE_TEKST` | character | derived | Procedure code, text |
| `PROC_KODE_TYPE` | character | code | Procedure code type |
| `PROC_KODE_TYPE_TEKST` | character | derived | Procedure code type, text |
| `PROC_PARENT_KODE` | character | code | Parent procedure code |
| `PROC_PARENT_KODE_TEKST` | character | derived | Parent procedure code, text |
| `PROC_PARENT_KODE_TYPE` | character | code | Parent procedure code type |
| `PROC_PARENT_KODE_TYPE_TEKST` | character | derived | Parent procedure code type, text |
| `PROC_SLUTTIDSPUNKT` | datetime | date | Procedure end |
| `PROC_STARTTIDSPUNKT` | datetime | date | Procedure start |
| `PROD_ENH` | character | code | Producing unit code |
| `PROD_INST` | character | code | Producing institution code |

- **`DW_EK_PROCEDUREREGISTRERING`:** Not confirmed to share lpr_a_procregistrering's own key space, even though the column is named identically.
- **`DW_SK_SYGEHUSOPHOLD`:** Same surrogate-key pattern as lpr_a_procregistrering.yaml's own dw_sk_sygehusophold and lpr_a_sghophold.yaml's own key pair.
- **`FLAG_PROC_UDEN_KONT`:** Same concept as lpr_a_procregistrering.yaml's own flag_proc_uden_kont: flags a row with no contact attached, so a plain inner join to lpr_a_kontakt drops it silently.
- **`PROC_KODE_TYPE`:** Same 'P' (procedure) vs '+' (add-on code) distinction documented on lpr_a_procregistrering.yaml's own proc_kode_type - not independently confirmed here since DST gives no label.
- **`PROC_PARENT_KODE`:** An add-on code points at the procedure it belongs to, same nesting pattern as lpr_a_procregistrering.yaml.
- **`PROC_SLUTTIDSPUNKT`:** For a cancelled registration, likely the planned rather than actual end - not confirmed by any documentation found.
- **`PROC_STARTTIDSPUNKT`:** Likely the planned rather than actual start, for the same reason as proc_sluttidspunkt - not confirmed.

</details>

*No published source gives a data type for 19 of these 19 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `DW_EK_FORLOEB`, `DW_EK_KONTAKT`.

**Joins to other registers:**

- `DW_EK_FORLOEB` joins to **LPR_A_FORLOEB** (many-to-one).
- `DW_EK_KONTAKT` joins to **LPR_A_KONTAKT** (many-to-one).
- `DW_SK_SYGEHUSOPHOLD` joins to **LPR_A_SGHOPHOLD** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `lprindberetningssystem` | `LPR3`, `MiniPAS`, `LPR2`, `LPR1` |
| `sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`lprindberetningssystem`:** Confirm the exact strings with `count(lprindberetningssystem)` before relying on "LPR2" or "LPR1" in a filter: they are well-established as concepts in this guide, but nobody has pasted the literal value back from DARTER the way pitfall 5 did for "LPR3". "MiniPAS" is safe to rely on, since kont_type.yaml's coalescing logic already depends on it being exactly that string. This column is unrelated to LPR_F vs LPR_A: that choice is made before you open a file, this one lives inside the file you already chose.
- **`sks`:** The codes are hierarchical, so a prefix match selects a whole branch. That also makes it easy to select more than you meant: check how many characters your intended group actually needs before filtering with starts_with().

Where these values come from:

- **`lprindberetningssystem`:** [No DST/Sundhedsdatastyrelsen kodeark for this column exists; the value set below is reconstructed from DARTER-team-confirmed facts already established elsewhere in this guide (this pitfalls page, and kont_type.yaml), not from a published code list.](darter-pitfalls.qmd#lpr3-lprindberetningssystem).
- **`sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).

</details>
