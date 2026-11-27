<!-- Generated from schema/registers/ssko.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `spec2` | character | code | Specialty, 2-digit |
| `kontaktagg` | numeric | value | Contacts, aggregated |

<details>
<summary>All other columns (5)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `koenimp` | character | code | Sex, imputed values included |  |
| `alderimp` | numeric | value | Age at end of year, imputed values included |  |
| `cprtjek` | character | code | CPR-tjek | 2013 to 2025 |
| `cprtype` | character | code | CPR-type | 2013 to 2025 |
| `version` | numeric | date | Version | 2013 to 2025 |

- **`koenimp`:** Imputed where the source was missing, so it is not identical to koen in BEF. Prefer BEF when you need sex as a study variable.

</details>

*No published source gives a data type for 7 of these 8 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `spec2` | `00` Uoplyst, `01` Anæsthesiologi, `02` Fiktiv knækgrænse, `03` Diagn. radiologi Kbh., `04` Dermato-venerologi, `05` Diagnost. radiologi, `06` Reumatologi, `07` Gynækologi/obstetrik, `08` Intern medicin, `09` Kirurgi, `10` Histopatalogiske undersøgelser, `11` Klinisk kemi, `15` Ørelægevagt Kbh., `16` Ørelægevagt KAK, `17` Neurokirurgi, `18` Neuromedicin, `19` Øjenlægehjælp, `20` Ortopædisk kirurgi, `21` Ørelægehjælp, `22` Patologi, `23` Plastikkirurgi, `24` Psykiatri, `25` Pædiatri, `26` Børnepsykiatri, `28` Tropemedicin, `35` Distriktspsykiatri, `39` Øjenlægehjælp *kfa*, `41` Ørelægehjælp *kfa*, `42` Referencelaborator., `43` Diagnoselaboratoriet, `44` Københavns Praktiserende Lægers Laboratorium, `45` Medicinsk Laboratorium, `46` Omegnslaboratorier, `47` Århus Universitet, `48` Statens Seruminstitut, `49` Tandplejere, `50` Tandlægehjælp, `51` Fysioterapi 51, `52` Briller, `53` Kiropraktik, `54` Fodterapi, `55` Ortonyxi, `56` Klinikbehandling, `57` Ridefysioterapi, `58` Genoptræning, Øfeldt, `59` Fodbehandling arvævspat., `60` Fodbehandling, leddegigt, `61` Fysioterapi 61, `62` Vederlagsfri fysioterapi, `63` Psykologhjælp, `64` Kiropraktik kronikere, `65` Vederlagsfri ridefysioterapi, `68` Høreomsorg, `70` Almen læge, konsultation, dagtid, `71` Almen læge, konsultation, aften mv., `72` Almen læge, telefonkonsultation, dagtid, `73` Almen læge, telefonkonsultation, aften mv., `74` Almen læge, besøg, dagtid, `75` Almen læge, besøg, aften mv., `76` Almen læge, email-konsultation, `77` Almen læge, andre ydelser, `78` Almen læge, kontakter, forebyggelse mv., `79` Almen læge, basishonorar mv., `80` Almen lægehjælp 80, `81` KFA-vagtordning 81, `82` Kak vagtlægehjælp 82, `83` Vagtlægehjælp 83, `84` Kak vagtlægehjælp 84, `85` Præhospital, `86` Ø-læger, `87` Visitat kønssygdomme, `88` Læge u/ overenskomst, `89` KFA-vagtordning 89, `90` Offentl. sygesikring, `91` Disp. f. Sundhedsst., `92` Rekv.lægem. mv., `93` Rekvis. speciallæger, `94` Tilskud ernæringspræparater, `95` Begravelseshjælp, `96` Tolkebistand, `97` Fonde, `98` Bef. af alm. læger, `99` Diverse ydelser |
| `koen` | `1` Mand, `2` Kvinde, `9` Uoplyst |

- **`spec2`:** All codes are valid from 1 January 2005. Only code 10 has an end date, 31 December 2006. General practice appears as 80 and as the subdivided codes 70 to 79 (daytime or evening, consultation, telephone, e-mail, home visit). DST says it makes that subdivision itself for its published contact tables, and that SSSY has the same split in spec80 from 2023, so check which of 70 to 80 your delivery holds before you filter on general practice. From 2021 DST no longer registers after-hours doctor contacts under 83, and the group 03 (diagnostic radiology, Copenhagen) is placed under diagnostic radiology (DST, Lægebesøg, comparability over time). Laboratory contacts fall sharply from 2015 to 2016 because general practitioners' blood tests in the Capital Region moved to Region Hovedstaden's hospitals on 1 January 2016 (DST, SPEC2).
- **`koen`:** DST's classification KOEN_V1_1980 also defines `9` for not stated, which a delivery may not contain but a value set should. Sex is taken from the tenth digit of the CPR number: even is female, odd is male.

Where these values come from:

- **`spec2`:** [DST's TIMES page for SPEC2 (value set D280450.TXT_SPEC2)](https://www.dst.dk/da/Statistik/dokumentation/Times/sygesikringsstatistik/spec2).
- **`koen`:** [DST's classification KOEN_V1_1980](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/koen) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e267e7c0-d998-4922-b2c4-6b44b15dd149csv_da)).

</details>

**Worth knowing:**

- **`spec2`:** The kind of provider (general practice, specialist, dentist, psychologist and so on), the same code as spec2 in SSSY. General practice is spread over several codes, so take the list from DST's value set rather than picking a single code.
- **`kontaktagg`:** The number of contacts summed per person and specialty. A contact is a direct meeting between patient and provider: a consultation (including phone and e-mail) or a home visit, with any examinations in the same contact counted once. For dentists only the first visit counts, and DST calls the count uncertain for chiropody, physiotherapy and riding physiotherapy. DST notes a small number of negative values in 2008-2010 from settlement corrections, and that the definition of a contact has changed over time. From 2021 only one service per person per treatment date can be a contact in radiology (05) and foot therapy (54, 55, 59, 60). Foot therapy had no agreement from June 2005 to June 2011 and most of the fee was settled outside the insurance system. DST was also told of small sign errors in corrections from Region Midtjylland for October to December 2013.
