<!-- Generated from schema/registers/t_psyk_vente.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |

<details>
<summary>All other columns (3)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_vstatus` | character | code | Waiting period status code |
| `d_vsldto` | date | date | Waiting period end date |
| `d_vstdto` | date | date | Waiting period start date |

- **`d_vsldto`:** Read as the END date, following the SLDTO=slut(end) convention confirmed on lpr_vente.yaml's matching pair.
- **`d_vstdto`:** Read as the START date under the same SLDTO/STDTO convention as d_vsldto above.

</details>

*No published source gives a data type for 4 of these 4 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).
