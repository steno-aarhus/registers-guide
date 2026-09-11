<!-- Generated from schema/registers/mfr_nyfoedte.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_Nyfoedt`** | character | join key | Newborn key |
| `LevendefoedtDoedfoedt` | character | code | Live birth or stillbirth |
| **`CPRnummer_Barn`** | character | join key | Child's CPR-number |
| `FoedselsDato_Barn` | date | date | Child's date of birth |

<details>
<summary>All other columns (67)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_Foedsel`** | character | join key | Birth event key |
| `Foedsel` | numeric | code | First-born-of-this-birth indicator |
| `FoedselsAar` | numeric | value | Birth year |
| `Gestationsalder` | numeric | value | Gestational age (days) |
| `GestationsalderUger` | numeric | value | Gestational age (full weeks) |
| `Foedested_Faktisk` | character | code | Actual place of birth |
| `FoedselsDiagnose_Barn` | character | code | Child's birth diagnosis |
| `FoedselsDiagnose_Mor` | character | code | Mother's birth diagnosis |
| `Kejsersnit` | character | code | Caesarean section procedure code |
| `Igangsaettelse_Medicinsk` | character | code | Medical labour induction |
| `Igangsaettelse_HSP` | character | code | Labour induction by membrane rupture (HSP) |
| `Igangsaettelse_Ballonkateter` | character | code | Labour induction by balloon catheter |
| `PrimaerVandafgang` | character | code | Primary rupture of membranes (incl. PROM/PPROM) |
| `Fosterpraesentation` | character | code | Fetal presentation |
| `AntalBoernIFoedslen` | numeric | value | Number of children in this birth |
| `AntalLevendefoedteIFoedslen` | numeric | value | Number of live-born children in this birth |
| `AntalDoedfoedteIFoedslen` | numeric | value | Number of stillborn children in this birth |
| `BarnsNummerIFoedslen` | numeric | value | Child's number within this birth |
| `Apgarscore` | numeric | value | 5-minute Apgar score |
| `Vaegt_Barn` | numeric | value | Child's birth weight (grams) |
| `Laengde_Barn` | numeric | value | Child's birth length (cm) |
| `Hovedomfang` | numeric | value | Child's head circumference (cm) |
| `Abdominalomfang` | numeric | value | Child's abdominal circumference (cm) |
| `Placentavaegt` | numeric | value | Placental weight (grams) |
| `Paritet` | numeric | value | Parity (completed pregnancies, incl. current) |
| `Vaegt_Mor` | numeric | value | Mother's pre-pregnancy weight (kg) |
| `Hoejde_Mor` | numeric | value | Mother's pre-pregnancy height (cm) |
| `BMI_Mor` | numeric | value | Mother's pre-pregnancy BMI |
| `Tobaksforbrug` | character | code | Mother's smoking status in pregnancy |
| `AnsvarligRegion_Geo_Kode` | character | code | Geographic region of the reporting institution (code) |
| `AnsvarligRegion_Geo_Tekst` | character | derived | Geographic region of the reporting institution (text) |
| `AnsvarligRegion_Org_Kode` | character | code | Organisational region of the reporting hospital (code) |
| `AnsvarligRegion_Org_Tekst` | character | derived | Organisational region of the reporting hospital (text) |
| `AnsvarligInstitution_Kode` | character | code | Reporting institution (code) |
| `AnsvarligInstitution_Tekst` | character | derived | Reporting institution (text) |
| `AnsvarligInstitution_KodeType` | character | code | Code type of AnsvarligInstitution_Kode |
| `SOR_EjerEnhedsType` | character | code | SOR owner type (public/private) of the reporting unit |
| `SOR_SundhedsInstitution` | character | code | SOR health institution code |
| `SOR_Enhed` | character | code | SOR unit code |
| `SHAK_Sygehus` | character | code | SHAK hospital code (4 characters) |
| `SHAK_Afdeling` | character | code | SHAK department code (6 characters) |
| `SHAK_Afsnit` | character | code | SHAK ward code (7 characters) |
| `DoedFoersteAar_Barn` | numeric | value | Days to the child's death within its first year of life |
| `DoedFoersteAar_Mor` | numeric | value | Days from birth to the mother's death within the first year after |
| `ErCPRnummerGyldigt_Barn` | character | code | Validity type of the child's CPR-number |
| `Koen_Barn` | character | code | Child's sex |
| `FoedselsTidspunkt` | character | value | Child's time of birth |
| `Kilde_Barn` | character | code | Source of the child's birth record |
| `IndberetningsSystem_Barn` | character | code | Reporting system for the child's birth contact |
| `DW_EK_Kontakt_Barn` | character | code | Child's LPR birth contact key |
| `DW_ID_Hjem_Barn` | character | code | Home/clinic birth paper-form key |
| `DW_ID_Doed_Barn` | character | code | Stillbirth paper-form key |
| **`CPRnummer_Mor`** | character | join key | Mother's CPR-number |
| `ErCPRnummerGyldigt_Mor` | character | code | Validity type of the mother's CPR-number |
| `Koen_Mor` | character | code | Sex on the mother's CPR-like number |
| `FoedselsDato_Mor` | date | date | Mother's date of birth |
| `Alder_Mor` | numeric | value | Mother's age at the child's birth |
| `BopaelsKommune_Mor` | character | code | Mother's municipality of residence at the child's birth |
| `BopaelsRegion_Mor` | character | code | Mother's region of residence at the child's birth |
| `Kilde_Mor` | character | code | Source of the mother's record |
| `DW_EK_Kontakt_Mor` | character | code | Mother's LPR birth contact key |
| **`CPRnummer_Far`** | character | join key | Father's CPR-number |
| `ErCPRnummerGyldigt_Far` | character | code | Validity type of the father's CPR-number |
| `Koen_Far` | character | code | Sex on the father's CPR-like number |
| `FoedselsDato_Far` | date | date | Father's date of birth |
| `Alder_Far` | numeric | value | Father's age at the child's birth |
| `Kilde_Far` | character | code | Source of the father's record |

