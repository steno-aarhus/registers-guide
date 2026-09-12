<!-- Generated from schema/registers/t_psyk_opr.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_opr` | character | code | Operation code |

<details>
<summary>All other columns (3)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_komb` | character | code | Combination code |
| `c_oafd` | character | code | Operating department |
| `c_osgh` | character | code | Operating hospital |

- **`c_komb`:** Same bare label as lpr_opr.yaml's own c_komb - DST does not define what is being combined.

</details>

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).

**Worth knowing:**

- **`c_opr`:** ICD8-era operation code, not comparable to t_psyk_sksopr.yaml's SKS codes without a crosswalk.
