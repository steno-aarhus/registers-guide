<!-- Generated from schema/registers/drg_kontakter.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `aktivitetsaar` | integer | date | Activity year |
| `dia01` | character | code | Action diagnosis |
| `drg` | character | code | DRG group after settlement rules |
| **`drgsghforlob_id`** | character | join key | Hospital course identifier |
| `drg_grouper` | character | code | DRG group from the grouper, for the single contact |
| **`id`** | character | join key | Unique row identifier |
| `indtidspunkt_drgkontakt` | datetime | date | Contact start |
| `liggedage` | integer | value | Bed days the contact spans |
| `pnr` | character | identifier | Personal identifier |
| `pris_drg` | numeric | value | DRG tariff of the contact's DRG group |
| `speciale` | character | code | Specialty of the responsible unit (from SOR) |
| `sygehus` | character | code | Hospital (SOR code) |
| `totalpris_drg` | numeric | value | Total price (price plus long-stay price) |
| `udtidspunkt_drgkontakt` | datetime | date | Contact end |

<details>
<summary>All other columns (136)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `afslutningsmaade` | character | code | Mode of ending, from the course element |  |
| `alder_aar` | integer | value | Age in years at contact start |  |
| `alder_dage` | integer | value | Age in days at contact start |  |
| `betaler` | character | code | Payer (SKS code ALFB) at contact end |  |
| `betaler_kom` | character | code | Payer municipality |  |
| `betaler_region` | character | code | Payer region |  |
| `betalingsaftale` | character | code | Payment agreement (SKS code ALFA) at contact end |  |
| `bo_kom` | character | code | Municipality of residence at contact end |  |
| `bo_kom_source` | character | code | Source of the municipality of residence |  |
| `bo_region` | character | code | Region of residence |  |
| `cprtjek` | character | code | CPR check |  |
| `cprtype` | character | code | CPR type |  |
| `d90ua04` | integer | code | Marker: responsible department belongs to other specialties | 2021 to 2024 |
| `d90ua05` | integer | code | Marker: payment agreement is research (ALFA6) |  |
| `dia02` | character | code | Secondary diagnosis 1 |  |
| `dia03` | character | code | Secondary diagnosis 2 |  |
| `dia04` | character | code | Secondary diagnosis 3 |  |
| `dia05` | character | code | Secondary diagnosis 4 |  |
| `dia06` | character | code | Secondary diagnosis 5 |  |
| `dia07` | character | code | Secondary diagnosis 6 |  |
| `dia08` | character | code | Secondary diagnosis 7 |  |
| `dia09` | character | code | Secondary diagnosis 8 |  |
| `dia10` | character | code | Secondary diagnosis 9 | 2022 to 2025 |
| `dia11` | character | code | Secondary diagnosis 10 | 2022 to 2025 |
| `dia12` | character | code | Secondary diagnosis 11 | 2022 to 2025 |
| `dia13` | character | code | Secondary diagnosis 12 | 2022 to 2025 |
| `dia14` | character | code | Secondary diagnosis 13 | 2022 to 2025 |
| `dia15` | character | code | Secondary diagnosis 14 | 2022 to 2025 |
| `dia16` | character | code | Secondary diagnosis 15 | 2022 to 2025 |
| `dia17` | character | code | Secondary diagnosis 16 | 2022 to 2025 |
| `dia18` | character | code | Secondary diagnosis 17 | 2022 to 2025 |
| `dia19` | character | code | Secondary diagnosis 18 | 2022 to 2025 |
| `dia20` | character | code | Secondary diagnosis 19 | 2022 to 2025 |
| `drgkontakttype` | integer | code | DRG contact type |  |
| `drgsghforlob_nr` | integer | value | Position of the contact within the hospital course |  |
| `drgsghforlob_type` | character | code | Hospital course type |  |
| `drg_drgsghf` | character | code | DRG group of the hospital course the contact belongs to |  |
| `drg_forlobselement_enhed` | character | code | Responsible unit (SOR code) of the course element |  |
| `drg_kontakt_enhed` | character | code | Responsible unit (SOR code) of the contact |  |
| `forlob_vaerdi` | character | code | Reporting ID of the course in LPR3 source data |  |
| `forloebsprocedure` | integer | code | Marker: contact built from a procedure without a contact |  |
| `henvisendeinstans` | character | code | Referring institution (SOR code) |  |
| `henvisningsaarsag` | character | code | Referral reason |  |
| `henvisningsmaade` | character | code | Referral mode |  |
| `henvisningstidspunkt` | datetime | date | Referral received time |  |
| `ink1` | character | code | Internal code 1 |  |
| `ink2` | character | code | Internal code 2 |  |
| `ink3` | character | code | Internal code 3 | 2022 to 2025 |
| `ink4` | character | code | Internal code 4 | 2022 to 2025 |
| `ink5` | character | code | Internal code 5 | 2022 to 2025 |
| `ink6` | character | code | Internal code 6 | 2022 to 2025 |
| `koen` | character | code | Sex |  |
| `kontaktaarsag` | character | code | Contact reason |  |
| `kontaktdage` | integer | value | Contact days |  |
| `kontakttype` | character | code | Contact type |  |
| `kontakt_vaerdi` | character | code | Reporting ID of the LPR contact in LPR3 source data |  |
| `langliggerdage` | integer | value | Long-stay days (days beyond the trim point) |  |
| `langliggerpris` | numeric | value | Long-stay price (long-stay rate times long-stay days) |  |
| `mdc` | character | code | Major Diagnostic Category of the contact's action diagnosis |  |
| `prioritet` | character | code | Priority |  |
| `proc01` | character | code | Procedure 1 |  |
| `proc02` | character | code | Procedure 2 |  |
| `proc03` | character | code | Procedure 3 |  |
| `proc04` | character | code | Procedure 4 |  |
| `proc05` | character | code | Procedure 5 |  |
| `proc06` | character | code | Procedure 6 |  |
| `proc07` | character | code | Procedure 7 |  |
| `proc08` | character | code | Procedure 8 |  |
| `proc09` | character | code | Procedure 9 |  |
| `proc10` | character | code | Procedure 10 |  |
| `proc11` | character | code | Procedure 11 |  |
| `proc12` | character | code | Procedure 12 |  |
| `proc13` | character | code | Procedure 13 |  |
| `proc14` | character | code | Procedure 14 |  |
| `proc15` | character | code | Procedure 15 |  |
| `proc16` | character | code | Procedure 16 |  |
| `proc17` | character | code | Procedure 17 |  |
| `proc18` | character | code | Procedure 18 |  |
| `proc19` | character | code | Procedure 19 |  |
| `proc20` | character | code | Procedure 20 |  |
| `proc21` | character | code | Procedure 21 |  |
| `proc22` | character | code | Procedure 22 |  |
| `proc23` | character | code | Procedure 23 |  |
| `proc24` | character | code | Procedure 24 |  |
| `proc25` | character | code | Procedure 25 |  |
| `proc26` | character | code | Procedure 26 |  |
| `proc27` | character | code | Procedure 27 |  |
| `proc28` | character | code | Procedure 28 |  |
| `proc29` | character | code | Procedure 29 |  |
| `proc30` | character | code | Procedure 30 | 2022 to 2025 |
| `proc31` | character | code | Procedure 31 | 2022 to 2025 |
| `proc32` | character | code | Procedure 32 | 2022 to 2025 |
| `proc33` | character | code | Procedure 33 | 2022 to 2025 |
| `proc34` | character | code | Procedure 34 | 2022 to 2025 |
| `proc35` | character | code | Procedure 35 | 2022 to 2025 |
| `proc36` | character | code | Procedure 36 | 2022 to 2025 |
| `proc37` | character | code | Procedure 37 | 2022 to 2025 |
| `proc38` | character | code | Procedure 38 | 2022 to 2025 |
| `proc39` | character | code | Procedure 39 | 2022 to 2025 |
| `proc40` | character | code | Procedure 40 | 2022 to 2025 |
| `regel` | character | code | Grouping rule that produced the result |  |
| `rtc` | integer | code | Grouper return code |  |
| `specialiseringsniveau` | character | code | Specialisation level (SKS code ALFC) at contact end |  |
| `sygdomsforlob_id` | character | code | Disease course identifier |  |
| `sygehustype` | character | code | Hospital type |  |
| `sygehus_region` | character | code | Region of the hospital |  |
| `tdia01` | character | code | Additional code for the action diagnosis 1 |  |
| `tdia02` | character | code | Additional code for the action diagnosis 2 |  |
| `tdia03` | character | code | Additional code for the action diagnosis 3 |  |
| `tdia04` | character | code | Additional code for the action diagnosis 4 |  |
| `tdia05` | character | code | Additional code for the action diagnosis 5 |  |
| `tdia06` | character | code | Additional code for the action diagnosis 6 | 2022 to 2025 |
| `tdia07` | character | code | Additional code for the action diagnosis 7 | 2022 to 2025 |
| `tdia08` | character | code | Additional code for the action diagnosis 8 | 2022 to 2025 |
| `tdia09` | character | code | Additional code for the action diagnosis 9 | 2022 to 2025 |
| `tdia10` | character | code | Additional code for the action diagnosis 10 | 2022 to 2025 |
| `tdia11` | character | code | Additional code for the action diagnosis 11 | 2022 to 2025 |
| `tdia12` | character | code | Additional code for the action diagnosis 12 | 2022 to 2025 |
| `tdia13` | character | code | Additional code for the action diagnosis 13 | 2022 to 2025 |
| `tdia14` | character | code | Additional code for the action diagnosis 14 | 2022 to 2025 |
| `tproc01` | character | code | Additional code for procedures 1 |  |
| `tproc02` | character | code | Additional code for procedures 2 |  |
| `tproc03` | character | code | Additional code for procedures 3 |  |
| `tproc04` | character | code | Additional code for procedures 4 |  |
| `tproc05` | character | code | Additional code for procedures 5 |  |
| `tproc06` | character | code | Additional code for procedures 6 |  |
| `tproc07` | character | code | Additional code for procedures 7 |  |
| `tproc08` | character | code | Additional code for procedures 8 |  |
| `tproc09` | character | code | Additional code for procedures 9 |  |
| `tproc10` | character | code | Additional code for procedures 10 |  |
| `trimpunkt` | integer | value | Trim point of the contact's DRG group |  |
| `tungeste_drgkontakt` | integer | code | Marker: heaviest contact in the hospital course |  |
| `udfaldsgivende_kontakt` | integer | code | Marker: contact whose action diagnosis decides the course |  |
| `udtidspunkt_drgsghf` | datetime | date | End of the hospital course |  |
| `varighed_time` | integer | value | Duration of the contact in whole hours | 2022 to 2025 |
| `varighed_time_type` | character | code | Duration class of the contact | 2022 to 2025 |

