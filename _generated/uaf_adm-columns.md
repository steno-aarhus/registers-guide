<!-- Generated from schema/registers/uaf_adm.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `pnr` | character | identifier | Personal identifier |
| `d_inddto` | date | date | Date of admission |
| `d_uddto` | date | date | Date of discharge |
| `c_pattype` | character | code | Patient type |
| `c_sgh` | character | code | Hospital |
| `c_afd` | character | code | Department |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (38)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `v_indtime` | numeric | date | Hour the contact started |  |
| `v_indminut` | numeric | value | Minute the contact started |  |
| `c_spec` | character | code | Specialty |  |
| `c_adiag` | character | code | Action diagnosis |  |
| `c_indm` | character | code | Admission mode |  |
| `c_udm` | character | code | Discharge mode |  |
| `c_amt` | character | code | County | 2005 to 2019 |
| `c_blok` | character | code | Specialty block |  |
| `c_bopamt` | character | code | County of residence | 1996 to 2004 |
| `c_eakt` | character | code | Activity at the time of the accident | 1996 to 2003 |
| `c_emek` | character | code | Accident mechanism | 1996 to 2003 |
| `c_emodpart` | character | code | Mode of transport of the counterpart in a traffic accident | 1996 to 2003 |
| `c_epart` | character | code | Injured person's mode of transport in a traffic accident | 1996 to 2003 |
| `c_ested` | character | code | Place of accident | 1996 to 2003 |
| `c_etraf` | character | code | Traffic accident or not | 1996 to 2003 |
| `c_hafd` | character | code | Referring department | 2004 to 2019 |
| `c_henm` | character | code | Referral mode |  |
| `c_hsgh` | character | code | Referring hospital | 2004 to 2019 |
| `c_kom` | character | code | Patient's municipality of residence |  |
| `c_kontaars` | character | code | Reason for the contact |  |
| `c_nyafd` | character | code |  | 2005 to 2019 |
| `c_sex` | character | code | Sex |  |
| `c_sghamt` | character | code | Hospital county |  |
| `cprtjek` | character | code | CPR check |  |
| `cprtype` | character | code | CPR type |  |
| `d_ebhdto` | date | date | Date of final treatment | 1998 to 2019 |
| `d_fusdto` | date | date | Date of preliminary examination | 1998 to 2019 |
| `d_hendto` | date | date | Referral date |  |
| `d_opdatdto` | date | date | Internal date the contact was last updated | 2005 to 2019 |
| `k_afd` | character | code | Department code | 2005 to 2019 |
| `leverancedato` | date | date |  |  |
| `v_alddg` | numeric | value | Age in days at the start of the contact |  |
| `v_alder` | numeric | value | Age at the start of the contact |  |
| `v_aldmdr` | numeric | value | Age in months at the start of the contact |  |
| `v_behdage` | numeric | value | Treatment days |  |
| `v_sengdage` | numeric | value | Bed days |  |
| `v_udtime` | numeric | value | Hour the contact ended | 2005 to 2019 |
| `version` | character | code | Version |  |

- **`c_spec`:** DST publishes what each specialty code means in its department and specialty overview: https://www.dst.dk/da/Statistik/dokumentation/Times/moduldata-for-sociale-forhold--sundhedsvaesen--retsvaesen/spec (in Danish). The codes are not self-explanatory, so look them up rather than grouping on the digits.
- **`c_adiag`:** A copy of the contact's action diagnosis. Use uaf_diag instead: it holds every diagnosis on the contact, not only the action one.
- **`c_sex`:** The coding changes in 2005, from 1/2 to M/K. Prefer koen from BEF for a study variable.

</details>

*No published source gives a data type for 14 of these 46 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **UAF_DIAG** (one-to-many).

<details>
<summary>Value sets for the coded columns (14)</summary>

