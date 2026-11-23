<!-- Generated from schema/registers/drg_sghforlob.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `adiag_drgsghf` | character | code | Action diagnosis of the hospital course |
| `aktivitetsaar` | integer | date | Activity year |
| `drg_drgsghf` | character | code | DRG group of the course after settlement rules |
| **`id`** | character | join key | Unique row identifier |
| `indtidspunkt_drgsghf` | datetime | date | Start of the hospital course |
| `liggedage_drgsghf` | integer | value | Bed days the hospital course spans |
| `pnr` | character | identifier | Personal identifier |
| `pris_drg_drgsghf` | numeric | value | DRG tariff of the hospital course's DRG group |
| `sygehus` | character | code | Hospital (SOR code) |
| `totalpris_drgsghf` | numeric | value | Total price (price plus long-stay price) |
| `udtidspunkt_drgsghf` | datetime | date | End of the hospital course |

<details>
<summary>All other columns (50)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `adiag_drgsgh_ind` | character | code | Action diagnosis on the first contact of the course |  |
| `adiag_drgsgh_ud` | character | code | Action diagnosis on the last contact of the course |  |
| `afslutningsmaade_drgsghf` | character | code | Mode of ending, from the last contact |  |
| `alder_aar_drgsghf` | integer | value | Age in years at start of the course |  |
| `alder_dage_drgsghf` | integer | value | Age in days at start of the course |  |
| `antal_i_forlob` | integer | value | Number of contacts in the hospital course |  |
| `betaler_drgsghf` | character | code | Payer (SKS code ALFB), from the last contact |  |
| `betaler_kom_drgsghf` | character | code | Payer municipality |  |
| `betaler_region_drgsghf` | character | code | Payer region |  |
| `betalingsaftale_drgsghf` | character | code | Payment agreement (SKS code ALFA), from the heaviest contact |  |
| `bo_kom_drgsghf` | character | code | Municipality of residence, as on the last contact |  |
| `bo_kom_source_drgsghf` | character | code | Source of the municipality of residence |  |
| `bo_region_drgsghf` | character | code | Region of residence, as on the last contact |  |
| `cprtjek` | character | code | CPR check |  |
| `cprtype` | character | code | CPR type |  |
| `d90ua04_drgsghf` | integer | code | Marker: responsible department belongs to other specialties | 2021 to 2023 |
| `d90ua05_drgsghf` | integer | code | Marker: all contacts fall under the research settlement rule (ALFA6) |  |
| `drgkontakttype_drgsghf` | integer | code | DRG contact type of the course |  |
| **`drgkontakt_id_ind`** | character | join key | Identifier of the first contact in the course |  |
| **`drgkontakt_id_ud`** | character | join key | Identifier of the last contact in the course |  |
| `drgsghforlob_type` | character | code | Hospital course type |  |
| `drg_grouper_drgsghf` | character | code | DRG group from the grouper, for the whole course |  |
| **`drg_kontakt_id_drgsghf`** | character | join key | Identifier of the contact that decides the course |  |
| `henvisendeinstans_drgsghf` | character | code | Referring institution (SOR code) |  |
| `henvisningsaarsag_drgsghf` | character | code | Referral reason |  |
| `henvisningsmaade_drgsghf` | character | code | Referral mode |  |
| `henvisningstidspunkt_drgsghf` | datetime | date | Referral received time |  |
| `koen` | character | code | Sex |  |
| `kontaktaarsag_drgsghf` | character | code | Contact reason, from the first contact |  |
| `kontaktdage_drgsghf` | integer | value | Contact days |  |
| `langliggerdage_drgsghf` | integer | value | Long-stay days (days beyond the trim point) |  |
| `langliggerpris_drgsghf` | numeric | value | Long-stay price (long-stay rate times long-stay days) |  |
| `lonsumafgift_langliggerpris` | numeric | value | Payroll tax on the long-stay price |  |
| `lonsumafgift_pris_drgsghf` | numeric | value | Payroll tax on the DRG tariff |  |
| `maaned_drgsghf` | integer | date | Activity month |  |
| `mdc_drgsghf` | character | code | Major Diagnostic Category of the course's action diagnosis |  |
| `mrk_kirurgi` | integer | code | Marker: surgical activity | 2022 to 2025 |
| `mrk_naerhed_1` | integer | code | Marker: proximity financing goal 1 |  |
| `mrk_naerhed_2` | integer | code | Marker: proximity financing goal 2 |  |
| `mrk_naerhed_4` | integer | code | Marker: proximity financing goal 4 |  |
| `prioritet_drgsghf` | character | code | Priority, from the first contact |  |
| `regel_drgsghf` | character | code | Grouping rule that produced the result |  |
| `rtc_drgsghf` | integer | code | Grouper return code |  |
| `specialiseringsniveau_drgsghf` | character | code | Specialisation level (SKS code ALFC), from the heaviest contact |  |
| `sygdomsforlob_id` | character | code | Disease course identifier |  |
| `sygehustype` | character | code | Hospital type |  |
| `sygehus_region` | character | code | Region of the hospital |  |
| `trimpunkt_drgsghf` | integer | value | Trim point of the course's DRG group |  |
| `varighed_time_drgsghf` | integer | value | Duration of the course in whole hours | 2022 to 2025 |
| `varighed_time_type_drgsghf` | character | code | Duration class of the course | 2022 to 2025 |

