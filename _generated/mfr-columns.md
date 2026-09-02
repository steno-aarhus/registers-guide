<!-- Generated from schema/registers/mfr.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `alder_moder` | numeric | value | ALDER_MODER |  |
| `bmi_moder` | numeric | value | BMI_MODER | 2003 to 2018 |
| **`cpr_barn`** | character | join key | CPR_BARN |  |
| **`cpr_moder`** | character | join key | CPR_MODER |  |
| `flerfoldsfoedsel_beregnet` | character | code | FLERFOLDSFOEDSEL_BEREGNET |  |
| `gestationsalder_dage` | numeric | value | GESTATIONSALDER_DAGE |  |
| `hoejde_moder` | numeric | value | HOEJDE_MODER | 2003 to 2018 |
| `laengde_barn` | character | code | LAENGDE_BARN |  |
| `paritet` | numeric | value | PARITET |  |
| `rygerstatus_moder` | character | code | RYGERSTATUS_MODER |  |
| `vaegt_barn` | numeric | value | VAEGT_BARN |  |
| `vaegt_moder` | numeric | value | VAEGT_MODER | 2003 to 2018 |

<details>
<summary>All other columns (79)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `abdominalomfang` | numeric | value | ABDOMINALOMFANG |  |
| `abruptio` | character | code | ABRUPTIO |  |
| `afdeling` | character | code | AFDELING |  |
| `alderveddoed_dage_barn` | numeric | value | ALDERVEDDOED_DAGE_BARN |  |
| `alder_fader` | numeric | value | ALDER_FADER |  |
| `amnioinfusion` | character | code | AMNIOINFUSION | 1998 to 2018 |
| `amnitomi_under_foedsel_hsp` | character | code | AMNITOMI_UNDER_FOEDSEL_HSP |  |
| `andensutur` | character | code | ANDENSUTUR |  |
| `apgarscore_efter5minutter` | numeric | value | APGARSCORE_EFTER5MINUTTER |  |
| `barnslevendenr_flerfoldfoedsel` | numeric | value | BARNSLEVENDENR_FLERFOLDFOEDSEL |  |
| `barnsnummer_flerfoldsfoedsel` | numeric | value | BARNSNUMMER_FLERFOLDSFOEDSEL |  |
| `besoeghosjordemoder` | character | code | BESOEGHOSJORDEMODER |  |
| `besoeghoslaege` | character | code | BESOEGHOSLAEGE |  |
| `besoeghosspeciallaege` | character | code | BESOEGHOSSPECIALLAEGE |  |
| `bopaelskommune_moder` | character | code | BOPAELSKOMMUNE_MODER |  |
| `cpapbeh_neonatalafdeling` | character | code | CPAPBEH_NEONATALAFDELING | 2000 to 2018 |
| **`cpr_fader`** | character | join key | CPR_FADER |  |
| `disproportio` | character | code | DISPROPORTIO |  |
| `doedsdato_barn` | date | date | DOEDSDATO_BARN |  |
| `doedsdato_moder` | date | date | DOEDSDATO_MODER |  |
| `epiduralblokade` | character | code | EPIDURALBLOKADE | 2000 to 2018 |
| `episiotomi` | character | code | EPISIOTOMI |  |
| `fastsiddendemoderkage` | character | code | FASTSIDDENDEMODERKAGE |  |
| `flerfoldsgraviditet` | character | code | FLERFOLDSGRAVIDITET |  |
| `foedested` | character | code | FOEDESTED |  |
| `foedselsaar` | character | code | FOEDSELSAAR |  |
| `foedselsdato` | date | date | FOEDSELSDATO |  |
| `foedselsdiagnose_moder` | character | code | FOEDSELSDIAGNOSE_MODER |  |
| `foedselsloebenummer` | numeric | value |  |  |
| `foedselstime` | character | code | FOEDSELSTIME |  |
| `fosterpraesentation` | character | code | FOSTERPRAESENTATION |  |
| `hjemmebesoeg` | character | code | HJEMMEBESOEG | 2003 to 2018 |
| `hovedomfang` | numeric | value | HOVEDOMFANG |  |
| `intrauterin_asfyxi` | character | code | INTRAUTERIN_ASFYXI |  |
| `intrauterin_palpation` | character | code | INTRAUTERIN_PALPATION |  |
| `kejsersnit_modersoenske` | character | code | KEJSERSNIT_MODERSOENSKE | 2002 to 2018 |
| `koen_barn` | character | code | KOEN_BARN |  |
| `levende_eller_doedfoedt` | character | code | LEVENDE_ELLER_DOEDFOEDT |  |
| `markoer_accreta` | character | code | MARKOER_ACCRETA |  |
| `markoer_anaestesi_til_operation` | character | code | MARKOER_ANAESTESI_TIL_OPERATION | 2000 to 2018 |
| `markoer_andre_foedselskomplikati` | character | code |  |  |
| `markoer_b_misdannelse` | character | code | MARKOER_B_MISDANNELSE |  |
| `markoer_cardiomyopati` | character | code | MARKOER_CARDIOMYOPATI |  |
| `markoer_graviditetskomplikatio` | character | code | MARKOER_GRAVIDITETSKOMPLIKATIO |  |
| `markoer_haemoperitoneum` | character | code | MARKOER_HAEMOPERITONEUM |  |
| `markoer_hjemmefoedsel_beregnet` | character | code | MARKOER_HJEMMEFOEDSEL_BEREGNET |  |
| `markoer_igangsaettelse` | character | code | MARKOER_IGANGSAETTELSE |  |
| `markoer_infektioner` | character | code | MARKOER_INFEKTIONER |  |
| `markoer_kejsersnit` | character | code | MARKOER_KEJSERSNIT |  |
| `markoer_medicinske_sygdomme` | character | code | MARKOER_MEDICINSKE_SYGDOMME |  |
| `markoer_navlesnorsblod_analyse` | character | code | MARKOER_NAVLESNORSBLOD_ANALYSE | 2003 to 2018 |
| `markoer_perineal_bristning` | character | code | MARKOER_PERINEAL_BRISTNING |  |
| `markoer_post_partum_bloedning` | character | code | MARKOER_POST_PARTUM_BLOEDNING |  |
| `markoer_ruptur` | character | code | MARKOER_RUPTUR |  |
| `markoer_smertelindring` | character | code | MARKOER_SMERTELINDRING | 1999 to 2018 |
| `markoer_ultralyd` | character | code | MARKOER_ULTRALYD | 1999 to 2018 |
| `markoer_vestimulation` | character | code | MARKOER_VESTIMULATION | 1999 to 2018 |
| `markoer_ydre_vending` | character | code | MARKOER_YDRE_VENDING |  |
| `navlesnorsfremfald` | character | code | NAVLESNORSFREMFALD |  |
| `pk_mfr` | character | code | PK_MFR |  |
| `placentavaegt` | numeric | value | PLACENTAVAEGT |  |
| `polyhydramnios` | character | code | POLYHYDRAMNIOS |  |
| `pprom` | character | code | PPROM |  |
| `praevia` | character | code | PRAEVIA |  |
| `prom` | character | code | PROM |  |
| `respiratorbeh_neonatalafdeling` | character | code | RESPIRATORBEH_NEONATALAFDELING | 2000 to 2018 |
| `sengedage_beregnet_barn` | numeric | value | SENGEDAGE_BEREGNET_BARN |  |
| `sengedage_beregnet_moder` | numeric | value | SENGEDAGE_BEREGNET_MODER |  |
| `sengedage_neonatalafdeling_barn` | numeric | value | SENGEDAGE_NEONATALAFDELING_BARN |  |
| `sepsis_barn` | character | code | SEPSIS_BARN |  |
| `skalp_blodproeve` | character | code | SKALP_BLODPROEVE | 2000 to 2018 |
| `suturcollum` | character | code | SUTURCOLLUM |  |
| `sygehus` | character | code | SYGEHUS |  |
| `tang_forloesning` | character | code | TANG_FORLOESNING |  |
| `tegn_paa_asphyxi` | character | code | TEGN_PAA_ASPHYXI |  |
| `tidligerefoedsler_i_danmark` | character | code | TIDLIGEREFOEDSLER_I_DANMARK |  |
| `tidligerekejsersnit_i_danmark` | character | code | TIDLIGEREKEJSERSNIT_I_DANMARK |  |
| `tidligerespontaneaborter` | character | code | TIDLIGERESPONTANEABORTER |  |
| `vakuumekstraktion` | character | code | VAKUUMEKSTRAKTION |  |

</details>

*The Type column is read off the column name for 91 of these 91 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `cpr_barn`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

**Worth knowing:**

- **`bmi_moder`:** Only from 2003, unlike most of the register, which starts in 1997.
- **`cpr_barn`:** The child's CPR number, which is how the register joins to every other register about the child.
- **`cpr_moder`:** The mother's CPR number. There is a row per child, so a mother of three appears three times.
- **`gestationsalder_dage`:** Gestational age in days, not weeks. Divide by 7 for the usual clinical scale.
- **`paritet`:** Parity. Counts previous births, so it is not the same as the number of children currently alive.
