<!-- Generated from schema/registers/dod.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `doddato` | date | date | Date of death |

<details>
<summary>All other columns (3)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `alder_haend` | integer | value | Age at the time of death |
| `cprtjek` | character | value | CPR check |
| `cprtype` | character | value | CPR type |

</details>

*No published source gives a data type for 5 of these 5 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

**Worth knowing:**

- **`doddato`:** This is the column to censor on. Not `d_dodsdto`, which belongs to DODSAARS and stops in 2001.
