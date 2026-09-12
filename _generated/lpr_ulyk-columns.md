<!-- Generated from schema/registers/lpr_ulyk.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

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

- **`c_art`:** Same add-on mechanism as lpr_diag.yaml's diagnosis add-on codes and lpr_afl.yaml's c_oprart: flags that c_tilulyk holds a supplementary code rather than c_ulyk being a standalone accident code.

</details>

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).
