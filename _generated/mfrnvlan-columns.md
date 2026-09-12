<!-- Generated from schema/registers/mfrnvlan.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`FK_MFR`** | character | join key |  |

<details>
<summary>All other columns (5)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `KODETYPE` | character | code |  |
| `SKSKODE` | character | code |  |
| `TILLAEGSKODE` | character | code |  |
| `PH_VAERDI` | numeric | value |  |
| `BASE_EXCESS` | numeric | value |  |

- **`SKSKODE`:** No `code_system` attached: an open SKS code space restricted to cord-blood-analysis-related codes by this register's own scope, not documented as a specific list anywhere DST publishes.
- **`TILLAEGSKODE`:** An SKS add-on code to SKSKODE, by the variable name (tillæg = addition) - the same +-type concept as mfr_diagnose_type.yaml's add-on codes, not confirmed to share that exact mechanism.
- **`PH_VAERDI`:** Cord blood pH value, by the variable name.
- **`BASE_EXCESS`:** A standard blood-gas measurement, alongside PH_VAERDI for interpreting cord blood acid-base status.

</details>

*No published source gives a data type for 6 of these 6 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `FK_MFR`.

**Joins to other registers:**

- `FK_MFR` joins to **MFR** (many-to-one).

**Worth knowing:**

- **`FK_MFR`:** Foreign key back to mfr.yaml, same pattern as mfrhjmfo.yaml - not confirmed to match mfr's own cpr_barn specifically.
