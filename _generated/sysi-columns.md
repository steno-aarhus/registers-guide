<!-- Generated from schema/registers/sysi.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `ydernr` | character | identifier | Provider number |
| `speciale` | character | code | Specialty, 6-digit |
| `ydtyp` | character | code | Provider type |
| `ydlant` | integer | value | Number of services under the specialty |
| `ydltid` | character | code | Service timing code |
| `ydersamt` | character | code | Provider's county |
| `afrper` | character | date | Settlement period |
| `bruhon` | numeric | value | Gross fee to the provider |
| `honuge` | character | date | Fee week |
| `barnmak` | character | code | Child marker |
| `sikgrup` | character | code | Insurance group |
| `pattyp` | character | code | Patient type |
| `praktyp` | character | code | Practice type |
| `sikrekom` | character | code | Municipality of the insured |

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts) |

- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.

</details>

**Worth knowing:**

- **`ydernr`:** Identifies the practice, not the person treating you. It changes when a practice changes hands, so it does not track a doctor over time.
- **`speciale`:** The 6-digit specialty code is what distinguishes a GP contact from a specialist one. There is no separate contact-type column: the specialty is the classification.
- **`ydlant`:** One row can cover several services, so counting rows undercounts activity. Sum this column instead.
- **`afrper`:** A settlement period, not a treatment date. It says when the fee was settled, which can fall in a later week or month than the contact.
- **`sikgrup`:** Group 1 patients are listed with a GP and need a referral to see most specialists; group 2 patients may go directly but pay part of the fee. The two groups therefore generate different rows for the same need.
