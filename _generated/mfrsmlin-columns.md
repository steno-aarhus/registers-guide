<!-- Generated from schema/registers/mfrsmlin.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`FK_MFR`** | character | join key |  |

<details>
<summary>All other columns (1)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `SKSKODE` | character | code |  |

- **`SKSKODE`:** No `code_system` attached: an open SKS code space restricted (by the register's own name and its correspondence to mfr.yaml's markoer_smertelindring) to codes relevant to pain relief, but the exact restriction is not documented by DST - same reasoning as mfr_nyfoedte.yaml's Kejsersnit column.

</details>

*No published source gives a data type for 2 of these 2 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `FK_MFR`.

**Joins to other registers:**

- `FK_MFR` joins to **MFR** (many-to-one).

**Worth knowing:**

- **`FK_MFR`:** By its name, a foreign key back to mfr.yaml, the same pattern as mfrhjmfo.yaml's own FK_MFR - not confirmed to match the same column on mfr's side (assumed cpr_barn).
