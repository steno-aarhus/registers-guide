<!-- Generated from schema/registers/t_psyk_sksube.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_opr` | character | code | Procedure code |

<details>
<summary>All other columns (7)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_oafd` | character | code | Performing department |
| `c_oprart` | character | code | Procedure code type |
| `c_osgh` | character | code | Performing hospital |
| `c_tilopr` | character | code | Supplementary procedure code |
| `d_odto` | date | date | Procedure date |
| `v_ominut` | numeric | value | Procedure time, minutes |
| `v_otime` | numeric | value | Procedure time, hour |

- **`c_oprart`:** Same '+' add-on mechanism as t_psyk_sksopr.yaml's c_oprart.

</details>

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`sks`:** The codes are hierarchical, so a prefix match selects a whole branch. That also makes it easy to select more than you meant: check how many characters your intended group actually needs before filtering with starts_with().

Where these values come from:

- **`sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).

</details>