| Code system | Values |
| --- | --- |
| `pattype` | `0` Heldoegnspatient (to 2001), Indlagt patient (2002-), `1` Dagpatient (to 1986), Deldoegnspatient (1987-2001), `2` Natpatient (to 1986), Ambulant patient (1987-), `3` Skadestuepatient |
| `icd10_sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `indm` | `1` Akut, `2` Ikke akut, `9` Uoplyst |
| `c_udm` | `1` Udskrevet/afsluttet til alment praktiserende læge, `2` Udskrevet/afsluttet til praktiserende speciallæge, `3` Udskrevet/afsluttet til eget heldøgnsafsnit eller eget deldøgnsafsnit, `4` Ingen lægelig opfølgning (må kun anvendes for psykiatriske afdelinger), `5` Udskrevet/afsluttet til andet heldøgnsafsnit eller andet deldøgnsafsnit, `6` Udskrevet/afsluttet til ambulatorium, `7` Udeblevet (kun ambulante patienter), `8` Død, `9` Uoplyst, `A` Andet, `B` Udskrevet/afsluttet til eget ambulatorium, `C` Udskrevet/afsluttet til andet ambulatorium, `E` Behandling i udlandet (hvor sygehus beslutter behandling i udlandet), `F` Afsluttet til sygehusafsnit, `G` Afsluttet til sygehusafsnit, venteforløb, `K` Afsluttet til sygehusafsnit (hjemmet), `L` Afsluttet til sygehusafsnit, venteforløb (hjemmet) |
| `c_blok` | `1` Medicinsk blok, `2` Kirurgisk blok, `5` Psykiatrisk blok, `6` Laboratorie blok, `8` Øvrige specialer, `9` Andre specialer, `99` Uden for specialer |
| `c_eakt` | `1` Idræt, sport og motion, `2` Leg, hobby og and fritidsvirksomhed, `3` Erhvervsarbejde, `4` Vitalaktivitet, `5` Ulønnet arbejde, `8` Anden aktivitet, `9` Ikke specificeret aktivitet |
| `c_emek` | `0` Slag, stød grundet fald på samme niveau, `1` Slag, stød grundet fald på trappe eller til lavere niveau, `2` Slag, stød grundet kontakt med anden genstand, person eller dyr, `3` Klemning, snit eller stik, `4` Fremmedlegeme, `5` Kvælning, `6` Kemisk påvirkning, `7` Termisk, elektrisk eller strålingspåvirkning, `8` Akut overbelastning af legeme eler legemesdel, `9` Anden og ukendt skadesmekanisme |
| `c_emodpart` | `0` Ingen modpart, `1` Til fods, `2` Cykel, `3` Knallert, `4` Motorcykel eller scooter, `5` Personbil, `6` Varevogn, `7` Lastbil, bus, m.m., `8` Anden transportform, modpart, `9` Ikke specificeret transportform, modpart |
| `c_epart` | `1` Til fods, `2` Cykel, `3` Knallert, `4` Motorcykel eller scooter, `5` Personbil, `6` Varevogn, `7` Lastbil, bus, m.m., `8` Anden transportform, tilskadekomne, `9` Ikke specificeret transportform, tilskadekomne |
| `c_ested` | `0` Trafikområde, `1` Boligområde, `2` Produktions- og værkstedsområde, `3` Butiks- handels- og serviceområde, `4` Skole, offentlig administrations- og institutionsområde, `5` Idræts- og sportsområdet, `6` Forlystelses- og parkområdet, `7` Fri natur, `8` Hav, sø og vådområder, `9` Uoplyst |
| `c_etraf` | `1` Færdselsuheld, `2` Ikke færdselsuheld |
| `c_henm` | `0` Ingen henvisning, `1` Henvist fra alment praktiserende læge, `2` Henvist fra praktiserende speciallæge, `3` Henvist fra eget heldøgnsafsnit eller eget deldøgnsafsnit, `5` Henvist fra andet heldøgnsafsnit eller andet deldøgnsafsnit, `6` Henvist fra skadestue eller ambulatorium, `8` Herfødt, `9` Uoplyst, `A` Andet, `B` Eget ambulatorium, `C` Andet ambulatorium, `D` Skadestue, `E` Udlandet (kun direkte henvisninger), `F` Henvist fra sygehusafsnit, `G` Henvist fra sygehusafsnit, venteforløb |
| `c_kontaars` | `1` Sygdom og tilstand uden direkte sammenhæng med udefra påført læsion, `2` Ulykke, `3` Voldshandling, `4` Selvmord/selvmordsforsøg, `5` Senfølge, `6` Komplet skaderegistrering foretages på efterfølgende kontakt, `7` Komplet skaderegistrering foretaget på tidligere kontakt, `8` Andet, `9` Uoplyst |
| `sex_lpr` | `1` Mand (to 2004), `2` Kvinde (to 2004), `M` Mand (2005-), `K` Kvinde (2005-) |

- **`pattype`:** There are four codes, not six, and three of them changed meaning. Code `1` was Dagpatient until 1986 and Deldoegnspatient from 1987, and then stops entirely at the end of 2001. Code `2` was Natpatient until 1986 and Ambulant from 1987. Code `0` was Heldoegnspatient until 2001 and Indlagt patient from 2002. The register only started using `1`, `2` and `3` in 1994, so before that essentially every contact is `0`. Code `3` was discontinued at the end of 2013, and from 2014 an emergency-room visit arrives as `2` with an acute admission mode in `c_indm`. Reading `2` as outpatient across the whole register therefore mislabels night patients before 1987 and emergency visits after 2013.
- **`icd10_sks`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing. Do not carry the habit across to the cause-of-death registers: they hold the plain code, so stripping a D there removes the first real character instead.
- **`indm`:** From 2014 this is what separates an emergency-room visit from an ordinary outpatient one, because `c_pattype` code `3` was discontinued and both arrive as `2`. Code `9` (Uoplyst) stops at the end of 2003, so a missing value after that is genuinely missing rather than coded as unknown.
- **`c_udm`:** Only codes 1, 8 and 9 reach back to 1987, and 9 stops in 2003. Discharge to another hospital unit is the trap: it was 3, 5, B or C until 2003 or 2004 and becomes F, G, K or L from 2004 onwards. Counting "discharged onwards to hospital" across the whole register therefore needs both sets, and either set alone gives a series with a hole in it. Codes 2, 4, 7 and A only begin in 1995, E in 2002, and K and L in 2006.
- **`c_eakt`:** 2 of the 7 codes were REUSED with a different meaning, so the same number does not mean the same thing across the register. The lookup above gives the current meaning; the periods block gives both. Code 1: arbejdsulykke, then idræt, sport og motion from 01.01.1995. Code 2: ikke arbejdsulykke, then leg, hobby og and fritidsvirksomhed from 01.01.1995. Every code in this variable stops by 31.12.2003, so it says nothing about later contacts.
- **`c_emek`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_emodpart`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_epart`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_ested`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_etraf`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_henm`:** Only four codes cover the whole register: 0, 1, 2 and 8. Everything else has a window. Codes 3, 5, 9, B, C and D stop at the end of 2003 and 6 stops at the end of 1998, while F and G only begin in 2004, A in 1995 and E in 2002. The end of 2003 is a break: referrals from a hospital unit were coded 3, 5, B, C or D before it and F or G after it. Counting any of those across the whole period gives a number that changes for administrative reasons alone.
- **`c_kontaars`:** Code 4 was Selvtilføjet skade until the end of 1993 and Selvmord/selvmordsforsøg from 1994. Those are not the same population: self-inflicted injury is wider than an attempt at suicide, so a series that spans 1994 changes definition rather than changing level. Codes 5 and 9 stop at the end of 2013. Code 7 only starts in 2011 and code 6 only in 2014, so neither says anything about earlier contacts.
- **`sex_lpr`:** The coding changed at the start of 2005: `1`/`2` until the end of 2004, `M`/`K` from 2005. A study spanning that year that filters on `c_sex == "2"` keeps only the women seen before 2005 and silently drops the rest, with no error and no empty result to warn you. Take sex from BEF instead, where it is `koen` coded `1`/`2` throughout, unless you specifically need what the hospital recorded.

