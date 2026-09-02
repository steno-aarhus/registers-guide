<!-- Generated from schema/registers/lpr_adm.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier | 1977 to 2019 |
| `pnr` | character | identifier | Personal identifier | 1977 to 2019 |
| `d_inddto` | date | date | Date of admission | 1977 to 2019 |
| `d_uddto` | date | date | Date of discharge | 1977 to 2019 |
| `c_pattype` | character | code | Patient type | 1977 to 2019 |
| `c_spec` | character | code | Specialty | 1977 to 2019 |
| `c_adiag` | character | code | Action diagnosis | 1977 to 2019 |
| `c_indm` | character | code | Admission mode | 1977 to 2019 |
| `year` | integer | date | Register year |  |

<details>
<summary>All other columns (43)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `c_sgh` | character | code | Hospital | 1977 to 2019 |
| `c_afd` | character | code | Department | 1977 to 2019 |
| `v_alder` | numeric | value | Age at the start of the contact | 1977 to 2019 |
| `c_udm` | character | code | Discharge mode | 1987 to 2019 |
| `c_henm` | character | code | Referral mode | 1987 to 2019 |
| `c_kontaars` | character | code | Reason for the contact | 1987 to 2019 |
| `c_bopamt` | character | code | County of residence | 1977 to 2004 |
| `c_amt` | character | code | County | 2005 to 2019 |
| `v_sengdage` | numeric | value | Bed days | 1994 to 2019 |
| `v_behdage` | numeric | value | Treatment days | 1977 to 2019 |
| `c_sex` | character | code | Sex | 1977 to 2019 |
| `cprtjek` | character | code | CPR-tjek | 1977 to 2019 |
| `cprtype` | character | code | CPR-type | 1977 to 2019 |
| `c_andenbeh` | character | code |  | 1977 to 1986 |
| `c_blok` | character | code | Inddeling af speciale i blokke | 1994 to 2019 |
| `c_eakt` | character | code | Ulykkeskode, aktivitet | 1987 to 2003 |
| `c_emek` | character | code |  | 1987 to 2003 |
| `c_emodpart` | character | code | Ulykkeskode, modpart | 1994 to 2003 |
| `c_epart` | character | code | Ulykkeskode, egenpart | 1994 to 2003 |
| `c_ested` | character | code | Ulykkeskode, sted | 1987 to 2003 |
| `c_etraf` | character | code | Ulykkeskode, trafikal | 1987 to 2003 |
| `c_hafd` | character | code | Henvisende afdeling | 2004 to 2019 |
| `c_hsgh` | character | code | Henvisende sygehus | 2004 to 2019 |
| `c_indform` | character | code |  | 1977 to 1986 |
| `c_indfra` | character | code |  | 1977 to 1986 |
| `c_kom` | character | code | Kommune | 1977 to 2019 |
| `c_nyafd` | character | code |  | 2005 to 2019 |
| `c_senstat` | character | code |  | 1977 to 1986 |
| `c_sghamt` | character | code | Sygehusamt | 1977 to 2019 |
| `c_udtil` | character | code |  | 1977 to 1986 |
| `c_ulykke` | character | code |  | 1977 to 1986 |
| `d_ebhdto` | date | date | Data for endelig behandling (Variabel udgået efter 31.12.2003) | 1996 to 2019 |
| `d_fusdto` | date | date | Dato for forundersøgelse (Variabel udgået efter 31.12.2003) | 1996 to 2019 |
| `d_hendto` | date | date | Henvisningsdato | 1977 to 2019 |
| `d_opdatdto` | date | date | Intern dato for opdatering af kontakten | 2005 to 2019 |
| `k_afd` | character | code | Afdelingskode | 2005 to 2019 |
| `leverancedato` | date | date |  | 1977 to 2019 |
| `version` | character | code | Version | 1977 to 2019 |
| `v_alddg` | numeric | value | Alder i dage ved kontaktens start | 2001 to 2019 |
| `v_aldmdr` | numeric | value | Alder i måneder ved kontaktens start | 2001 to 2019 |
| `v_indminut` | numeric | value | Indlæggelsminut | 1994 to 2019 |
| `v_indtime` | numeric | date | Indlæggelsestidspunkt | 1977 to 2019 |
| `v_udtime` | numeric | value | Udskrivningstime | 1994 to 2019 |