- **`betaler`:** SDS: LPR3 holds the payer as a text field, but an SKS classification exists for it. The payment information in force when the contact ended is used.
- **`bo_kom`:** SDS: taken from the CPR register at contact end. If CPR is blank the municipality from LPR is used, then the country code from LPR, and otherwise `999` for unknown.
- **`bo_region`:** Region codes 1081 to 1085. Where the municipality cannot be linked to a region, a country code is used: 90 Greenland, 97 the Faroe Islands, 98 abroad, 99 residence unknown.
- **`d90ua04`:** DST's label: the marker is 1 if the home department belongs to other specialties than clinical or cross-cutting ones, otherwise 0. SDS's documentation for tariff system 2025 describes D90UA05 but not this marker. DST lists it for 2021 to 2024 in this file and for 2021 to 2023 in DRG_SGHFORLOB.
- **`d90ua05`:** SDS: set to 1 if the contact's payment agreement is ALFA6 ('forskning'), otherwise 0. DST lists the column for 2021 to 2023 and 2025 in this file, not for 2024.
- **`dia02`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia03`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia04`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia05`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia06`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia07`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia08`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia09`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia10`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia11`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia12`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia13`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia14`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia15`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia16`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia17`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia18`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia19`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`dia20`:** SDS: secondary diagnoses (type ALGA02) in the contact's diagnosis table. SDS notes that duplicates of SKS codes are not repeated in the contact table, so use the separate diagnosis tables to see exactly what went into the grouping.
- **`drgkontakttype`:** SDS: built from the LPR contact type and specialty. 1 diagnosis report, 2 procedure without contact, 3 virtual contact, 4 other specialties, 6 own courses, 7 death, 8 outreach contact, 9 other.
- **`drgsghforlob_nr`:** SDS: the order of the contacts in the course, sorted by start time, then contact type (descending), end time and `kontakt_vaerdi`. The first contact is number 1.
- **`drgsghforlob_type`:** SDS: HJERNE (brain death), PRAEHOSP (prehospital), HJERTE (cardiac death), BAF (paid by research funds) or DRG. If a contact fits several, the order of that list decides. Contacts only form a course with others of the same type.
- **`drg_drgsghf`:** By the name and DST's label: the course's final DRG group, repeated on each contact row. Do not add it to the contact's own price.
- **`drg_forlobselement_enhed`:** DST delivers the SOR codes in this column non-pseudonymised since 22 Jun 2025, so the format differs from files delivered before that date. SDS: the responsible unit (AnsvarligEnhed) from LPR, or the producer of the procedure if the contact is constructed.
- **`drg_kontakt_enhed`:** DST delivers the SOR codes in this column non-pseudonymised since 22 Jun 2025, so the format differs from files delivered before that date. SDS: the responsible unit (AnsvarligEnhed) from LPR, or the producer of the procedure if the contact is constructed.
- **`forloebsprocedure`:** SDS: 1 for DRG contacts made from procedures that belong to a course element but to no LPR contact. These are registered as no-show contacts, and a missing end time is set to start time plus one second.
- **`ink1`:** SDS: internal codes are made by Sundhedsdatastyrelsen for the grouping logic and are not part of the SKS classification. All types are included in the contact table.
- **`kontaktdage`:** SDS lists the number of contact days as an input to the grouper and does not define how it is counted in the documentation of tariff system 2025.
- **`kontakttype`:** SDS: ALCA00 physical attendance, ALCA01 outreach contact, ALCA03 virtual contact, ALCA10 death, ALCA20 diagnosis report. Blank for contacts built from procedures without a contact.
- **`langliggerdage`:** SDS: bed days beyond the DRG group's trim point, calculated as bed days minus trim point.
- **`proc01`:** SDS: procedure codes from the procedure table, up to 40 per contact, without duplicates of SKS codes. The separate procedure table shows exactly what went into the grouping.
- **`rtc`:** SDS: 0 grouping done, 1 action diagnosis missing, 2 sex missing, 3 sex does not fit the diagnosis, 4 too young for the diagnosis, 5 too old for the diagnosis, 7 rare or wrong combination of diagnosis and procedure, 9 other error.
- **`sygdomsforlob_id`:** SDS: a disease course is one or more course elements linked by references in LPR3. Hospital courses are not formed across disease courses.
- **`sygehustype`:** SDS: hos hospice, øvr other, prv private, off public.
- **`sygehus_region`:** SDS: region number from SOR for public hospitals and hospices, 1081 to 1085, and 9999 for others.
- **`tdia01`:** SDS: additional codes (tillægskoder) are included only for the action diagnosis (`dia01`).
- **`tproc01`:** SDS: additional codes for procedures, only those that matter in the grouping logic. Nothing shows which procedure a code belongs to.
- **`tungeste_drgkontakt`:** SDS: 1 for the contact that, grouped on its own, gives the highest DRG tariff in its course. Ties go to the highest `kontakt_vaerdi`.
- **`varighed_time`:** SDS: end time minus start time in whole hours, rounded down, 0 if under one hour. DST lists the column from 2022.
- **`varighed_time_type`:** SDS: kort if under 12 hours, lang if 12 hours or more. DST lists the column from 2022.

</details>

*No published source gives a data type for 150 of these 150 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `id`, `drgsghforlob_id`, `pnr`.

**Joins to other registers:**

- `drgsghforlob_id` joins to **DRG_SGHFORLOB** (many-to-one).
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

- **`aktivitetsaar`:** This is the year of the activity, not the year in the file name. DST names each yearly file after the tariff year ("Takståret") and says the table holds contacts "for det pågældende og de to foregående aktivitetsår, jf. variablen AKTIVITETSAAR". DST's first release (register history, 14 May 2024) was calculated from tariff system 2021, which holds activity years 2019 to 2021, and tariff system 2022, which holds 2020 to 2022. The same activity therefore appears in up to three yearly files, priced with a different tariff each time. Stacking the yearly files repeats activity. Choose the tariff year you want and filter on `aktivitetsaar`, or take each activity year from one file only. SDS defines the activity year as the year of the end time of the course's last contact, and includes only hospital courses that ended in the activity year ("Kun DRG-sygehusforløb, der er afsluttet i aktivitetsåret"). SDS's text for tariff system 2025 says the courses are formed from activity in the activity year "og de 3 forrige" but gives 2023 to 2025 as its example for DRG2025. SDS also writes that tariffs hold for one calendar year, "men i uddata grupperes typisk flere aktivitetsår, så årene kan sammenlignes i samme takstsystem". DST's dataset list shows the 2021 file with 113 variables and the later files with 149 to 150. The extra columns, for example `dia10` to `dia18`, `proc30` to `proc40`, `tdia06` to `tdia14` and `varighed_time`, are listed by DST from 2022 only. The 2021 file was re-run with the original variable names on 31 Oct 2025 and with a changed date format on 6 Feb 2026.
- **`dia01`:** SDS: the action diagnosis of the contact, from the diagnosis table where the type is ALGA01. Blank if the contact has no action diagnosis.
- **`drg`:** SDS: equals the grouper's DRG (`drg_grouper`) unless the research marker `d90ua05` is 1, in which case the settlement rule replaces the group and the price is set to zero.
- **`drgsghforlob_id`:** Points to `id` in DRG_SGHFORLOB: one hospital course holds one or more contacts, and a contact belongs to exactly one course (SDS section 6.1.1).
- **`id`:** SDS lists this as the unique ID of the contact table. DRG_SGHFORLOB has its own `id` for the course, so a join between the two tables goes through `drgsghforlob_id`, not through `id` on both sides.
- **`liggedage`:** SDS: end date minus start date, at least 1, in days.
- **`pnr`:** DST's name for the person key. SDS calls the same variable CPR and says it may be pseudonymised.
- **`pris_drg`:** A contact is grouped and priced on its own, so this is the tariff of the contact's own DRG group. The hospital course the contact belongs to is grouped again as a whole and carries its own price in DRG_SGHFORLOB. SDS's documentation does not describe the course price as the sum of its contacts' prices, so adding contact prices and course prices counts the same activity twice. Use one level. SDS gives no currency for the price columns, and tariffs hold for one calendar year, so prices from different tariff-year files are not comparable. The long-stay price is a separate column, and `totalpris_drg` is the sum of the two (SDS: "Pris + Langliggerpris").
- **`speciale`:** SDS's documentation says the DRG-grouped data hold only somatic activity ("Kun somatisk aktivitet", section 3.4.1.2), where psychiatric activity is defined by the SOR specialty of the responsible unit being 'psykiatri' or 'børne- og ungdomspsykiatri' (section 3.4.1.1). DST's register histories for the closed registers DRGPSYK_HEL and DRGPSYK_AMB give a different picture. The entries of 15 Jan 2024 say the registers were closed because tariffs for psychiatry are now included "sammen med takster for somatikken, i det nye DRG", and name DRG_KONTAKTER and DRG_SGHFORLOB as the new registers. The two statements are not reconciled here. Check the specialties in your own delivery before assuming that psychiatric contacts are present or absent.
- **`sygehus`:** SDS: the SOR code of the hospital (unit type hospital) above the responsible unit. It is used to form the hospital courses.
- **`totalpris_drg`:** A contact is grouped and priced on its own, so this is the tariff of the contact's own DRG group. The hospital course the contact belongs to is grouped again as a whole and carries its own price in DRG_SGHFORLOB. SDS's documentation does not describe the course price as the sum of its contacts' prices, so adding contact prices and course prices counts the same activity twice. Use one level. SDS gives no currency for the price columns, and tariffs hold for one calendar year, so prices from different tariff-year files are not comparable. The long-stay price is a separate column, and `totalpris_drg` is the sum of the two (SDS: "Pris + Langliggerpris").
