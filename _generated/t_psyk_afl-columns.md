<!-- Generated from schema/registers/t_psyk_afl.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |

<details>
<summary>All other columns (8)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_oafd` | character | code | Operating department |
| `c_opr` | character | code | Planned operation code |
| `c_oprart` | character | code | Operation code type |
| `c_osgh` | character | code | Operating hospital |
| `c_tilopr` | character | code | Supplementary operation code |
| `d_odto` | date | date | Planned operation date |
| `v_ominut` | numeric | value | Planned operation time, minutes |
| `v_otime` | numeric | value | Planned operation time, hour |

- **`c_opr`:** The operation that was cancelled - not a completed one, so these rows should not be added to psychiatric operations counts elsewhere.

</details>

*No published source gives a data type for 9 of these 9 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).
