<!-- Generated from schema/registers/dod.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 2025 to 2025 |
| `doddato` | date | date | Date of death | 2025 to 2025 |

<details>
<summary>All other columns (3)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `alder_haend` | integer | value | Age at the time of death | 2025 to 2025 |
| `cprtjek` | character | value | CPR check | 2025 to 2025 |
| `cprtype` | character | value | CPR type | 2025 to 2025 |

</details>

*The Type column is read off the column name for 5 of these 5 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Worth knowing:**

- **`doddato`:** This is the column to censor on. Not `d_dodsdto`, which belongs to DODSAARS and stops in 2001.
