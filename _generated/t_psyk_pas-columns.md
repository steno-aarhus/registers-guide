<!-- Generated from schema/registers/t_psyk_pas.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |

<details>
<summary>All other columns (6)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_passarsag` | character | code | Passive waiting time reason code |
| `d_passldto` | date | date | Passive waiting time end date |
| `d_passtdto` | date | date | Passive waiting time start date |
| `c_tilbafd` | character | code | Return department code |
| `c_tilbsgh` | character | code | Return hospital code |
| `d_tilbdto` | date | date | Return date |

- **`d_passldto`:** Read as the END date, following the SLDTO=slut(end) convention confirmed on lpr_vente.yaml's/lpr_pas.yaml's matching column pairs.
- **`d_passtdto`:** Read as the START date under the same SLDTO/STDTO convention as d_passldto above.

</details>

*No published source gives a data type for 7 of these 7 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).