- **`d90ua04_drgsghf`:** Not defined in SDS's documentation for tariff system 2025. DST lists the column for 2021 to 2023 here and for 2021 to 2024 in DRG_KONTAKTER. See the note on `d90ua04` there.
- **`d90ua05_drgsghf`:** SDS: taken from the first contact if all contacts in the course fall under the settlement rule.
- **`drgkontakttype_drgsghf`:** SDS: the highest DRG contact type among the contacts in the course. Codes are listed under `drgkontakttype` in DRG_KONTAKTER.
- **`drgkontakt_id_ind`:** SDS: the ID of the first DRG contact in the course, found by the sorting of the contacts. It is the `id` of a row in DRG_KONTAKTER.
- **`drgkontakt_id_ud`:** SDS: the ID of the last DRG contact in the course. It is the `id` of a row in DRG_KONTAKTER.
- **`drgsghforlob_type`:** Same codes as `drgsghforlob_type` in DRG_KONTAKTER.
- **`drg_kontakt_id_drgsghf`:** SDS: the contact ID of the contact whose action diagnosis gives the course its DRG group.
- **`kontaktdage_drgsghf`:** SDS lists the number of contact days as an input to the grouper and does not define how it is counted in the documentation of tariff system 2025.
- **`langliggerdage_drgsghf`:** SDS: bed days beyond the DRG group's trim point, calculated as bed days minus trim point.
- **`lonsumafgift_langliggerpris`:** SDS: long-stay days times the payroll tax per long-stay day, if the priority is not ATA1 (acute). Only on the course.
- **`lonsumafgift_pris_drgsghf`:** SDS: zero unless the course's DRG tariff is not zero and the priority is not ATA1 (acute). Only on the course.
- **`maaned_drgsghf`:** SDS: the month of the end time of the last contact.
- **`mrk_kirurgi`:** SDS: a follow-up marker for the emergency plan. 1 if the course holds an operation procedure code (KA to KQ) and further payer, course type and hospital type conditions hold. DST lists the column from 2022.
- **`mrk_naerhed_1`:** SDS: marker for goal 1 of the proximity financing scheme (reduced number of hospital stays per citizen), set to 1 when a list of conditions on payer, course type, hospital, diagnosis and contact type holds. See SDS section 7.2 for the conditions.
- **`mrk_naerhed_2`:** SDS: marker for goal 2 of the proximity financing scheme (reduced hospital activity per citizen with chronic disease), set to 1 when a list of conditions on payer, course type, hospital, diagnosis and contact type holds. See SDS section 7.2 for the conditions.
- **`mrk_naerhed_4`:** SDS: marker for goal 4 of the proximity financing scheme (increased share of virtual hospital treatment), set to 1 when a list of conditions on payer, course type, hospital, diagnosis and contact type holds. See SDS section 7.2 for the conditions.
- **`rtc_drgsghf`:** Same codes as `rtc` in DRG_KONTAKTER.
- **`sygehustype`:** Same codes as `sygehustype` in DRG_KONTAKTER.
- **`varighed_time_drgsghf`:** Rounded down. DST lists the column from 2022.
- **`varighed_time_type_drgsghf`:** kort under 12 hours, lang 12 hours or more. DST lists the column from 2022.

</details>

*DST publishes no labels for 1 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*No published source gives a data type for 61 of these 61 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `id`, `pnr`.

**Joins to other registers:**

