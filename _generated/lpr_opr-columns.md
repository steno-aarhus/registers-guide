<!-- Generated from schema/registers/lpr_opr.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

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

- **`c_komb`:** DST's own label is bare ('Kombination') with no further definition of what is being combined - not confirmed beyond the label itself.

</details>

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).

**Worth knowing:**

- **`c_opr`:** ICD8-era operation code, not comparable to lpr_sksopr.yaml's SKS codes without a crosswalk - the two schemes are not simply renamed versions of each other.
