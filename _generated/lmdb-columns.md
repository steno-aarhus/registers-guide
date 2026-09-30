<!-- Generated from schema/registers/lmdb.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 1995-Q2 to 2025-Q2 |
| `eksd` | date | date | Dispensing date | 1995-Q2 to 2025-Q2 |
| `atc` | character | code | ATC code, full 7 characters | 1995-Q2 to 2025-Q2 |
| `atc1` | character | code | ATC level 1 (1 character) | 1995-Q2 to 2025-Q2 |
| `atc2` | character | code | ATC level 2 (3 characters) | 1995-Q2 to 2025-Q2 |
| `atc3` | character | code | ATC level 3 (4 characters) | 1995-Q2 to 2025-Q2 |
| `atc4` | character | code | ATC level 4 (5 characters) | 1995-Q2 to 2025-Q2 |
| `vnr` | character | code | Item number (product key) | 1995-Q2 to 2025-Q2 |
| `apk` | numeric | value | Number of packages | 1995-Q2 to 2025-Q2 |
| `year` | integer | date | Dispensing year |  |

<details>
<summary>All other columns (55)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `indo` | character | code | Indication code | 2004-Q2 to 2025-Q2 |
| `packsize` | numeric | value | Package size | 1995-Q2 to 2025-Q2 |
| `strnum` | numeric | value | Strength, numeric | 1995-Q2 to 2025-Q2 |
| `strunit` | character | value | Unit for the numeric strength | 1995-Q2 to 2025-Q2 |
| `aldr` | numeric | value | Age at dispensing | 1995 to 2025 |
| `abc` | character | code | ABC code (price rank within substitution group) | 2007 to 2025 |
| `aip` | numeric | value | Pharmacy purchase price per package | 1995 to 2025 |
| `aref` | character | code | Other reimbursement schemes | 1995 to 2025 |
| `aup` | numeric | value | Pharmacy retail price per package | 1995 to 2025 |
| `bald` | character | code | Child's age (code) | 1995 to 2011 |
| `cprtjek` | character | code | CPR check | 1995 to 2025 |
| `cprtype` | character | code | CPR type | 1995 to 2025 |
| `cpr_kom` | character | code | Municipality of residence (CPR) on the dispensing date | 2005 to 2025 |
| `cpr_reg` | character | code | Region of residence (CPR) on the dispensing date | 2005 to 2025 |
| `dosform` | character | code | Pharmaceutical form | 1995 to 2025 |
| `doso` | character | code | Dosage code | 2004 to 2025 |
| `edbl` | character | code |  | 2020 to 2025 |
| `ejs` | character | code | Substitution opted out | 1997 to 2025 |
| `eksp` | numeric | value | Total price of the dispensing | 1995 to 2025 |
| `ekst` | character | code | Dispensing type | 1995 to 2025 |
| `etid` | numeric | date | Dispensing time | 1997 to 2025 |
| `ibgp` | numeric | value | Reported subsidy calculation price | 2000 to 2025 |
| `ibnr` | character | code | Reporter number | 1995 to 2025 |
| `itype` | character | code | Reporter type | 1995 to 2025 |
| `kom` | character | code | Municipality code (paying municipality) | 1995 to 2025 |
| `korr` | character | code | Correction code | 1995 to 2025 |
| `name` | character | code | Product name | 1995 to 2025 |
| `ovnr` | character | code | Prescribed item number | 1997 to 2025 |
| `packtext` | character | code | Package text | 1995 to 2025 |
| `patt` | character | code | Patient type | 2000 to 2025 |
| `pksubgr` | character | code | Package substitution group | 2007 to 2025 |
| **`pnr12`** | character | join key | CPR number | 1995 to 2025 |
| `pprs` | character | code | Dispensing restriction | 1995 to 2025 |
| `ptp` | character | code | Patient payment | 1995 to 2025 |
| `ramt` | character | code | County/region code (paying authority) | 1995 to 2025 |
| `reca` | character | code | Authorisation code of the prescriber | 2005 to 2025 |
| `recu` | character | code | Prescriber | 1995 to 2025 |
| `rgl1` | character | code | Municipal rule number 1 | 1995 to 2025 |
| `rgl2` | character | code | Municipal rule number 2 | 1995 to 2025 |
| `rgla` | character | code | Regional subsidy rule number | 1995 to 2025 |
| `rimb` | character | code | Subsidy code | 1995 to 2025 |
| `rinr` | character | code | Repeat (reiteration) number | 1995 to 2025 |
| `sektor` | character | code | Sector | 1995 to 2025 |
| `streng` | character | code | Strength, plain text | 1995 to 2025 |
| `takd` | date | date | Tariff date | 1995 to 2025 |
| `tard` | date | date | Pricing date | 2000 to 2025 |
| `tilpris` | numeric | value | Subsidy price per package | 1995 to 2025 |
| `tsk1` | character | code | Municipal subsidy 1 | 1995 to 2025 |
| `tsk2` | character | code | Municipal subsidy 2 | 1995 to 2025 |
| `tsk3` | character | code | Other subsidies | 1995 to 2025 |
| `tska` | character | code | Regional medicine subsidy | 1995 to 2025 |
| `udlv` | character | code | Place of dispensing | 1995 to 2025 |
| `voltypecode` | character | code |  | 1995 to 2025 |
| `voltypetxt` | character | code |  | 1995 to 2025 |
| `volume` | character | code | Volume (unit given by voltypecode) | 1995 to 2025 |