- `id` joins to **DRG_KONTAKTER** (one-to-many).
- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `icd10_sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `koen` | `1` Mand, `2` Kvinde, `9` Uoplyst |

- **`icd10_sks`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing. Do not carry the habit across to the cause-of-death registers: they hold the plain code, so stripping a D there removes the first real character instead.
- **`koen`:** DST's classification KOEN_V1_1980 also defines `9` for not stated, which a delivery may not contain but a value set should. Sex is taken from the tenth digit of the CPR number: even is female, odd is male.

Where these values come from:

- **`icd10_sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`koen`:** [DST's classification KOEN_V1_1980](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/koen) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e267e7c0-d998-4922-b2c4-6b44b15dd149csv_da)).

</details>

**Worth knowing:**

- **`adiag_drgsghf`:** SDS: the action diagnosis of the contact that decides the course, that is the one giving the DRG group with the highest tariff. Ties go to the highest contact ID.
- **`aktivitetsaar`:** This is the year of the activity, not the year in the file name. DST names each yearly file after the tariff year ("Takståret") and says the table holds hospital courses "for det pågældende og de to foregående aktivitetsår, jf. variablen AKTIVITETSAAR". DST's first release (register history, 14 May 2024) was calculated from tariff system 2021, which holds activity years 2019 to 2021, and tariff system 2022, which holds 2020 to 2022. The same activity therefore appears in up to three yearly files, priced with a different tariff each time. Stacking the yearly files repeats activity. Choose the tariff year you want and filter on `aktivitetsaar`, or take each activity year from one file only. SDS defines the activity year as the year of the end time of the course's last contact, and includes only hospital courses that ended in the activity year ("Kun DRG-sygehusforløb, der er afsluttet i aktivitetsåret"). SDS's text for tariff system 2025 says the courses are formed from activity in the activity year "og de 3 forrige" but gives 2023 to 2025 as its example for DRG2025. SDS also writes that tariffs hold for one calendar year, "men i uddata grupperes typisk flere aktivitetsår, så årene kan sammenlignes i samme takstsystem". DST's dataset list shows the 2021 file with 58 variables and the later files with 60 to 61. The 2021 file was re-run with the original variable names on 31 Oct 2025 and with a changed date format on 6 Feb 2026.
- **`drg_drgsghf`:** SDS: equals `drg_grouper_drgsghf` unless every contact in the course falls under the research settlement rule, in which case the first contact decides the group and the price is zero.
- **`id`:** SDS lists this as the unique ID of the hospital course table. It is the key that `drgsghforlob_id` in DRG_KONTAKTER points to.
- **`liggedage_drgsghf`:** SDS: end date minus start date, at least 1, in days.
- **`pnr`:** DST's name for the person key. SDS calls the same variable CPR and says it may be pseudonymised.
- **`pris_drg_drgsghf`:** The hospital course is grouped as a whole, so this is the tariff of the course's own DRG group and not the sum of the prices of its contacts, which are grouped one by one in DRG_KONTAKTER. Adding contact prices and course prices counts the same activity twice. Use one level. SDS gives no currency for the price columns, and tariffs hold for one calendar year, so prices from different tariff-year files are not comparable. The long-stay price and the payroll tax (`lonsumafgift_*`, which exist only on the course) are separate columns, and `totalpris_drgsghf` is price plus long-stay price (SDS: "Pris + Langliggerpris"), without the payroll tax.
- **`sygehus`:** SDS: the SOR code of the hospital (unit type hospital) above the responsible unit. It is used to form the hospital courses. DST changed `sygehus` to text for the 2021 file and dropped `sygehusnavn` (hospital name) on 11 Jun 2026. SDS's documentation says the DRG-grouped data hold only somatic activity ("Kun somatisk aktivitet", section 3.4.1.2), where psychiatric activity is defined by the SOR specialty of the responsible unit being 'psykiatri' or 'børne- og ungdomspsykiatri' (section 3.4.1.1). DST's register histories for the closed registers DRGPSYK_HEL and DRGPSYK_AMB give a different picture. The entries of 15 Jan 2024 say the registers were closed because tariffs for psychiatry are now included "sammen med takster for somatikken, i det nye DRG", and name DRG_KONTAKTER and DRG_SGHFORLOB as the new registers. The two statements are not reconciled here. Check the specialties in your own delivery before assuming that psychiatric contacts are present or absent.
- **`totalpris_drgsghf`:** The hospital course is grouped as a whole, so this is the tariff of the course's own DRG group and not the sum of the prices of its contacts, which are grouped one by one in DRG_KONTAKTER. Adding contact prices and course prices counts the same activity twice. Use one level. SDS gives no currency for the price columns, and tariffs hold for one calendar year, so prices from different tariff-year files are not comparable. The long-stay price and the payroll tax (`lonsumafgift_*`, which exist only on the course) are separate columns, and `totalpris_drgsghf` is price plus long-stay price (SDS: "Pris + Langliggerpris"), without the payroll tax.