- **`Foedsel`:** Filter to `Foedsel == 1` to count births instead of newborns: a twin birth otherwise contributes two rows to any count of "births".
- **`FoedselsDiagnose_Barn`:** D-prefixed like LPR (e.g. DZ389), not the plain WHO code cancer/ dodsaars use. See [ICD codes and the D-prefix](understand-lpr.qmd#d-prefix-not-everywhere).
- **`Kejsersnit`:** An open SKS procedure code space, not a small enumerated set: no `code_system` is attached here because the underlying classification is the general SKS procedure catalogue (see kont_type.yaml's own reader_note on the same issue), not a birth-specific value list. A non-missing value means a caesarean happened; treat the specific KMCA* variant as a procedure detail, not a category to enumerate.
- **`Igangsaettelse_Medicinsk`:** Multiple induction methods can co-occur and are reported as separate indicator columns (this one, Igangsaettelse_HSP, Igangsaettelse_Ballonkateter): they are not mutually exclusive categories of one variable.
- **`Apgarscore`:** -1 means not stated, not a real score - exclude or recode before computing a mean. Every stillbirth is set to 0 by definition, not -1: a naive "average Apgar score" across LevendefoedtDoedfoedt values will be pulled down by stillbirths unless filtered first.
- **`Vaegt_Barn`:** -1 means not stated. Recode before analysis, the same trap as Apgarscore above.
- **`Laengde_Barn`:** -1 means not stated. Recode before analysis, the same trap as Apgarscore above.
- **`Hovedomfang`:** -1 means not stated. Recode before analysis, the same trap as Apgarscore above.
- **`Abdominalomfang`:** -1 means not stated. Recode before analysis, the same trap as Apgarscore above.
- **`Placentavaegt`:** -1 means not stated. Recode before analysis, the same trap as Apgarscore above.
- **`Paritet`:** -1 means not stated. Also note the substitution rule above: this column is not always a direct report, it can be a computed fallback that only sees MFR's own 2005+ history, undercounting a mother's true parity if she had earlier children before 2005 or outside Denmark.
- **`Vaegt_Mor`:** -1 means not stated. Recode before analysis, the same trap as Apgarscore above.
- **`Hoejde_Mor`:** -1 means not stated. Recode before analysis, the same trap as Apgarscore above.
- **`BMI_Mor`:** -1.0 means not stated, and is computed from Vaegt_Mor/Hoejde_Mor: if either of those is itself -1 (not stated), this column will be too. Bliddal et al. 2018 (mined for this guide) reports pre-pregnancy BMI as structurally, not randomly, missing before 2003 in the older MFR eras - the field did not exist yet, distinct from this -1 sentinel.
- **`AnsvarligRegion_Geo_Kode`:** Not the same numbering as DST's own `reg` code system (which uses 81-84): this is Sundhedsdatastyrelsen's organisational region code, a different value space, despite both being called "region". Do not join or compare against `reg` without confirming the mapping first. Missing for some home and clinic births.
- **`AnsvarligInstitution_Kode`:** The code TYPE flips at the LPR3 cutover (Feb/March 2019): a SHAK hospital-department code before it, a SOR health-institution code after. AnsvarligInstitution_KodeType says which one a given row holds - check it before comparing codes across the boundary, since a SHAK code and a SOR code for the same physical hospital do not look alike.
- **`DoedFoersteAar_Barn`:** NULL means no death within the first year, it is not a missing-data code.
- **`DoedFoersteAar_Mor`:** NULL means no death within that year, it is not a missing-data code.
- **`IndberetningsSystem_Barn`:** No `code_system` attached: unlike `lprindberetningssystem` on the LPR3 tables, Sundhedsdatastyrelsen's own documentation gives only two examples here, not a closed list, and this column's values are not confirmed to be identical to lprindberetningssystem's ("LPR3", "MiniPAS", "LPR2", "LPR1") since this column also has to cover the non-LPR paper-form sources (Kilde_Barn = 2 or 3). Confirm with `count(IndberetningsSystem_Barn)` before filtering on it.
- **`DW_EK_Kontakt_Barn`:** Only populated for LPR-sourced births (Kilde_Barn = 1): NULL for the home-birth and stillbirth paper-form cases, which have no LPR contact to key against. A join to lpr_a_kontakt on this column silently drops every paper-form birth.
- **`CPRnummer_Mor`:** Since 2019, a birth counts even if the mother has no Danish CPR-number. Check ErCPRnummerGyldigt_Mor before joining this onward.
- **`BopaelsRegion_Mor`:** Same caution as AnsvarligRegion_Geo_Kode: this does not look like DST's own `reg` numbering (81-84). Not confirmed against `reg`, do not assume they are the same code space.
- **`Kilde_Far`:** "9 = Uoplyst" (unknown paternity) is a real, common value here, not a data-quality problem to filter out - see mfr_kilde_forael.yaml.

</details>

**Join key:** `CPRnummer_Barn`.

**Joins to other registers:**

- `CPRnummer_Barn` joins to **BEF** (many-to-one).
- `DW_EK_Kontakt_Barn` joins to **LPR_A_KONTAKT** (many-to-one).

<details>
<summary>Value sets for the coded columns (10)</summary>

| Code system | Values |
| --- | --- |
| `mfr_levendefoedt_doedfoedt` | `1` Levendefødt, `2` Dødfødt |
| `mfr_foedested_faktisk` | `1` Hospital, `2` Fødeklinik, `3` Hjem, `4` Uden for hospital, fødeklinik og hjem, `9` Uoplyst |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |
| `mfr_fosterpraesentation` | `DUP01` regelmæssig baghovedstilling, `RGAD01` regelmæssig baghovedstilling, `DUP02` uregelmæssig baghovedstilling, `RGAD02` uregelmæssig baghovedstilling, `DUP03` dyb tværstand, `RGAD03` dyb tværstand, `DUP04` forissepræsentation, `RGAD04` forissepræsentation, `DUP05` pandepræsentation, `RGAD05` pandepræsentation, `DUP06` ansigtspræsentation, `RGAD06` ansigtspræsentation, `DUP07` ren sædepræsentation, `RGAD07` ren sædepræsentation, `DUP08` fuldstændig sæde-fod-præsentation, `RGAD08` fuldstændig sæde-fod-præsentation, `DUP09` ufuldstændig sæde-fod-præsentation, `RGAD09` ufuldstændig sæde-fod-præsentation, `DUP10` fodpræsentation, `RGAD10` fodpræsentation, `DUP11` anden underkropspræsentation, `RGAD11` anden underkropspræsentation, `DUP12` tværleje/skråleje, `RGAD12` tværleje/skråleje, `DUP13` høj lige stand, `RGAD13` høj lige stand, `DUP14` asynklitisk hovedpræsentation, `RGAD14` asynklitisk hovedpræsentation, `DUP15` uspecificeret hovedpræsentation, `RGAD15` uspecificeret hovedpræsentation, `DUP16` uspecificeret underkropspræsentation, `RGAD16` uspecificeret underkropspræsentation, `DUP99` fosterpræsentation uden specifikation, `RGAD99` fosterpræsentation uoplyst |
| `tobaksforbrug` | `DUT00` Moder ryger ikke, `RGAB00` moder ryger ikke, `DUT10` Moder ophørt med rygning i 1. trimester, `RGAB10` moder ophørt med rygning i 1. trimester, `DUT11` Moder ophørt med rygning efter 1. trimester, `RGAB11` moder ophørt med rygning efter 1. trimester, `DUT20` Moder ryger op til 5 cigaretter dagligt, `RGAB20` moder ryger op til 5 cigaretter dagligt, `DUT21` Moder ryger fra 6-10 cigaretter dagligt, `RGAB21` moder ryger fra 6-10 cigaretter dagligt, `DUT22` Moder ryger fra 11-20 cigaretter dagligt, `RGAB22` moder ryger fra 11-20 cigaretter dagligt, `DUT23` Moder ryger over 20 cigaretter dagligt, `RGAB23` moder ryger over 20 cigaretter dagligt, `DUT29` Moder ryger, mængde ikke oplyst, `RGAB29` moder ryger, mængde ikke oplyst, `DUT99` Moders rygestatus uoplyst, `RGAB99` moders rygestatus uoplyst |
| `mfr_er_cprnummer_gyldigt` | `Gyldig hos CPR` Gyldig hos CPR, `Udgået hos CPR` Udgået hos CPR, `Erstatnings CPR` Erstatnings CPR, `Fiktivt` Fiktivt, `Andet CPR` Andet CPR |
| `mfr_koen` | `K` Kvinde, `M` Mand, `Ukendt` Ukendt |
| `mfr_kilde_barn` | `1` Landspatientregisteret (LPR), `2` Hjemmefødselsblanket, `3` Dødfødselsblanket |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |
| `mfr_kilde_forael` | `1` Landspatientregisteret (LPR), `2` Hjemmefødselsblanket, `3` Dødfødselsblanket, `4` CPR, `9` Uoplyst |

- **`mfr_levendefoedt_doedfoedt`:** A query written against the old 1997-2018 "Levendefødte" table implicitly filtered to live births by construction. The same query pointed at `mfr_nyfoedte` without `LevendefoedtDoedfoedt == 1` will silently pull in stillbirths too. Apgarscore is set to 0 for every stillbirth rather than left missing, which will also distort a naive mean/summary of Apgar scores computed without this filter.
- **`mfr_foedested_faktisk`:** Do not try to derive this yourself from FoedselsDiagnose_Barn alone: the mapping from birth-diagnosis code to actual birthplace changed at two different boundaries (2012, and the LPR3 cutover in Feb/March 2019), and Sundhedsdatastyrelsen has already resolved that history into this single column. Recomputing it from the diagnosis code with only the current (post-2019) mapping will misclassify pre-2012 home births as "outside hospital, birth clinic and home".
- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.
- **`mfr_fosterpraesentation`:** Recorded on the child's own fødselskontakt (or as an add-on to it before LPR3), not the mother's, even though fetal presentation is clinically a fact about the pregnancy and delivery. Join through DW_EK_Nyfoedt if cross-referencing against Barn_* satellite tables, not DW_EK_Foedsel.
- **`tobaksforbrug`:** Bliddal et al. 2018 (mined earlier for this guide) reports smoking status as 100% missing before late 1997 and notes the field is otherwise reliably recorded once it exists. That predates both DUT and RGAB: an analysis spanning multiple decades needs to know smoking status went through at least two encodings (pre-1997: absent; 1997 to the LPR3 cutover: DUT*; LPR3 cutover onwards: RGAB*), not one stable variable. When multiple smoking-status sources exist for the same birth, Sundhedsdatastyrelsen resolves them in a fixed order (result/add-on tied to the primary birth record over other records, "komplet" over "inkomplet" reporting status, then the heaviest smoking category over lighter ones) - see the MFR 2019+ documentation for the exact tie-break rules if you need to reproduce Tobaksforbrug from the underlying satellite tables yourself.
- **`mfr_er_cprnummer_gyldigt`:** Only "Gyldig hos CPR" is guaranteed to resolve when joining to `bef` or any other CPR-keyed register: an "Udgået hos CPR" number identifies a real person but under a number CPR itself has since retired (e.g. after a birth-date correction), while "Erstatnings CPR" and "Fiktivt" numbers were never real CPR-numbers at all and will join to nothing. Check this column before joining CPRnummer_Barn, _Mor, or _Far onwards, rather than assuming every value in those columns is a working key.
- **`mfr_koen`:** For the child, this is derived from Dim.Borger.KoenID plus, for stillbirths reported on paper, the stillbirth form or the CPR-like number itself - not purely a CPR lookup, since a stillborn child may never receive one. For the mother and father, it is a straight lookup on their own CPR-derived sex, so Koen_Far being "Ukendt" or missing does not imply anything about the birth itself, only that paternal identity was not established.
- **`mfr_kilde_barn`:** This value gates which other columns are populated at all. `DW_EK_Kontakt_Barn` is only set when this is "1"; `DW_ID_Hjem_Barn` only when this is "2"; and `DW_ID_Doed_Barn` when this is "3" (or when a paper stillbirth form supplements an LPR3 birth record). A join to `Barn_Kontakter` or any other LPR-sourced satellite table will silently return nothing for rows where Kilde_Barn is "2" or "3", since those children have no LPR contact at all.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality - confirmed for two reused codes against a current-only DST source: 707 is Norddjurs today, not its pre-2007 meaning, and likewise 849 is Jammerbugt. `lookup:` below covers only this post-2007 set (99 entries), not the full 278-code `values_from` file. Christiansø (411) is included in `lookup:` even though it is not a municipality (see description above): it is a real value a `kom` column can hold, and DST's own current-only classification lists it as its own area code alongside the 98 municipalities. Excluding it would just move the "unhandled code" problem this fix is meant to solve onto that one value.
- **`mfr_kilde_forael`:** "9 = Uoplyst" exists for a parent (most often the father) but has no counterpart on the child's own Kilde_Barn: a birth with no determinable source simply is not in the register at all. Treat Kilde_Far == "9" as a real, common case (unknown paternity), not a data-quality flag to filter out.

Where these values come from:

- **`mfr_levendefoedt_doedfoedt`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).
- **`mfr_foedested_faktisk`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).
- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).
- **`mfr_fosterpraesentation`:** [Sundhedsdatastyrelsen: SKS Browser, classification res.praesent / dia DUP (fosterpræsentation)](https://medinfo.dk/sks/brows.php).
- **`tobaksforbrug`:** [Sundhedsdatastyrelsen: SKS Browser, classification res.tobaksgrav / dia DUT (tobaksforbrug)](https://medinfo.dk/sks/brows.php).
- **`mfr_er_cprnummer_gyldigt`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).
- **`mfr_koen`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).
- **`mfr_kilde_barn`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).
- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).
- **`mfr_kilde_forael`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).

</details>

**Worth knowing:**

- **`DW_EK_Nyfoedt`:** One row per newborn, not per birth: a twin birth produces two rows sharing one DW_EK_Foedsel but each with its own DW_EK_Nyfoedt. Use DW_EK_Nyfoedt to join Barn_* satellite tables, DW_EK_Foedsel to join Mor_* satellite tables.
- **`CPRnummer_Barn`:** A stillborn child may never receive a real CPR-number. Check ErCPRnummerGyldigt_Barn before joining this onward to bef or any other CPR-keyed register.
