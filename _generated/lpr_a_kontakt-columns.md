<!-- Generated from schema/registers/lpr_a_kontakt.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`dw_ek_kontakt`** | character | join key | Contact identifier | 2025 to 1899 |
| `dw_ek_forloeb` | character | code | Course identifier | 2025 to 1899 |
| `pnr` | character | identifier | Personal identifier | 2025 to 1899 |
| `kont_starttidspunkt` | datetime | date | Contact start | 2025 to 1899 |
| `kont_sluttidspunkt` | datetime | date | Contact end | 2025 to 1899 |
| `kont_type` | character | code | Contact type | 2025 to 1899 |
| `lprindberetningssystem` | character | code | Reporting system | 2025 to 1899 |
| `adiag` | character | code | Primary diagnosis | 2025 to 1899 |
| `prioritet` | character | code | Priority | 2025 to 1899 |
| `kont_ans_hovedspec` | character | code | Responsible main specialty | 2025 to 1899 |
| `year` | integer | date | Register year |  |

<details>
<summary>All other columns (43)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `dw_sk_sygehusophold` | character | code | Hospital stay identifier | 2025 to 1899 |
| `dw_ek_helbredsforloeb` | character | code | Health course identifier | 2025 to 1899 |
| `dw_ek_borger` | character | code | Citizen identifier | 2025 to 1899 |
| `adiag_tekst` | character | value | Primary diagnosis, text | 2025 to 1899 |
| `kont_type_tekst` | character | value | Contact type, text | 2025 to 1899 |
| `kont_patient_type` | character | code | Patient type | 2025 to 1899 |
| `kont_patient_type_tekst` | character | value | Patient type, text | 2025 to 1899 |
| `prioritet_tekst` | character | value | Priority, text | 2025 to 1899 |
| `kont_aarsag` | character | code | Reason for the contact | 2025 to 1899 |
| `kont_aarsag_tekst` | character | value | Reason for the contact, text | 2025 to 1899 |
| `kont_henv_aarsag` | character | code | Referral reason | 2025 to 1899 |
| `kont_henv_aarsag_tekst` | character | value | Referral reason, text | 2025 to 1899 |
| `kont_henv_maade` | character | code | Referral mode | 2025 to 1899 |
| `kont_henv_maade_tekst` | character | value | Referral mode, text | 2025 to 1899 |
| `kont_henv_instans` | character | code | Referring body | 2025 to 1899 |
| `kont_henv_tidspunkt` | datetime | date | Referral time | 2025 to 1899 |
| `kont_indb_tidspunkt` | datetime | date | Reporting time | 2025 to 1899 |
| `beh_starttidspunkt` | datetime | date | Treatment start | 2025 to 1899 |
| `flag_kont_afsluttet` | numeric | code | Contact closed flag | 2025 to 1899 |
| `kont_ans` | character | code | Responsible unit | 2025 to 1899 |
| `kont_ans_inst` | character | code | Responsible institution | 2025 to 1899 |
| `kont_ans_hovedspec_shak` | character | code | Responsible main specialty, SHAK | 2025 to 1899 |
| `kont_ans_geo_reg` | character | code | Region of the treating unit, geographic | 2025 to 1899 |
| `kont_ans_geo_reg_tekst` | character | value | Region of the treating unit, text | 2025 to 1899 |
| `kont_ans_org_reg` | character | code | Region of the treating unit, organisational | 2025 to 1899 |
| `kont_ans_org_reg_tekst` | character | value | Organisational region, text | 2025 to 1899 |
| `kont_inst_ejertype` | character | code | Institution ownership type | 2025 to 1899 |
| `kont_fir_kode` | character | code | Company code | 2025 to 1899 |
| `kont_fir_tekst` | character | value | Company, text | 2025 to 1899 |
| `kont_fritvalg` | character | code | Free choice of hospital | 2025 to 1899 |
| `kont_fritvalg_tekst` | character | value | Free choice, text | 2025 to 1899 |
| `kont_lpr_entity_id` | character | code | LPR entity identifier | 2025 to 1899 |
| `borger_koen` | character | code | Sex | 2025 to 1899 |
| `borger_foedselsdato` | date | date | Date of birth | 2025 to 1899 |
| `borger_doedsdato` | date | date | Date of death | 2025 to 1899 |
| `borger_alder_aar_ind` | numeric | value | Age in years at contact start | 2025 to 1899 |
| `borger_alder_aar_ud` | numeric | value | Age in years at contact end | 2025 to 1899 |
| `borger_bo_kom` | character | code | Municipality of residence | 2025 to 1899 |
| `borger_bo_kom_tekst` | character | value | Municipality of residence, text | 2025 to 1899 |
| `borger_bo_reg` | character | code | Region of residence | 2025 to 1899 |
| `borger_bo_reg_tekst` | character | value | Region of residence, text | 2025 to 1899 |
| `cprtjek` | character | code | CPR check | 2025 to 1899 |
| `cprtype` | character | code | CPR type | 2025 to 1899 |

