<!-- Generated from schema/registers/sssy.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `ydernr` | character | identifier | Provider number |
| `speciale` | character | code | Specialty, 6-digit |
| `ydlant` | numeric | value | Number of services under the specialty |
| `afrper` | character | date | Settlement period |
| `sikgrup` | character | code | Insurance group |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (18)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `ydtyp` | character | code | Provider type |  |
| `ydltid` | character | code | Service timing code |  |
| `ydersamt` | character | code | Provider's county |  |
| `bruhon` | numeric | value | Gross fee to the provider |  |
| `honuge` | character | date | Fee week |  |
| `barnmak` | character | code | Child marker |  |
| `kontakt` | numeric | value | Contact |  |
| `patgrp` | character | code | Patient group |  |
| `koenimp` | character | code | Sex, imputed values included |  |
| `alderimp` | numeric | value | Alder ultimo inkl. imputerede |  |
| `behandlingsdato` | date | date |  | 2021 to 2025 |
| `cprtjek` | character | code | CPR-tjek |  |
| `cprtype` | character | code | CPR-type |  |
| `registreringstid` | character | code |  | 2021 to 2025 |
| `spec2` | character | code | 2-cifret speciale |  |
| `spec80` | character | code |  | 2021 to 2025 |
| `statpop` | character | code |  | 2021 to 2025 |
| `version` | numeric | date | Version pr. referencetidspunkt for Moduldata |  |

- **`kontakt`:** Not in SYSI. Do not assume a comparable count of contacts before 2005.
- **`koenimp`:** Imputed where the source was missing, so it is not identical to koen in BEF. Prefer BEF when you need sex as a study variable.

</details>

*No published source gives a data type for 6 of these 25 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `koen` | `1` Mand, `2` Kvinde, `9` Uoplyst |

- **`koen`:** DST's classification KOEN_V1_1980 also defines `9` for not stated, which a delivery may not contain but a value set should. Sex is taken from the tenth digit of the CPR number: even is female, odd is male.

Where these values come from:

- **`koen`:** [DST's classification KOEN_V1_1980](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/koen) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e267e7c0-d998-4922-b2c4-6b44b15dd149csv_da)).

</details>

**Worth knowing:**

- **`ydernr`:** A provider number, not a person. DST's variable list does not say what unit it identifies or whether it is stable when a practice changes hands, so do not use it to follow an individual clinician over time without checking that first.
- **`speciale`:** The 6-digit specialty code is what distinguishes a GP contact from a specialist one. There is no separate contact-type column: the specialty is the classification.
- **`ydlant`:** One row can cover several services, so counting rows undercounts activity. Sum this column instead.
- **`afrper`:** DST labels this "Afregningsperiode", a settlement period rather than a treatment date. Nothing in the variable list says how far settlement can lag the contact, so check the distribution against honuge before using it as a date.
- **`sikgrup`:** Group 1 patients need a referral from their GP to see a specialist, physiotherapist, chiropodist or psychologist, and pay nothing. Group 2 patients may go directly to any GP or specialist, but pay the difference between the fee and the regional subsidy themselves. The two groups therefore leave different traces for the same clinical need, so group membership is a confounder in any analysis of specialist use. Source: borger.dk, "Sygesikring og sikringsgrupper".
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
