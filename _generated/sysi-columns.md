<!-- Generated from schema/registers/sysi.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `ydernr` | character | identifier | Provider number |
| `speciale` | character | code | Specialty, 6-digit |
| `ydlant` | integer | value | Number of services under the specialty |
| `afrper` | character | date | Settlement period |
| `sikgrup` | character | code | Insurance group |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (15)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `ydtyp` | character | code | Provider type |  |
| `ydltid` | character | code | Service timing code |  |
| `ydersamt` | character | code | Provider's county |  |
| `bruhon` | numeric | value | Gross fee to the provider |  |
| `honuge` | character | date | Fee week |  |
| `barnmak` | character | code | Child marker |  |
| `pattyp` | character | code | Patient type |  |
| `praktyp` | character | code | Practice type |  |
| `sikrekom` | character | code | Municipality of the insured |  |
| `grdhon` | character | code | GRUNDHONORAR | 1997 to 2005 |
| `henvisni` | character | code | Henvisningsydernummer |  |
| `paragraf` | character | code | PARAGRAFRELATION | 1997 to 2005 |
| `praksiso` | character | code | PRAKSISOMRÅDE | 1997 to 2005 |
| `sikreamt` | character | code | Sikredes amt |  |
| `vagtomr` | character | code | VAGTOMRÅDE | 1997 to 2005 |

</details>

*No published source gives a data type for 21 of these 22 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |

- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.

Where these values come from:

- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).

</details>

**Worth knowing:**

- **`ydernr`:** A provider number, not a person. DST's variable list does not say what unit it identifies or whether it is stable when a practice changes hands, so do not use it to follow an individual clinician over time without checking that first.
- **`speciale`:** The 6-digit specialty code is what distinguishes a GP contact from a specialist one. There is no separate contact-type column: the specialty is the classification.
- **`ydlant`:** One row can cover several services, so counting rows undercounts activity. Sum this column instead.
- **`afrper`:** DST labels this "Afregningsperiode", a settlement period rather than a treatment date. Nothing in the variable list says how far settlement can lag the contact, so check the distribution against honuge before using it as a date.
- **`sikgrup`:** Group 1 patients need a referral from their GP to see a specialist, physiotherapist, chiropodist or psychologist, and pay nothing. Group 2 patients may go directly to any GP or specialist, but pay the difference between the fee and the regional subsidy themselves. The two groups therefore leave different traces for the same clinical need, so group membership is a confounder in any analysis of specialist use. Source: borger.dk, "Sygesikring og sikringsgrupper".
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
