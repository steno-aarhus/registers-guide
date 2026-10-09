<!-- Generated from schema/registers/lpr_a_henvisning_tillaeg.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `HENV_AARSAG_TILL` | character | code | Referral reason addendum code |

<details>
<summary>All other columns (4)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_FORLOEB`** | character | join key | Course identifier |
| **`DW_EK_KONTAKT`** | character | join key | Contact identifier |
| `HENV_AARSAG_TILL_TEKST` | character | derived | Referral reason addendum, text |
| `LPRINDBERETNINGSSYSTEM` | character | code | Reporting system |

- **`DW_EK_KONTAKT`:** A referral reason can be registered on a course OR a contact (Sundhedsdatastyrelsen's LPR3_F guidance, section 3.10): a row here may have one of dw_ek_forloeb/dw_ek_kontakt populated and the other empty, not necessarily both.

</details>

*No published source gives a data type for 5 of these 5 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `DW_EK_FORLOEB`, `DW_EK_KONTAKT`.

**Joins to other registers:**

- `DW_EK_FORLOEB` joins to **LPR_A_FORLOEB** (many-to-one).
- `DW_EK_KONTAKT` joins to **LPR_A_KONTAKT** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `lprindberetningssystem` | `LPR3`, `MiniPAS`, `LPR2`, `LPR1` |

- **`lprindberetningssystem`:** Confirm the exact strings with `count(lprindberetningssystem)` before relying on "LPR2" or "LPR1" in a filter: they are well-established as concepts in this guide, but nobody has pasted the literal value back from DARTER the way pitfall 5 did for "LPR3". "MiniPAS" is safe to rely on, since kont_type.yaml's coalescing logic already depends on it being exactly that string. This column is unrelated to LPR_F vs LPR_A: that choice is made before you open a file, this one lives inside the file you already chose.

Where these values come from:

- **`lprindberetningssystem`:** [No DST/Sundhedsdatastyrelsen kodeark for this column exists; the value set below is reconstructed from DARTER-team-confirmed facts already established elsewhere in this guide (this pitfalls page, and kont_type.yaml), not from a published code list.](darter-pitfalls.qmd#lpr3-lprindberetningssystem).

</details>
