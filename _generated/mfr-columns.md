<!-- Generated from schema/registers/mfr.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `alder_moder` | numeric | value | Mother's age |  |
| `bmi_moder` | numeric | value | Mother's BMI | 2003 to 2018 |
| **`cpr_barn`** | character | join key | Child's CPR number |  |
| **`cpr_moder`** | character | join key | Mother's CPR number |  |
| `flerfoldsfoedsel_beregnet` | character | code | Child's order in a multiple birth (derived) |  |
| `gestationsalder_dage` | numeric | value | Gestational age in days |  |
| `hoejde_moder` | numeric | value | Mother's height (cm) | 2003 to 2018 |
| `laengde_barn` | character | code | Child's length (cm) |  |
| `paritet` | numeric | value | Parity: completed pregnancies including stillbirths, counting this birth |  |
| `rygerstatus_moder` | character | code | Mother's smoking status (DUT codes) |  |
| `vaegt_barn` | numeric | value | Child's weight (grams) |  |
| `vaegt_moder` | numeric | value | Mother's weight | 2003 to 2018 |

<details>
<summary>All other columns (79)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `abdominalomfang` | numeric | value | Child's abdominal circumference (cm) |  |
| `abruptio` | character | code | Placental abruption (ICD-10 code) |  |
| `afdeling` | character | code | Hospital department |  |
| `alderveddoed_dage_barn` | numeric | value | Child's age at death (days) |  |
| `alder_fader` | numeric | value | Father's age |  |
| `amnioinfusion` | character | code | Amnioinfusion during birth (SKS procedure code) | 1998 to 2018 |
| `amnitomi_under_foedsel_hsp` | character | code | Amniotomy (SKS procedure code, or 1 = performed) |  |
| `andensutur` | character | code | Other suture after birth (SKS procedure code) |  |
| `apgarscore_efter5minutter` | numeric | value | Apgar score at 5 minutes (0-10, 99 = unknown) |  |
| `barnslevendenr_flerfoldfoedsel` | numeric | value | Live-born number in a multiple birth |  |
| `barnsnummer_flerfoldsfoedsel` | numeric | value | Number in a multiple birth |  |
| `besoeghosjordemoder` | character | code | Number of midwife visits during pregnancy |  |
| `besoeghoslaege` | character | code | Number of GP visits during pregnancy |  |
| `besoeghosspeciallaege` | character | code | Number of specialist visits during pregnancy |  |
| `bopaelskommune_moder` | character | code | Mother's municipality of residence |  |
| `cpapbeh_neonatalafdeling` | character | code | Admitted to neonatal unit and given CPAP (SKS treatment code) | 2000 to 2018 |
| **`cpr_fader`** | character | join key | Father's CPR number |  |
| `disproportio` | character | code | Disproportion (obstructed labour from abnormal pelvis, ICD-10 code) |  |
| `doedsdato_barn` | date | date | Child's date of death |  |
| `doedsdato_moder` | date | date | Mother's date of death |  |
| `epiduralblokade` | character | code | Epidural block (SKS treatment or anaesthesia code) | 2000 to 2018 |
| `episiotomi` | character | code | Episiotomy (SKS procedure code, or 1 = performed) |  |
| `fastsiddendemoderkage` | character | code | Retained placenta and membranes without bleeding (ICD-10 code) |  |
| `flerfoldsgraviditet` | character | code | Multiple pregnancy diagnosis (ICD-10 code) |  |
| `foedested` | character | code | Place of birth (SKS code) |  |
| `foedselsaar` | character | code | Year of birth |  |
| `foedselsdato` | date | date | Child's date of birth |  |
| `foedselsdiagnose_moder` | character | code | Mother's birth diagnosis |  |
| `foedselsloebenummer` | numeric | value | Birth serial number |  |
| `foedselstime` | character | code | Hour of birth |  |
| `fosterpraesentation` | character | code | Fetal presentation (DUP codes) |  |
| `hjemmebesoeg` | character | code | Home visit | 2003 to 2018 |
| `hovedomfang` | numeric | value | Child's head circumference |  |
| `intrauterin_asfyxi` | character | code | Intrauterine asphyxia, threatened fetal hypoxia (SKS diagnosis code) |  |
| `intrauterin_palpation` | character | code | Manual exploration of the uterus after birth (SKS procedure code) |  |
| `kejsersnit_modersoenske` | character | code | Caesarean section at the mother's request | 2002 to 2018 |
| `koen_barn` | character | code | Child's sex |  |
| `levende_eller_doedfoedt` | character | code | Live birth or stillbirth |  |
| `markoer_accreta` | character | code | Marker: Placenta accreta |  |
| `markoer_anaestesi_til_operation` | character | code | Marker: Anaesthesia for surgery | 2000 to 2018 |
| `markoer_andre_foedselskomplikati` | character | code | Marker: Other birth complications |  |
| `markoer_b_misdannelse` | character | code | Marker: Malformation in the child |  |
| `markoer_cardiomyopati` | character | code | Marker: Cardiomyopathy |  |
| `markoer_graviditetskomplikatio` | character | code | Marker: Pregnancy complications |  |
| `markoer_haemoperitoneum` | character | code | Marker: Haemoperitoneum |  |
| `markoer_hjemmefoedsel_beregnet` | character | code | Marker: Home birth (derived) |  |
| `markoer_igangsaettelse` | character | code | Marker: Induction of labour |  |
| `markoer_infektioner` | character | code | Marker: Infections |  |
| `markoer_kejsersnit` | character | code | Marker: Caesarean section |  |
| `markoer_medicinske_sygdomme` | character | code | Marker: Medical conditions |  |
| `markoer_navlesnorsblod_analyse` | character | code | Marker: Umbilical cord blood analysis | 2003 to 2018 |
| `markoer_perineal_bristning` | character | code | Marker: Perineal tear |  |
| `markoer_post_partum_bloedning` | character | code | Marker: Postpartum haemorrhage |  |
| `markoer_ruptur` | character | code | Marker: Uterine rupture |  |
| `markoer_smertelindring` | character | code | Marker: Pain relief | 1999 to 2018 |
| `markoer_ultralyd` | character | code | Marker: Ultrasound | 1999 to 2018 |
| `markoer_vestimulation` | character | code | Marker: Labour stimulation | 1999 to 2018 |
| `markoer_ydre_vending` | character | code | Marker: External cephalic version |  |
| `navlesnorsfremfald` | character | code | Umbilical cord prolapse (SKS diagnosis code) |  |
| `pk_mfr` | character | code | Primary key, joins to fk_mfr in the satellite tables |  |
| `placentavaegt` | numeric | value | Placental weight (grams) |  |
| `polyhydramnios` | character | code | Polyhydramnios (SKS diagnosis code) |  |
| `pprom` | character | code | Preterm prelabour rupture of membranes (ICD-10 code) |  |
| `praevia` | character | code | Placenta praevia (ICD-10 code) |  |
| `prom` | character | code | Prelabour rupture of membranes (ICD-10 code) |  |
| `respiratorbeh_neonatalafdeling` | character | code | Admitted to neonatal unit and given ventilator treatment (1 = yes) | 2000 to 2018 |
| `sengedage_beregnet_barn` | numeric | value | Child's bed days for the birth admission (derived) |  |
| `sengedage_beregnet_moder` | numeric | value | Mother's bed days for the birth admission (derived) |  |
| `sengedage_neonatalafdeling_barn` | numeric | value | Bed days in a neonatal unit, if transferred |  |
| `sepsis_barn` | character | code | Sepsis in the child (ICD-10 code) |  |
| `skalp_blodproeve` | character | code | Fetal scalp blood sampling, scalp pH (SKS treatment code) | 2000 to 2018 |
| `suturcollum` | character | code | Suture of the cervix after birth (SKS procedure code) |  |
| `sygehus` | character | code | Hospital code |  |
| `tang_forloesning` | character | code | Forceps delivery (SKS procedure code) |  |
| `tegn_paa_asphyxi` | character | code | Signs of asphyxia (ICD-10 code) |  |
| `tidligerefoedsler_i_danmark` | character | code | Number of previous births in Denmark |  |
| `tidligerekejsersnit_i_danmark` | character | code | Number of previous caesarean sections in Denmark |  |
| `tidligerespontaneaborter` | character | code | Number of previous spontaneous abortions |  |
| `vakuumekstraktion` | character | code | Vacuum extraction (SKS procedure code) |  |

