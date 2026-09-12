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
- **`c_kom`:** A finer subdivision briefly existed below municipality level: LPR2 had its own table, LPR_DISTKOD, giving a social district (socialdistrikt) for residents of large municipalities only, 1995-2003. Not modelled as a separate register here (per Sundhedsdatastyrelsen's own LPR documentation, esundhed.dk table t_distkod) - only relevant to a study needing sub-municipality geography for that narrow window and population.
- **`d_opdatdto`:** Before 2005, the same fact (a contact's last-update date) lived in its own table, LPR_OPDTDTO, covering 2000-2004 - not modelled as a separate register here since Sundhedsdatastyrelsen's own LPR documentation (esundhed.dk, table t_opdatdto) confirms the fact simply moved onto lpr_adm from 2005 onward. A study needing this fact before 2005 has no column to read it from; DST's order list shows no earlier source.

</details>

*No published source gives a data type for 20 of these 52 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_DIAG** (one-to-many).

<details>
<summary>Value sets for the coded columns (21)</summary>

| Code system | Values |
| --- | --- |
| `pattype` | `0` Heldoegnspatient (to 2001), Indlagt patient (2002-), `1` Dagpatient (to 1986), Deldoegnspatient (1987-2001), `2` Natpatient (to 1986), Ambulant patient (1987-), `3` Skadestuepatient |
| `icd10_sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `indm` | `1` Akut, `2` Ikke akut, `9` Uoplyst |
| `c_udm` | `1` Udskrevet/afsluttet til alment praktiserende læge, `2` Udskrevet/afsluttet til praktiserende speciallæge, `3` Udskrevet/afsluttet til eget heldøgnsafsnit eller eget deldøgnsafsnit, `4` Ingen lægelig opfølgning (må kun anvendes for psykiatriske afdelinger), `5` Udskrevet/afsluttet til andet heldøgnsafsnit eller andet deldøgnsafsnit, `6` Udskrevet/afsluttet til ambulatorium, `7` Udeblevet (kun ambulante patienter), `8` Død, `9` Uoplyst, `A` Andet, `B` Udskrevet/afsluttet til eget ambulatorium, `C` Udskrevet/afsluttet til andet ambulatorium, `E` Behandling i udlandet (hvor sygehus beslutter behandling i udlandet), `F` Afsluttet til sygehusafsnit, `G` Afsluttet til sygehusafsnit, venteforløb, `K` Afsluttet til sygehusafsnit (hjemmet), `L` Afsluttet til sygehusafsnit, venteforløb (hjemmet) |
| `c_henm` | `0` Ingen henvisning, `1` Henvist fra alment praktiserende læge, `2` Henvist fra praktiserende speciallæge, `3` Henvist fra eget heldøgnsafsnit eller eget deldøgnsafsnit, `5` Henvist fra andet heldøgnsafsnit eller andet deldøgnsafsnit, `6` Henvist fra skadestue eller ambulatorium, `8` Herfødt, `9` Uoplyst, `A` Andet, `B` Eget ambulatorium, `C` Andet ambulatorium, `D` Skadestue, `E` Udlandet (kun direkte henvisninger), `F` Henvist fra sygehusafsnit, `G` Henvist fra sygehusafsnit, venteforløb |
| `c_kontaars` | `1` Sygdom og tilstand uden direkte sammenhæng med udefra påført læsion, `2` Ulykke, `3` Voldshandling, `4` Selvmord/selvmordsforsøg, `5` Senfølge, `6` Komplet skaderegistrering foretages på efterfølgende kontakt, `7` Komplet skaderegistrering foretaget på tidligere kontakt, `8` Andet, `9` Uoplyst |
| `sex_lpr` | `1` Mand (to 2004), `2` Kvinde (to 2004), `M` Mand (2005-), `K` Kvinde (2005-) |
| `c_andenbeh` | `0` Ja, eget ambulatorium, `1` Ja, andet ambulatorium, eget sygehus, `2` Ja, andet ambulatorium, andet sygehus, `3` Ja, egen læge, `6` Ja, anden, `7` Ingen, `8` Død, `9` Uoplyst |
| `c_blok` | `1` Medicinsk blok, `2` Kirurgisk blok, `5` Psykiatrisk blok, `6` Laboratorie blok, `8` Øvrige specialer, `9` Andre specialer, `99` Uden for specialer |
| `c_eakt` | `1` Idræt, sport og motion, `2` Leg, hobby og and fritidsvirksomhed, `3` Erhvervsarbejde, `4` Vitalaktivitet, `5` Ulønnet arbejde, `8` Anden aktivitet, `9` Ikke specificeret aktivitet |
| `c_emek` | `0` Slag, stød grundet fald på samme niveau, `1` Slag, stød grundet fald på trappe eller til lavere niveau, `2` Slag, stød grundet kontakt med anden genstand, person eller dyr, `3` Klemning, snit eller stik, `4` Fremmedlegeme, `5` Kvælning, `6` Kemisk påvirkning, `7` Termisk, elektrisk eller strålingspåvirkning, `8` Akut overbelastning af legeme eler legemesdel, `9` Anden og ukendt skadesmekanisme |
| `c_emodpart` | `0` Ingen modpart, `1` Til fods, `2` Cykel, `3` Knallert, `4` Motorcykel eller scooter, `5` Personbil, `6` Varevogn, `7` Lastbil, bus, m.m., `8` Anden transportform, modpart, `9` Ikke specificeret transportform, modpart |
| `c_epart` | `1` Til fods, `2` Cykel, `3` Knallert, `4` Motorcykel eller scooter, `5` Personbil, `6` Varevogn, `7` Lastbil, bus, m.m., `8` Anden transportform, tilskadekomne, `9` Ikke specificeret transportform, tilskadekomne |
| `c_ested` | `0` Trafikområde, `1` Boligområde, `2` Produktions- og værkstedsområde, `3` Butiks- handels- og serviceområde, `4` Skole, offentlig administrations- og institutionsområde, `5` Idræts- og sportsområdet, `6` Forlystelses- og parkområdet, `7` Fri natur, `8` Hav, sø og vådområder, `9` Uoplyst |
| `c_etraf` | `1` Færdselsuheld, `2` Ikke færdselsuheld |
| `c_indform` | `0` Akut indlæggelse, `1` Indkaldt via forambulatorium, `2` Indkaldt via andet ambulatorium, `3` Anden indkaldelse, `4` Genindkaldt, `5` Indkaldt via koordineret forundersøgelse, `8` Herfødt, `9` Uoplyst |
| `c_indfra` | `0` Hjemmet, `1` Hjemmet ekskl. døgnistitution, `2` Psykiatrisk hospital/sygehusafdeling, `3` Psykiatrisk dag/nathospital, `4` Somatisk afdeling, `5` Plejehjem/institution, `6` Andet, `8` Født her, `9` Uoplyst, `A` Andet |
| `c_senstat` | `0` Ja, samme afdeling, `1` Ja, anden afdeling, `2` Ja, andet sygehus, `3` Ja, alderdoms- eller plejehjem, `5` Ja, rekreationshjem, `6` Ja, andre institutioner, `7` Ingen, `8` Død, `9` Uoplyst |
| `c_udtil` | `0` Hjemmet, `1` Hjemmet ekskl. døgnistitution, `2` Psykiatrisk hospital/sygehusafdeling, `3` Psykiatrisk dag/nathospital, `4` Somatisk afdeling, `5` Plejehjem/institution, `6` Andet, `8` Død, `9` Uoplyst, `A` Andet |
| `c_ulykke` | `0` Nej, `1` Ja, trafikulykke, `2` Ja, arbejdsulykke, `3` Ja, idrætsulykke, `4` Ja, hjemmeulykke, `5` Ja, anden ulykke, `6` Uoplyst, `7` Uoplyst |
| `icd8` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer) |

- **`pattype`:** There are four codes, not six, and three of them changed meaning. Code `1` was Dagpatient until 1986 and Deldoegnspatient from 1987, and then stops entirely at the end of 2001. Code `2` was Natpatient until 1986 and Ambulant from 1987. Code `0` was Heldoegnspatient until 2001 and Indlagt patient from 2002. The register only started using `1`, `2` and `3` in 1994, so before that essentially every contact is `0`. Code `3` was discontinued at the end of 2013, and from 2014 an emergency-room visit arrives as `2` with an acute admission mode in `c_indm`. Reading `2` as outpatient across the whole register therefore mislabels night patients before 1987 and emergency visits after 2013.
- **`icd10_sks`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing. Do not carry the habit across to the cause-of-death registers: they hold the plain code, so stripping a D there removes the first real character instead.
- **`indm`:** From 2014 this is what separates an emergency-room visit from an ordinary outpatient one, because `c_pattype` code `3` was discontinued and both arrive as `2`. Code `9` (Uoplyst) stops at the end of 2003, so a missing value after that is genuinely missing rather than coded as unknown.
- **`c_udm`:** Only codes 1, 8 and 9 reach back to 1987, and 9 stops in 2003. Discharge to another hospital unit is the trap: it was 3, 5, B or C until 2003 or 2004 and becomes F, G, K or L from 2004 onwards. Counting "discharged onwards to hospital" across the whole register therefore needs both sets, and either set alone gives a series with a hole in it. Codes 2, 4, 7 and A only begin in 1995, E in 2002, and K and L in 2006.
- **`c_henm`:** Only four codes cover the whole register: 0, 1, 2 and 8. Everything else has a window. Codes 3, 5, 9, B, C and D stop at the end of 2003 and 6 stops at the end of 1998, while F and G only begin in 2004, A in 1995 and E in 2002. The end of 2003 is a break: referrals from a hospital unit were coded 3, 5, B, C or D before it and F or G after it. Counting any of those across the whole period gives a number that changes for administrative reasons alone.
- **`c_kontaars`:** Code 4 was Selvtilføjet skade until the end of 1993 and Selvmord/selvmordsforsøg from 1994. Those are not the same population: self-inflicted injury is wider than an attempt at suicide, so a series that spans 1994 changes definition rather than changing level. Codes 5 and 9 stop at the end of 2013. Code 7 only starts in 2011 and code 6 only in 2014, so neither says anything about earlier contacts.
- **`sex_lpr`:** The coding changed at the start of 2005: `1`/`2` until the end of 2004, `M`/`K` from 2005. A study spanning that year that filters on `c_sex == "2"` keeps only the women seen before 2005 and silently drops the rest, with no error and no empty result to warn you. Take sex from BEF instead, where it is `koen` coded `1`/`2` throughout, unless you specifically need what the hospital recorded.
- **`c_andenbeh`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.1986.
- **`c_eakt`:** 2 of the 7 codes were REUSED with a different meaning, so the same number does not mean the same thing across the register. The lookup above gives the current meaning; the periods block gives both. Code 1: arbejdsulykke, then idræt, sport og motion from 01.01.1995. Code 2: ikke arbejdsulykke, then leg, hobby og and fritidsvirksomhed from 01.01.1995. Every code in this variable stops by 31.12.2003, so it says nothing about later contacts.
- **`c_emek`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_emodpart`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_epart`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_ested`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_etraf`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.2003.
- **`c_indform`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.1986.
- **`c_indfra`:** 4 of the 10 codes were REUSED with a different meaning, so the same number does not mean the same thing across the register. The lookup above gives the current meaning; the periods block gives both. Code 1: anden afdeling, then hjemmet ekskl. døgnistitution from 01.01.1995. Code 2: andet sygehus, then psykiatrisk hospital/sygehusafdeling from 01.01.1995. Code 3: alderdoms- eller plejehjem, then psykiatrisk dag/nathospital from 01.01.1995. Code 5: skadestue, then plejehjem/institution from 01.01.1995. Every code in this variable stops by 31.12.2000, so it says nothing about later contacts.
- **`c_senstat`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.1986.
- **`c_udtil`:** 4 of the 10 codes were REUSED with a different meaning, so the same number does not mean the same thing across the register. The lookup above gives the current meaning; the periods block gives both. Code 1: anden afdeling, then hjemmet ekskl. døgnistitution from 01.01.1995. Code 2: andet sygehus, then psykiatrisk hospital/sygehusafdeling from 01.01.1995. Code 3: alderdoms- eller plejehjem, then psykiatrisk dag/nathospital from 01.01.1995. Code 5: rekreationshjem, then plejehjem/institution from 01.01.1995. Every code in this variable stops by 31.12.2000, so it says nothing about later contacts.
- **`c_ulykke`:** Not every code covers the whole register. The periods block gives the window for each one; codes stop being used at 31.12.1986.
- **`icd8`:** A study whose period starts before 1994 is reading two classifications out of one column. ICD-10 codes match nothing in the early years, and the usual substr(c_diag, 2, 4) returns a meaningless fragment of an ICD-8 code rather than failing, so nothing tells you it went wrong.

Where these values come from:

- **`pattype`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`icd10_sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`indm`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_udm`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_henm`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_kontaars`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`sex_lpr`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_andenbeh`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_blok`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_eakt`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_emek`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_emodpart`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_epart`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_ested`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_etraf`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_indform`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_indfra`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_senstat`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_udtil`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`c_ulykke`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`icd8`:** [Retired classification, no current DST page](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer).

</details>

**Worth knowing:**

- **`recnum`:** The key every other LPR2 dataset joins on. It identifies a contact, not a person.
- **`d_inddto`:** Use this as the contact date. It is the admission date, so for an outpatient course it is the date the course started, not the date of a particular visit.
- **`c_spec`:** DST publishes what each specialty code means in its department and specialty overview: https://www.dst.dk/da/Statistik/dokumentation/Times/moduldata-for-sociale-forhold--sundhedsvaesen--retsvaesen/spec (in Danish). The codes are not self-explanatory, so look them up rather than grouping on the digits.
- **`c_adiag`:** A copy of the contact's action diagnosis. Use lpr_diag instead: it holds every diagnosis on the contact, not only the action one.
- **`c_indm`:** Used together with c_pattype to separate emergency-room contacts from ordinary outpatient ones after about 2014, see the LPR extraction chapter. Available for the register's whole span, so a missing c_indm is an extract boundary rather than a coverage gap.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
