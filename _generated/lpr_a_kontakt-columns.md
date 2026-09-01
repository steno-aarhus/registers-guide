<!-- Generated from schema/registers/lpr_a_kontakt.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`dw_ek_kontakt`** | character | join key | Contact identifier |
| `pnr` | character | identifier | Personal identifier |
| `kont_starttidspunkt` | datetime | date | Contact start |
| `kont_sluttidspunkt` | datetime | date | Contact end |
| `kont_type` | character | code | Contact type |
| `lprindberetningssystem` | character | code | Reporting system |
| `adiag` | character | code | Primary diagnosis |
| `prioritet` | character | code | Priority |
| `kont_ans_hovedspec` | character | code | Responsible main specialty |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (44)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `dw_ek_forloeb` | character | code | Course identifier |
| `dw_sk_sygehusophold` | character | code | Hospital stay identifier |
| `dw_ek_helbredsforloeb` | character | code | Health course identifier |
| `dw_ek_borger` | character | code | Citizen identifier |
| `adiag_tekst` | character | value | Primary diagnosis, text |
| `kont_type_tekst` | character | value | Contact type, text |
| `kont_patient_type` | character | code | Patient type |
| `kont_patient_type_tekst` | character | value | Patient type, text |
| `prioritet_tekst` | character | value | Priority, text |
| `kont_aarsag` | character | code | Reason for the contact |
| `kont_aarsag_tekst` | character | value | Reason for the contact, text |
| `kont_henv_aarsag` | character | code | Referral reason |
| `kont_henv_aarsag_tekst` | character | value | Referral reason, text |
| `kont_henv_maade` | character | code | Referral mode |
| `kont_henv_maade_tekst` | character | value | Referral mode, text |
| `kont_henv_instans` | character | code | Referring body |
| `kont_henv_tidspunkt` | datetime | date | Referral time |
| `kont_indb_tidspunkt` | datetime | date | Reporting time |
| `beh_starttidspunkt` | datetime | date | Treatment start |
| `flag_kont_afsluttet` | character | code | Contact closed flag |
| `kont_ans` | character | code | Responsible unit |
| `kont_ans_inst` | character | code | Responsible institution |
| `kont_ans_hovedspec_shak` | character | code | Responsible main specialty, SHAK |
| `kont_ans_geo_reg` | character | code | Region of the treating unit, geographic |
| `kont_ans_geo_reg_tekst` | character | value | Region of the treating unit, text |
| `kont_ans_org_reg` | character | code | Region of the treating unit, organisational |
| `kont_ans_org_reg_tekst` | character | value | Organisational region, text |
| `kont_inst_ejertype` | character | code | Institution ownership type |
| `kont_fir_kode` | character | code | Company code |
| `kont_fir_tekst` | character | value | Company, text |
| `kont_fritvalg` | character | code | Free choice of hospital |
| `kont_fritvalg_tekst` | character | value | Free choice, text |
| `kont_lpr_entity_id` | character | code | LPR entity identifier |
| `borger_koen` | integer | code | Sex |
| `borger_foedselsdato` | date | date | Date of birth |
| `borger_doedsdato` | date | date | Date of death |
| `borger_alder_aar_ind` | integer | value | Age in years at contact start |
| `borger_alder_aar_ud` | integer | value | Age in years at contact end |
| `borger_bo_kom` | character | code | Municipality of residence |
| `borger_bo_kom_tekst` | character | value | Municipality of residence, text |
| `borger_bo_reg` | character | code | Region of residence |
| `borger_bo_reg_tekst` | character | value | Region of residence, text |
| `cprtjek` | character | code | CPR check |
| `cprtype` | character | code | CPR type |

- **`dw_ek_forloeb`:** One level above the contact: a course of treatment can span several contacts, so joining on this is not the same as joining on the contact.
- **`dw_sk_sygehusophold`:** A stay can gather several contacts. Counting rows here is not the same as counting admissions.
- **`dw_ek_borger`:** An internal person key. Use pnr for joins to other registers; this one does not travel outside LPR3.
- **`kont_indb_tidspunkt`:** When the contact was reported, not when it happened. Recent months look incomplete because reporting lags.
- **`flag_kont_afsluttet`:** An open contact has no end time yet, so durations computed near the end of the data are wrong rather than missing.
- **`borger_koen`:** Sex as recorded on the contact. BEF is the source to prefer for a study variable; this one is here for convenience.
- **`borger_foedselsdato`:** A copy from CPR carried on the contact, so it only exists for people who had a hospital contact. BEF is the source to use for a study variable.
- **`borger_doedsdato`:** A death date carried on the contact. It is not a death register: use DOD for mortality, or you only see people who had a hospital contact.

</details>

**Join key:** `dw_ek_kontakt`.

**Joins to other registers:**

- `dw_ek_kontakt` joins to **LPR_A_DIAGNOSE** (one-to-many).

<details>
<summary>Value sets for the coded columns (5)</summary>

| Code system | Values |
| --- | --- |
| `kont_type` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `reg` | `0` Uoplyst, `81` Nordjylland, `82` Midtjylland, `83` Syddanmark, `84` Hovedstaden, `85` Sjælland |
| `koen` | `1` Mand, `2` Kvinde |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts) |

- **`kont_type`:** `ALCA00` means physical attendance, which is the closest LPR3 gets to LPR2's inpatient flag. It marks attendance, not admission, so a study that treats it as "was admitted" will include outpatient visits.
- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.
- **`reg`:** Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.

</details>

**Worth knowing:**

- **`dw_ek_kontakt`:** The key the diagnosis and procedure tables join on.
- **`kont_starttidspunkt`:** A datetime, not a date. as.Date() it before comparing with an index date.
- **`lprindberetningssystem`:** Filter to "LPR3". The table reaches back to 2017, and the outpatient contacts from before March 2019 are also in LPR2, so combining the two without this filter counts the same contact twice. The column also separates the two delivery formats, LPR_F and LPR_A.
- **`adiag`:** The contact's action diagnosis, repeated here so simple analyses need not join lpr_a_diagnose. Secondary diagnoses are only in the diagnosis table, so filtering on this column alone misses them.
- **`prioritet`:** The code ATA1 marks an acute contact. Together with the contact's duration this is how LPR3 substitutes for LPR2's c_pattype.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