- **`indo`:** Recorded only when the prescriber picks an indication from the drop-down. Typed as free text it is not carried over, so the column is often empty.
- **`aldr`:** In 1994-1995 a few ages look like ranges (for example 0-3): a future CPR number was reported, giving a negative age, and those rows should be ignored. Where bald is filled, this is the parent's age, not the child's.
- **`aup`:** The price of one package at the time of pricing (tard): the purchase price (aip) plus the pharmacy margin plus VAT. It excludes the prescription fee, and the margin formula changes regularly.
- **`bald`:** Used until March 2011 when a medicine for someone under 18 was registered on a parent's or a substitute CPR number. When it is filled, pnr, sex and age belong to the parent. Children got their own health insurance card from 1 January 1996, but the change was only nearly complete by summer 1996, so before that children's use is undercounted and young women's (usually the mother's) overcounted.
- **`cpr_kom`:** Filled only from January 2005. The patient's municipality of residence from CPR at the time of purchase; use this, not kom, for where the patient lived.
- **`cpr_reg`:** Filled only from January 2005. The patient's region of residence from CPR at the time of purchase; use this, not ramt, for where the patient lived.
- **`doso`:** Introduced 1 April 2004, and some prescribing systems only from 1 April 2005. A dose written as free text gets no code; in 2012 about 57 percent of prescriptions had one.
- **`ejs`:** The substitution rules changed in 1997 (in this register from October 1997) and were simplified in June 2001, so the meaning of an empty field differs across those dates.
- **`eksp`:** Total price in kroner including VAT; for a prescription at a community pharmacy it is (aup + prescription fee) times the number of packages. Hospital pharmacies used internal settlement prices until 2011 and the last registered purchase price from 2011, so hospital data are not comparable across 2011, and turnover from community and hospital pharmacies cannot be compared at all.
- **`ekst`:** Sundhedsdatastyrelsen advises against selecting data on this field alone, because the types were not always used correctly (in 1994, for example, some prescriptions were reported as over-the-counter sales).
- **`etid`:** Introduced October 1997. Only from March 2000 was it required to be the time the medicine was handed over; before that it is unknown which time was reported, and some pharmacies are suspected of still reporting the pricing time.
- **`ibgp`:** In kroner including VAT. Some pharmacies left it empty for patients entitled to a subsidy who were still paying in full; corrected from 2003.
- **`kom`:** The municipality that paid a municipal subsidy, not where the patient lived: use cpr_kom for residence. Municipality codes change at the 2007 reform.
- **`korr`:** 1 marks a correction (a reversal, with negative apk, volume or eksp), 0 a normal row. Until 1996 a value 2 also existed and has been recoded to 1. One hospital pharmacy reported corrections with positive counts until January 2005, so it shows no corrections before then and its total price is overestimated.
- **`patt`:** Introduced with the needs-based subsidy system on 1 March 2000. Some pharmacies left it empty for patients entitled to a subsidy who were still paying in full; corrected from 2003.
- **`ptp`:** The patient's payment in kroner including VAT, normally eksp minus tska, tsk1 and tsk2. A few rows do not add up.
- **`ramt`:** The region (until 2006, the county) that paid the subsidy, not where the patient lived: use cpr_reg for residence.
- **`rgla`:** New rule codes came in on 1 March 2000 and some pharmacies kept using the old ones for a while. Before March 2000, 00 meant that a subsidy was paid, but some pharmacies used 00 as a default on every row until December 2000.
- **`rinr`:** Sundhedsdatastyrelsen says not to rely much on this field, especially for paper prescriptions: several pharmacy systems misused codes 00 and 01 until 2003.
- **`tard`:** The date the price and subsidy price were set, introduced with the subsidy system in March 2000. It can differ from eksd, the date the medicine was handed over: in January-September 2012, 83 percent of prescriptions had the two dates equal.
- **`tska`:** The regional medicine subsidy in kroner including VAT. Pharmacies give the regions a 1.72 percent discount (excluding VAT), so Sundhedsdatastyrelsen says to multiply by 0.98624 to get the regions' actual expense. Should be 0 for subsidy-eligible purchases below the subsidy threshold, but is not always.

