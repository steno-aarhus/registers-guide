<!-- Generated from schema/registers/lpr_a_betalingsoplysninger.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `BETALER` | character | code | Payer code |
| `BET_AFTALE` | character | code | Payment agreement code |
| `BET_OPL_SPEC_NIV` | character | code | Payment info specification level code |

<details>
<summary>All other columns (10)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `BETALER_TEKST` | character | derived | Payer, text |
| `BET_AFTALE_TEKST` | character | derived | Payment agreement, text |
| `BET_OPL_INDB_TIDSPUNKT` | datetime | date | Payment info reporting time |
| `BET_OPL_SLUTTIDSPUNKT` | datetime | date | Payment info end |
| `BET_OPL_SPEC_NIV_TEKST` | character | derived | Payment info specification level, text |
| `BET_OPL_STARTTIDSPUNKT` | datetime | date | Payment info start |
| `DW_EK_BETALINGSOPLYSNING` | character | identifier | Payment information identifier |
| **`DW_EK_KONTAKT`** | character | join key | Contact identifier |
| **`DW_EK_PROCEDUREREGISTRERING`** | character | join key | Procedure registration identifier |
| `FLAG_BET_OPL_KONT` | character | code | Payment info tied to a contact |

- **`BET_OPL_SLUTTIDSPUNKT`:** LPR3_F's guidance (section 3.6) confirms several consecutive payment- information sets can be reported for one contact/procedure over time: this and BET_OPL_STARTTIDSPUNKT are what let a project pick the validity window that applies at a given point in the care episode.
- **`DW_EK_KONTAKT`:** Populated when the payment info is registered directly on a contact rather than on a specific procedure - LPR3_F's guidance (section 3.6) says a row "hangs" on exactly one of dw_ek_kontakt or dw_ek_procedureregistrering, not necessarily both.
- **`DW_EK_PROCEDUREREGISTRERING`:** Populated when a specific procedure has its own separate payer, distinct from the contact's.
- **`FLAG_BET_OPL_KONT`:** By the variable name, likely a convenience flag mirroring whether dw_ek_kontakt (vs. dw_ek_procedureregistrering) is the populated key - not confirmed by any DST documentation found.

</details>

*No published source gives a data type for 10 of these 13 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `DW_EK_KONTAKT`, `DW_EK_PROCEDUREREGISTRERING`.

**Joins to other registers:**

- `DW_EK_KONTAKT` joins to **LPR_A_KONTAKT** (many-to-one).
- `DW_EK_PROCEDUREREGISTRERING` joins to **LPR_A_PROCREGISTRERING** (many-to-one).