Where these values come from:

- **`pattype`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`icd10_sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`indm`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_udm`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_blok`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_eakt`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_emek`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_emodpart`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_epart`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_ested`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_etraf`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_henm`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_kontaars`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`sex_lpr`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).

</details>

**Worth knowing:**

- **`recnum`:** The key that links uaf_adm to uaf_diag and the other open-contact tables. It identifies a contact, not a person. Sundhedsdatastyrelsen states that recnum is unique only within one update of the register. A contact can get a new recnum when the register is updated, and a recnum can be reused for a different contact. Join tables only within the same delivery and the same year, and do not use recnum to match an open contact to its closed version in lpr_adm.
- **`d_inddto`:** The contact's start date. The open-contact tables are filed by its year: a contact is in the table for the year it started and in each later year while it is still open.
- **`d_uddto`:** Empty while the contact is open: Sundhedsdatastyrelsen's extraction guide describes open contacts as contacts without a discharge date.
- **`c_pattype`:** Day patient (1) was discontinued in 2002, and hospitals then recorded those patients differently (some as outpatients, some as inpatients). Emergency room patient (3) was discontinued in 2014 and replaced by outpatient (2) with acute admission (c_indm = 1).
- **`year`:** Not a DST variable. It is the yearly file a row came from. In the open-contact tables that is a year in which the contact was open, and a contact open for several years is in several of them, so rows from different years can be the same contact. Use d_inddto in uaf_adm to say when a contact started.
