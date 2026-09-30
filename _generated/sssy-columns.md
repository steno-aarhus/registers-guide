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
| `spec2` | character | code | Specialty, 2-digit |

<details>
<summary>All other columns (17)</summary>

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
| `spec80` | character | code |  | 2021 to 2025 |
| `statpop` | character | code |  | 2021 to 2025 |
| `version` | numeric | date | Version pr. referencetidspunkt for Moduldata |  |

- **`bruhon`:** The fee the provider received, which is broadly the public health insurance subsidy. The patient's own co-payment is NOT included, and group 2 patients and several specialties (dentists, for example) pay part of the fee themselves, so this is public expenditure, not the total cost. In whole kroner from 2005 (SYSI before 2005 is in øre). From 2005 the general practitioners' basic and practice fees, paid per listed patient whether or not the patient attended, are spread over the people who did receive GP services. DST reports that this raised the average fee by about 10 percent from 2004 to 2005, and that the break cannot be removed by cleaning the pre-2005 data.
- **`honuge`:** The week the provider invoiced the region (before 2007, the county) for the service. It is a billing week, not the date of the contact.
- **`kontakt`:** 0 if the service is not a contact, otherwise equal to ydlant. DST counts as contacts the services that involve direct contact between patient and provider: consultations (including phone and e-mail), home visits and the like. How contacts are defined has changed over time, and for physiotherapy and psychology DST calls the count uncertain, so read trends with that in mind. Not in SYSI; SYST has a contact count for 1992-2005, but do not assume it is comparable across the 2005 boundary.
- **`koenimp`:** Imputed where the source was missing, so it is not identical to koen in BEF. Prefer BEF when you need sex as a study variable.
- **`behandlingsdato`:** Only from 2021, and DST publishes neither a label nor a description for it. The name suggests a treatment date, but that is a reading of the name. Before 2021 the register has no contact date at all, only honuge and afrper, which are billing periods.

</details>

*No published source gives a data type for 6 of these 25 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

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
- **`speciale`:** Two codes in one. The first two digits are the provider's specialty (general practice, dentist and so on, the same as spec2); the last four are the type of service. DST publishes no value set for the full code: the service codes come from the collective agreements, and DST points to the historical fee schedules on okportalen.dk. Because the agreements change often, the same service can change code over time, so check a code's history before comparing years.
- **`ydlant`:** One row can cover several services, so counting rows undercounts activity. Sum this column instead.
- **`afrper`:** DST labels this "Afregningsperiode", a settlement period rather than a treatment date. Nothing in the variable list says how far settlement can lag the contact, so check the distribution against honuge before using it as a date.
- **`sikgrup`:** Group 1 patients need a referral from their GP to see a specialist, physiotherapist, chiropodist or psychologist, and pay nothing. Group 2 patients may go directly to any GP or specialist, but pay the difference between the fee and the regional subsidy themselves. The two groups therefore leave different traces for the same clinical need, so group membership is a confounder in any analysis of specialist use. Source: borger.dk, "Sygesikring og sikringsgrupper".
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
- **`spec2`:** The first two digits of speciale: the kind of provider (general practice, ear-nose-throat specialist, dentist, psychologist, laboratory and so on). This is the column to filter on when you want only general practice and practising specialists, because the register also covers dentists, physiotherapists, chiropractors and others. General practice is spread over several codes (daytime, evening and phone consultations have codes of their own), so take the list from DST's value set rather than picking a single code.