- **`c_udm`:** Starts in 1987, ten years after the register itself.
- **`c_bopamt`:** Ends with the counties themselves: the 2007 local government reform is already visible here in 2004/2005, where c_bopamt stops and c_amt starts. Neither covers the whole register, so a geographic analysis spanning that point needs both.
- **`v_sengdage`:** Starts in 1994. Before that, compute the stay from d_inddto and d_uddto instead.
- **`v_behdage`:** Ends in 2001.
- **`c_sex`:** The coding changes in 2005, from 1/2 to M/K. Prefer koen from BEF for a study variable.

</details>

*The Type column is read off the column name for 20 of these 52 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_DIAG** (one-to-many).

<details>
<summary>Value sets for the coded columns (4)</summary>

| Code system | Values |
| --- | --- |
| `pattype` | `0` Heldoegnspatient (to 2001), Indlagt patient (2002-), `1` Dagpatient (to 1986), Deldoegnspatient (1987-2001), `2` Natpatient (to 1986), Ambulant patient (1987-), `3` Skadestuepatient |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `indm` | `1` Akut, `2` Ikke akut, `9` Uoplyst |
| `sex_lpr` | `1` Mand (to 2004), `2` Kvinde (to 2004), `M` Mand (2005-), `K` Kvinde (2005-) |

- **`pattype`:** There are four codes, not six, and they changed meaning. Code `1` was Dagpatient until 1986 and Deldoegnspatient from 1987; code `2` was Natpatient until 1986 and Ambulant from 1987. The register only started using `1`, `2` and `3` in 1994, so before that essentially every contact is `0`. Code `3` was discontinued at the end of 2013, and from 2014 an emergency-room visit arrives as `2` with an acute admission mode in `c_indm`. Reading `2` as outpatient across the whole register therefore mislabels night patients before 1987 and emergency visits after 2013.
- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.
- **`indm`:** From 2014 this is what separates an emergency-room visit from an ordinary outpatient one, because `c_pattype` code `3` was discontinued and both arrive as `2`. Code `9` (Uoplyst) stops at the end of 2003, so a missing value after that is genuinely missing rather than coded as unknown.
- **`sex_lpr`:** The coding changed at the start of 2005: `1`/`2` until the end of 2004, `M`/`K` from 2005. A study spanning that year that filters on `c_sex == "2"` keeps only the women seen before 2005 and silently drops the rest, with no error and no empty result to warn you. Take sex from BEF instead, where it is `koen` coded `1`/`2` throughout, unless you specifically need what the hospital recorded.

Where these values come from:

- **`pattype`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`icd10`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`indm`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`sex_lpr`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).

</details>

**Worth knowing:**

- **`recnum`:** The key every other LPR2 dataset joins on. It identifies a contact, not a person.
- **`d_inddto`:** Use this as the contact date. It is the admission date, so for an outpatient course it is the date the course started, not the date of a particular visit.
- **`c_spec`:** DST publishes what each specialty code means in its department and specialty overview: https://www.dst.dk/da/Statistik/dokumentation/Times/moduldata-for-sociale-forhold--sundhedsvaesen--retsvaesen/spec (in Danish). The codes are not self-explanatory, so look them up rather than grouping on the digits.
- **`c_adiag`:** A copy of the contact's action diagnosis. Use lpr_diag instead: it holds every diagnosis on the contact, not only the action one.
- **`c_indm`:** Used together with c_pattype to separate emergency-room contacts from ordinary outpatient ones after about 2014, see the LPR extraction chapter. Available for the register's whole span, so a missing c_indm is an extract boundary rather than a coverage gap.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