- **`dw_sk_sygehusophold`:** A stay can gather several contacts. Counting rows here is not the same as counting admissions.
- **`dw_ek_borger`:** An internal person key. Use pnr for joins to other registers; this one does not travel outside LPR3.
- **`kont_indb_tidspunkt`:** When the contact was reported, not when it happened. Recent months look incomplete because reporting lags.
- **`flag_kont_afsluttet`:** An open contact has no end time yet, so durations computed near the end of the data are wrong rather than missing.
- **`borger_koen`:** Sex as recorded on the contact, as text rather than a number. **The value set is unknown and this schema does not record one.** Sundhedsdatastyrelsen publishes no variable documentation for LPR3, and the neighbouring register is no guide: LPR2's c_sex switched from 1/2 to M/K in 2005, so both codings exist in the family. Do not assume either. If you need sex as a study variable, take koen from BEF, which is documented and stable; if you need what the hospital recorded, check what your own column contains before filtering on it.
- **`borger_foedselsdato`:** A copy from CPR carried on the contact, so it only exists for people who had a hospital contact. BEF is the source to use for a study variable.
- **`borger_doedsdato`:** A death date carried on the contact. It is not a death register: use DOD for mortality, or you only see people who had a hospital contact.

</details>

*DST publishes no labels for 53 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

**Join key:** `dw_ek_kontakt`.

**Joins to other registers:**

- `dw_ek_kontakt` joins to **LPR_A_DIAGNOSE** (one-to-many).

<details>
<summary>Value sets for the coded columns (4)</summary>

| Code system | Values |
| --- | --- |
| `kont_type` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `reg` | `0` Uoplyst, `81` Nordjylland, `82` Midtjylland, `83` Syddanmark, `84` Hovedstaden, `85` Sjælland |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts) |

- **`kont_type`:** `ALCA00` means physical attendance, which is the closest LPR3 gets to LPR2's inpatient flag. It marks attendance, not admission, so a study that treats it as "was admitted" will include outpatient visits.
- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.
- **`reg`:** Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.

Where these values come from:

- **`kont_type`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`icd10`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`reg`:** [DST's regional classification](https://www.dst.dk/extranet/ForskningVariabellister/BEF%20-%20Befolkningen.html).
- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts).

</details>

**Worth knowing:**

- **`dw_ek_kontakt`:** The key the diagnosis and procedure tables join on.
- **`dw_ek_forloeb`:** One level above the contact: a course of treatment can span several contacts, so joining on this is not the same as joining on the contact.
- **`kont_starttidspunkt`:** A datetime, not a date. as.Date() it before comparing with an index date.
- **`lprindberetningssystem`:** Filter to "LPR3". The table reaches back to 2017, and the outpatient contacts from before March 2019 are also in LPR2, so combining the two without this filter counts the same contact twice. The column also separates the two delivery formats, LPR_F and LPR_A.
- **`adiag`:** The contact's action diagnosis, repeated here so simple analyses need not join lpr_a_diagnose. Secondary diagnoses are only in the diagnosis table, so filtering on this column alone misses them.
- **`prioritet`:** The code ATA1 marks an acute contact. Together with the contact's duration this is how LPR3 substitutes for LPR2's c_pattype.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
