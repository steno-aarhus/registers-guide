<!-- Generated from schema/registers/t_psyk_udtilsgh.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_udtilsgh` | character | code | Discharged to hospital code |

<details>
<summary>All other columns (1)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_udtilafd` | character | code | Discharged to department code |

</details>

*No published source gives a data type for 3 of these 3 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).
