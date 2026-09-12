<!-- Generated from schema/registers/mfrblodm.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`FK_MFR`** | character | join key |  |

<details>
<summary>All other columns (3)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `KODETYPE` | character | code |  |
| `SKSKODE` | character | code |  |
| `BLODMAENGDE` | numeric | value |  |

- **`SKSKODE`:** No `code_system` attached: an open SKS code space restricted to postpartum-bleeding-related codes by this register's own scope, not documented as a specific list anywhere DST publishes.
- **`BLODMAENGDE`:** The measured blood-loss quantity, by the variable name ("blodmængde" = blood amount). Unit (ml presumably) is not documented by DST anywhere this schema found.

</details>

*No published source gives a data type for 4 of these 4 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `FK_MFR`.

**Joins to other registers:**

- `FK_MFR` joins to **MFR** (many-to-one).

**Worth knowing:**

- **`FK_MFR`:** Foreign key back to mfr.yaml, same pattern as mfrhjmfo.yaml - not confirmed to match mfr's own cpr_barn specifically.
