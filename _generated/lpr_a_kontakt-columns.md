<!-- Generated from schema/registers/lpr_a_kontakt.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`dw_ek_kontakt`** | character | join key | Contact identifier |
| `dw_ek_forloeb` | character | code | Course identifier |
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
<summary>All other columns (43)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
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
| `flag_kont_afsluttet` | numeric | code | Contact closed flag |
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
| `borger_koen` | character | code | Sex |
| `borger_foedselsdato` | date | date | Date of birth |
| `borger_doedsdato` | date | date | Date of death |
| `borger_alder_aar_ind` | numeric | value | Age in years at contact start |
| `borger_alder_aar_ud` | numeric | value | Age in years at contact end |
| `borger_bo_kom` | character | code | Municipality of residence |
| `borger_bo_kom_tekst` | character | value | Municipality of residence, text |
| `borger_bo_reg` | character | code | Region of residence |
| `borger_bo_reg_tekst` | character | value | Region of residence, text |
| `cprtjek` | character | code | CPR check |
| `cprtype` | character | code | CPR type |

- **`dw_sk_sygehusophold`:** A stay can gather several contacts. Counting rows here is not the same as counting admissions.
- **`dw_ek_borger`:** An internal person key. Use pnr for joins to other registers; this one does not travel outside LPR3.
- **`kont_indb_tidspunkt`:** When the contact was reported, not when it happened. Recent months look incomplete because reporting lags.
- **`flag_kont_afsluttet`:** An open contact has no end time yet, so durations computed near the end of the data are wrong rather than missing.
- **`borger_koen`:** Sex as recorded on the contact, as text rather than a number. **No published source gives its value set, so this schema records none.** Checked without success: Sundhedsdatastyrelsen's Vejledning til LPR3_F, which documents these very research tables; the LPR3 reporting guidance; esundhed's LPR documentation, which covers LPR2 only; and DST's variable list, which names the column but gives neither label nor values. Treat this as settled rather than as something still to look up. The neighbouring register is no guide either: LPR2's c_sex switched from 1/2 to M/K in 2005, so both codings exist in the family and neither can be assumed here. If you need sex as a study variable, take koen from BEF, which is documented and stable; if you need what the hospital recorded, check what your own column contains before filtering on it.
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
| `kont_type` | Not listed here - see [DST's classification](https://cdn1.gopublic.dk/sundhedsdatastyrelsen/media/15700/LPR_indberetningsvejledning_v.1.2.pdf) |
| `icd10_sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `reg` | `0` Uoplyst, `81` Nordjylland, `82` Midtjylland, `83` Syddanmark, `84` Hovedstaden, `85` Sjælland |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |

- **`kont_type`:** `ALCA00` means physical attendance, which is the closest LPR3 gets to LPR2's inpatient flag. It marks attendance, not admission, so a study that treats it as "was admitted" will include outpatient visits. Check what your own delivery holds before filtering: single digits and SKS codes have been seen side by side in the same year, so `kont_type == "ALCA00"` can silently drop rows that are the same kind of contact recorded in the other form. Cross-tabulate it against `lprindberetningssystem` first. MiniPAS was the route private providers reported through, so the two forms are not only two notations, they are also two different parts of the health service.
- **`icd10_sks`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing. Do not carry the habit across to the cause-of-death registers: they hold the plain code, so stripping a D there removes the first real character instead.
- **`reg`:** Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality - confirmed for two reused codes against a current-only DST source: 707 is Norddjurs today, not its pre-2007 meaning, and likewise 849 is Jammerbugt. `lookup:` below covers only this post-2007 set (99 entries), not the full 278-code `values_from` file. Christiansø (411) is included in `lookup:` even though it is not a municipality (see description above): it is a real value a `kom` column can hold, and DST's own current-only classification lists it as its own area code alongside the 98 municipalities. Excluding it would just move the "unhandled code" problem this fix is meant to solve onto that one value.

Where these values come from:

- **`kont_type`:** [Vejledning til indberetning til LPR3](https://cdn1.gopublic.dk/sundhedsdatastyrelsen/media/15700/LPR_indberetningsvejledning_v.1.2.pdf), published on [medinfo.dk](https://medinfo.dk/sks/brows.php).
- **`icd10_sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`reg`:** [DST's regional classification](https://www.dst.dk/extranet/ForskningVariabellister/BEF%20-%20Befolkningen.html).
- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).

</details>

**Worth knowing:**

- **`dw_ek_kontakt`:** The key the diagnosis and procedure tables join on.
- **`dw_ek_forloeb`:** One level above the contact: a course of treatment can span several contacts, so joining on this is not the same as joining on the contact.
- **`kont_starttidspunkt`:** A datetime, not a date. as.Date() it before comparing with an index date.
- **`lprindberetningssystem`:** Filter to "LPR3". The table reaches back to 2017, and the outpatient contacts from before March 2019 are also in LPR2, so combining the two without this filter counts the same contact twice. The column also separates the two delivery formats, LPR_F and LPR_A.
- **`adiag`:** The contact's action diagnosis, repeated here so simple analyses need not join lpr_a_diagnose. Secondary diagnoses are only in the diagnosis table, so filtering on this column alone misses them.
- **`prioritet`:** The code ATA1 marks an acute contact. Together with the contact's duration this is how LPR3 substitutes for LPR2's c_pattype.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
