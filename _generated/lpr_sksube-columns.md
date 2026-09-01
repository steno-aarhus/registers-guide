<!-- Generated from schema/registers/lpr_sksube.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_opr` | character | code | Procedure code |
| `c_oprart` | character | code | Procedure type |
| `c_osgh` | character | code | Hospital performing the procedure |
| `c_tilopr` | character | code | Supplementary code |
| `d_odto` | date | date | Procedure date |

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`sks`:** The codes are hierarchical, so a prefix match selects a whole branch. That also makes it easy to select more than you meant: check how many characters your intended group actually needs before filtering with starts_with().

</details>

**Worth knowing:**

- **`c_opr`:** Check that you actually have this column. DST documents it for every year 1999-2019, but the DARTER delivery of this table contains only recnum, d_odto and year, which leaves no way to tell one procedure from another. Without it the table is unusable, and no filtering recovers it.
