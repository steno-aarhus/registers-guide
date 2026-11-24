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
| `barnmak` | integer | code | Child marker |  |
| `pattyp` | character | code | Patient type |  |
| `praktyp` | character | code | Practice type |  |
| `sikrekom` | character | code | Municipality of the insured |  |
| `grdhon` | character | code | GRUNDHONORAR | 1997 to 2005 |
| `henvisni` | character | code | Henvisningsydernummer |  |
| `paragraf` | character | code | PARAGRAFRELATION | 1997 to 2005 |
| `praksiso` | character | code | PRAKSISOMRÅDE | 1997 to 2005 |
| `sikreamt` | character | code | Sikredes amt |  |
| `vagtomr` | character | code | VAGTOMRÅDE | 1997 to 2005 |

- **`bruhon`:** In ØRE for 1990-2004 and whole kroner from 2005, so divide the pre-2005 values by 100 before combining them with SSSY. It is the fee the provider received, broadly the public subsidy; the patient's own co-payment is not included. DST reports that the average fee rose about 10 percent from 2004 to 2005 because general practitioners' basic and practice fees were spread onto users from 2005, and that this break cannot be removed by cleaning the pre-2005 data.
- **`honuge`:** The week the provider invoiced the county (from 2007, the region) for the service. It is a billing week, not the date of the contact.
- **`barnmak`:** 1 means a child whose own CPR-number is not on the row, 0 everything else (DST, BARNMAK). Until 1 January 1996 children under 16 had no health insurance card of their own, so their services were registered under a parent's CPR-number, and the introduction was complete in 1997. 1996 is a run-in year, and sex cannot be assigned to services to children before 1996 (Sundhedsdatastyrelsen, register declaration). In 1990 to 1996 every service to a child carries barnmak 1, which DST puts at 5.5 to 7.5 million records for the period, against 876,542 in 1997 (DST, BARNMAK). The pnr on a row with barnmak 1 is the adult's, so such rows are not the child's own contacts. Sahl Andersen et al. 2011, Scand J Public Health 39(Suppl 7):34-37, describe the same change.

</details>

*No published source gives a data type for 21 of these 22 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |

- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality - confirmed for two reused codes against a current-only DST source: 707 is Norddjurs today, not its pre-2007 meaning, and likewise 849 is Jammerbugt. `lookup:` below covers only this post-2007 set (99 entries), not the full 278-code `values_from` file. Christiansø (411) is included in `lookup:` even though it is not a municipality (see description above): it is a real value a `kom` column can hold, and DST's own current-only classification lists it as its own area code alongside the 98 municipalities. Excluding it would just move the "unhandled code" problem this fix is meant to solve onto that one value.

Where these values come from:

- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).

</details>

**Worth knowing:**

- **`ydernr`:** A provider number, not a person. DST's variable list does not say what unit it identifies or whether it is stable when a practice changes hands, so do not use it to follow an individual clinician over time without checking that first.
- **`speciale`:** Two codes in one. The first two digits are the provider's specialty (general practice, dentist and so on); the last four are the type of service. DST publishes no value set for the full code: the service codes come from the collective agreements, and DST points to the historical fee schedules on okportalen.dk. Because the agreements change often, the same service can change code over time, so check a code's history before comparing years. The same wording, for example "Konsultation", appears under many specialties, so read a six-digit code together with its first two digits (DST, SPECIALE).
- **`ydlant`:** One row can cover several services, so counting rows undercounts activity. Sum this column instead.
- **`afrper`:** DST labels this "Afregningsperiode", a settlement period rather than a treatment date. Nothing in the variable list says how far settlement can lag the contact, so check the distribution against honuge before using it as a date.
- **`sikgrup`:** Group 1 patients need a referral from their GP to see a specialist, physiotherapist, chiropodist or psychologist, and pay nothing. Group 2 patients may go directly to any GP or specialist, but pay the difference between the fee and the regional subsidy themselves. The two groups therefore leave different traces for the same clinical need, so group membership is a confounder in any analysis of specialist use. Source: borger.dk, "Sygesikring og sikringsgrupper".
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
