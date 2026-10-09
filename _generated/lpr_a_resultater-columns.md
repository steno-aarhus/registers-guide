<!-- Generated from schema/registers/lpr_a_resultater.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `RES_INDB` | character | code | Result report type code |

<details>
<summary>All other columns (22)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_FORLOEB`** | character | join key | Course identifier |
| **`DW_EK_KONTAKT`** | character | join key | Contact identifier |
| **`DW_EK_PROCEDUREREGISTRERING`** | character | join key | Procedure registration identifier |
| `DW_EK_RESULTATINDBERETNING` | character | identifier | Result report identifier |
| `LPRINDBERETNINGSSYSTEM` | character | code | Reporting system |
| `RES_INDB_ANS` | character | code | Result reported by code |
| `RES_INDB_ANS_INST` | character | code | Responsible institution code |
| `RES_INDB_LPR_ENTITY_ID` | character | code | Result report LPR entity ID |
| `RES_INDB_STATUS` | character | code | Result report status code |
| `RES_INDB_STATUS_TEKST` | character | derived | Result report status, text |
| `RES_INDB_TEKST` | character | derived | Result report type, text |
| `RES_INDB_TIDSPUNKT` | datetime | date | Result report time |
| `RES_TYPE` | character | code | Result value type code |
| `RES_TYPE_TEKST` | character | derived | Result value type, text |
| `RES_UDFOERT_TIDSPUNKT` | datetime | date | Result performed time |
| `RES_VAERDI_PNR` | character | value | Result value, personal-number type |
| `RES_VAERDI_TAL` | numeric | value | Result value, numeric type |
| `RES_VAERDI_TEKST` | character | value | Result value, text type |
| `RES_VAERDI_TIDSPUNKT` | datetime | value | Result value, datetime type |
| `TRIGGERKODE` | character | code | Trigger code |
| `TRIGGERKODE_TEKST` | character | derived | Trigger, text |
| `TRIGGERTYPE` | character | code | Trigger type code |

- **`DW_EK_FORLOEB`:** A result report is always tied to at least a course, per LPR3_F's guidance (section 3.7) - dw_ek_forloeb should be the most reliably populated of the three join keys here.
- **`RES_INDB_ANS`:** Reads as the responsible (ansvarlig) reporter of the result - not confirmed by DST documentation beyond the column name.
- **`RES_TYPE`:** Marks which of the four RES_VAERDI_* typed columns is actually populated for this row - not confirmed by DST documentation, inferred from the four parallel typed value columns below.
- **`RES_UDFOERT_TIDSPUNKT`:** When the underlying clinical event happened, distinct from res_indb_tidspunkt (when the report was submitted).
- **`RES_VAERDI_PNR`:** One of four typed value columns (PNR/TAL/TEKST/TIDSPUNKT) for the same underlying result - only one should be populated per row, per res_type. Not confirmed by DST documentation.

</details>

*No published source gives a data type for 20 of these 23 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `DW_EK_FORLOEB`, `DW_EK_KONTAKT`.

**Joins to other registers:**

- `DW_EK_FORLOEB` joins to **LPR_A_FORLOEB** (many-to-one).
- `DW_EK_KONTAKT` joins to **LPR_A_KONTAKT** (many-to-one).
- `DW_EK_PROCEDUREREGISTRERING` joins to **LPR_A_PROCREGISTRERING** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `lprindberetningssystem` | `LPR3`, `MiniPAS`, `LPR2`, `LPR1` |

- **`lprindberetningssystem`:** Confirm the exact strings with `count(lprindberetningssystem)` before relying on "LPR2" or "LPR1" in a filter: they are well-established as concepts in this guide, but nobody has pasted the literal value back from DARTER the way pitfall 5 did for "LPR3". "MiniPAS" is safe to rely on, since kont_type.yaml's coalescing logic already depends on it being exactly that string. This column is unrelated to LPR_F vs LPR_A: that choice is made before you open a file, this one lives inside the file you already chose.

Where these values come from:

- **`lprindberetningssystem`:** [No DST/Sundhedsdatastyrelsen kodeark for this column exists; the value set below is reconstructed from DARTER-team-confirmed facts already established elsewhere in this guide (this pitfalls page, and kont_type.yaml), not from a published code list.](darter-pitfalls.qmd#lpr3-lprindberetningssystem).

</details>
