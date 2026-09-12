<!-- Generated from schema/registers/lpr_udtilsgh.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

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

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).
