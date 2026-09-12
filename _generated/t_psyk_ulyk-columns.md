<!-- Generated from schema/registers/t_psyk_ulyk.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_ulyk` | character | code | Accident/injury code |

<details>
<summary>All other columns (2)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_art` | character | code | Supplementary code indicator |
| `c_tilulyk` | character | code | Supplementary accident code |

- **`c_art`:** Same add-on mechanism as lpr_ulyk.yaml's c_art: flags that c_tilulyk holds a supplementary code.

</details>

*No published source gives a data type for 4 of these 4 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).