</details>

*No published source gives a data type for 28 of these 65 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `atc` | Not listed here - see [DST's classification](https://atcddd.fhi.no/atc/structure_and_principles/) |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |
| `reg` | `0` Uoplyst, `81` Nordjylland, `82` Midtjylland, `83` Syddanmark, `84` Hovedstaden, `85` Sjælland |

- **`atc`:** As a rule, filter on the full 7-character code rather than on the level columns: `atc2` holds three characters, so a longer pattern matched against it can never match, and it returns nothing at all with no error. The level columns are well suited to grouping, and to filtering when every code you want is the same length as the column.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality - confirmed for two reused codes against a current-only DST source: 707 is Norddjurs today, not its pre-2007 meaning, and likewise 849 is Jammerbugt. `lookup:` below covers only this post-2007 set (99 entries), not the full 278-code `values_from` file. Christiansø (411) is included in `lookup:` even though it is not a municipality (see description above): it is a real value a `kom` column can hold, and DST's own current-only classification lists it as its own area code alongside the 98 municipalities. Excluding it would just move the "unhandled code" problem this fix is meant to solve onto that one value.
- **`reg`:** Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.

Where these values come from:

- **`atc`:** [WHO ATC/DDD Index](https://atcddd.fhi.no/atc/structure_and_principles/).
- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).
- **`reg`:** [DST's regional classification](https://www.dst.dk/extranet/ForskningVariabellister/BEF%20-%20Befolkningen.html).

</details>

**Worth knowing:**

- **`pnr`:** DST's variable list calls this column `PNR12`. Check whether your variable is named `pnr` or `pnr12`. Do not confuse this with the `pnr` documented on esundhed's page for this register (DocumentationExtended?id=14): that `pnr` is the pharmacy or manufacturer's production-unit number, length 10, not a person. Same name, unrelated variable, on the two pages that between them cover this register. Before 1996, a child's prescriptions were filed under the mother's `pnr`, not the child's own - community pharmacies only switched to issuing prescriptions under the child's own name from 1996 onward (Pottegård et al. 2017, doi:10.1093/ije/dyw213). Filtering this register by a child's own `pnr` for exposure before 1996 silently misses those rows: they are not absent, they are attributed to a different person entirely.
- **`eksd`:** The date the prescription was collected at the pharmacy. Not the date it was prescribed, and not evidence that the medicine was taken.
- **`atc`:** The newest ATC code for the product is always attached, also to earlier years. A count made some years ago can therefore differ from a new one if a product's code has changed since.
- **`vnr`:** The only reliable way to isolate one specific product. Two brands with the same active substance share an ATC code but have different item numbers.
- **`apk`:** Hospital pharmacies can report decimals, everyone else whole numbers. Blank for hospital-pharmacy parenteral service products in ATC groups J01 and L01 from 2011. For dose-dispensed medicine (ekst DD) units are reported rather than packages, and before 2007 some of those units were wrongly read as whole packages.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