- **`cpapbeh_neonatalafdeling`:** DST's variable list gives this column from 2000, but Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) gives it as valid from 2001. Check the first years in your own data before relying on them.
- **`levende_eller_doedfoedt`:** Stillbirths flagged here have their own richer detail table, mfrdfoed (see mfrdfoed.yaml), joined via FK_MFR - not confirmed one-to-one, but every stillbirth row here is expected to have a match there.
- **`markoer_accreta`:** A flag only - the actual SKS-coded placenta accreta finding is in a separate dataset, mfraccre (see mfraccre.yaml), joined via FK_MFR.
- **`markoer_anaestesi_til_operation`:** A flag only - the actual SKS-coded anaesthesia for an operation finding is in a separate dataset, mfranaes (see mfranaes.yaml), joined via FK_MFR.
- **`markoer_andre_foedselskomplikati`:** A flag only - the actual SKS-coded other birth complications not covered by the more specific sub-cuts finding is in a separate dataset, mfrakmpl (see mfrakmpl.yaml), joined via FK_MFR.
- **`markoer_b_misdannelse`:** A flag only - the actual SKS-coded congenital malformation finding is in a separate dataset, mfrmisda (see mfrmisda.yaml), joined via FK_MFR.
- **`markoer_cardiomyopati`:** A flag only - the actual SKS-coded cardiomyopathy finding is in a separate dataset, mfrcardi (see mfrcardi.yaml), joined via FK_MFR.
- **`markoer_graviditetskomplikatio`:** A flag only - the actual SKS-coded pregnancy complications finding is in a separate dataset, mfrgkmpl (see mfrgkmpl.yaml), joined via FK_MFR.
- **`markoer_haemoperitoneum`:** A flag only - the actual SKS-coded haemoperitoneum finding is in a separate dataset, mfrhaemo (see mfrhaemo.yaml), joined via FK_MFR.
- **`markoer_hjemmefoedsel_beregnet`:** A flag only - the actual SKS-coded home births finding is in a separate dataset, mfrhjmfo (see mfrhjmfo.yaml), joined via FK_MFR. DST's variable list gives this column from 1997, but Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) gives it as valid from 2000. Check the first years in your own data before relying on them.
- **`markoer_igangsaettelse`:** A flag only - the actual SKS-coded labour induction finding is in a separate dataset, mfrigang (see mfrigang.yaml), joined via FK_MFR.
- **`markoer_infektioner`:** A flag only - the actual SKS-coded infections finding is in a separate dataset, mfrinfek (see mfrinfek.yaml), joined via FK_MFR.
- **`markoer_kejsersnit`:** A flag only - the actual SKS-coded caesarean section finding is in a separate dataset, mfrkjsnt (see mfrkjsnt.yaml), joined via FK_MFR.
- **`markoer_medicinske_sygdomme`:** A flag only - the actual SKS-coded medical conditions finding is in a separate dataset, mfrmedsg (see mfrmedsg.yaml), joined via FK_MFR.
- **`markoer_navlesnorsblod_analyse`:** A flag only - the actual SKS-coded umbilical cord blood analysis, with the actual pH/base excess values finding is in a separate dataset, mfrnvlan (see mfrnvlan.yaml), joined via FK_MFR. Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) gives this as valid from 1998, while DST's variable list starts it in 2003, so DST may not deliver the years 1998-2002.
- **`markoer_perineal_bristning`:** A flag only - the actual SKS-coded perineal tears finding is in a separate dataset, mfrbrist (see mfrbrist.yaml), joined via FK_MFR.
- **`markoer_post_partum_bloedning`:** A flag only - the actual SKS-coded postpartum blood loss, with the actual measured amount finding is in a separate dataset, mfrblodm (see mfrblodm.yaml), joined via FK_MFR. DST's variable list gives this column from 1997, but Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) gives it as valid from 2009. Check the first years in your own data before relying on them. The gap is twelve years, so a postpartum haemorrhage series built on this flag before 2009 is unlikely to mean what it means from 2009.
- **`markoer_ruptur`:** A flag only - the actual SKS-coded rupture finding is in a separate dataset, mfrruptu (see mfrruptu.yaml), joined via FK_MFR.
- **`markoer_smertelindring`:** A flag only - the actual SKS-coded pain relief finding is in a separate dataset, mfrsmlin (see mfrsmlin.yaml), joined via FK_MFR.
- **`markoer_ultralyd`:** A flag only - the actual SKS-coded ultrasound finding is in a separate dataset, mfrultra (see mfrultra.yaml), joined via FK_MFR.
- **`markoer_vestimulation`:** A flag only - the actual SKS-coded labour stimulation finding is in a separate dataset, mfrvestm (see mfrvestm.yaml), joined via FK_MFR.
- **`markoer_ydre_vending`:** A flag only - the actual SKS-coded external cephalic version finding is in a separate dataset, mfryvend (see mfryvend.yaml), joined via FK_MFR.
- **`respiratorbeh_neonatalafdeling`:** DST's variable list gives this column from 2000, but Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) gives it as valid from 2001. Check the first years in your own data before relying on them.
- **`skalp_blodproeve`:** Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) gives this as valid from 1997, while DST's variable list starts it in 2000, so DST may not deliver the years 1997-1999.
- **`tidligerefoedsler_i_danmark`:** In Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) the descriptions of this column and tidligerekejsersnit_i_danmark are swapped (this one is described as previous caesarean sections). The labels here follow the column names. Check which is which in your data: previous caesareans cannot outnumber previous births.
- **`tidligerekejsersnit_i_danmark`:** In Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) the descriptions of this column and tidligerefoedsler_i_danmark are swapped (this one is described as previous births). The labels here follow the column names. Check which is which in your data: previous caesareans cannot outnumber previous births.

</details>

*No published source gives a data type for 91 of these 91 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `cpr_barn`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

**Worth knowing:**

- **`bmi_moder`:** Only from 2003, unlike most of the register, which starts in 1997.
- **`cpr_barn`:** The child's CPR number, which is how the register joins to every other register about the child.
- **`cpr_moder`:** The mother's CPR number. There is a row per child, so a mother of three appears three times.
- **`gestationsalder_dage`:** Gestational age in days, not weeks. Divide by 7 for the usual clinical scale.
- **`paritet`:** Parity. Counts previous births, so it is not the same as the number of children currently alive.
- **`vaegt_moder`:** Sundhedsdatastyrelsen's documentation of the birth register for 1997-2018 (Dokumentation_Foedselsregisteret_1997_2018.xlsx) gives the unit as grams, but for an adult's weight that may be an error in the documentation; check the range in your data before converting.
