<!-- Generated from schema/registers/faik.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |  |
| **`familie_id`** | character | join key | Household key |  |
| `famaekvivadisp_13` | numeric | value | Household-equivalised disposable income |  |
| `year` | integer | date | Register year |  |
| `famdisponibel_13` | numeric | value | Disponibel indkomst |  |
| `famindkomstialt_13` | numeric | value | Indkomst i alt, før skatter mv. |  |
| `famsociogrup_13` | character | code | Familiens socioøkonomiske gruppe Def13 | 1993 to 2024 |
| `famtype` | character | code | Familietype |  |

<details>
<summary>All other columns (79)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `famaekvivadisp` | numeric | value | Ækvivaleret disponibel indkomst for familien | 1990 to 2012 |
| `famaekvivaindknetto` | numeric | value | Ækvivaleret samlet indkomst med nettorenter | 1990 to 2012 |
| `famaktieindk` | numeric | value | Aktieindkomster | 1990 to 2009 |
| `famandenpension` | numeric | value | Andre pensionsudbetalinger til familien |  |
| `famandoverforsel` | numeric | value | Andre overførsler til familien | 1990 to 2012 |
| `famantalfskattepligtige` | numeric | value | Antal fuldt skattepligtige voksne i familien |  |
| `famarbejdsloesp` | numeric | value | Arbejdsløshedsdagpenge og uddannelsesgodtgørelse |  |
| `famarbmabidrag` | numeric | value | Arbejdsmarkedsbidrag mv |  |
| `famboernetilskud` | numeric | value | Børnetilskud og familieydelser til familien |  |
| `famboligform` | character | code | Familiens boligform | 2000 to 2024 |
| `famboligstoette` | numeric | value | Boligstøtte udbetalt til familien |  |
| `famboligtype` | character | code | Familiens boligtype | 2000 to 2024 |
| `fambruttoindk` | numeric | value | Bruttoindkomst for familien | 1990 to 2009 |
| `famdagpenge_kontant_13` | numeric | value | Familiens samlede dagpenge og kontanthjælp |  |
| `famdisponibel` | numeric | value | Disponibel indkomst for familien | 1990 to 2012 |
| `famefterloen` | numeric | value | Efterløn |  |
| `famejdskat_ejerbolig` | numeric | value | Ejendomsskat for boligejere | 2010 to 2024 |
| `famejdskat_lejerbolig` | numeric | value | Ejendomsskat for lejere | 2010 to 2024 |
| `famejendomsvurdering` | numeric | value | Kontant ejendomsværdi |  |
| `famerhvervsindk` | numeric | value | Erhvervsindkomst for familien | 1990 to 2012 |
| `famerhvervsindk_13` | numeric | value | Erhvervsindkomst, løn og nettooverskud |  |
| `famfolkefortid_13` | numeric | value | Folke- og førtidspension i familien |  |
| `famformrest_ny05` | numeric | value | Familiens nettorestformue ultimo året |  |
| `famformueaktiver` | numeric | value | Familiens samlede aktiver |  |
| `famformueindk` | numeric | value | Formueindkomst i alt for familien | 1990 to 2012 |
| `famformueindk_brutto` | numeric | value | Formueindkomst, brutto i familien |  |
| `famfradragialt` | numeric | value | Samlet beregnet fradrag for familien | 1990 to 2012 |
| `famfrynsegoder` | numeric | value | Skattemæssig værdi af frynsegoderne | 1993 to 2009 |
| `famgaeldialt` | numeric | value | Familiens passiver |  |
| `famgron_check` | numeric | value | Grøn check | 2010 to 2024 |
| `famhoejstudda` | character | code | Højeste uddannelse for de voksne | 2000 to 2024 |
| `famhonny` | numeric | value | AMB. pligtige honorarer |  |
| `famindkomstialt` | numeric | value | Familieindkomst i alt før skat | 1990 to 2012 |
| `famkontanthjaelp` | numeric | value | Kontanthjælp for familien | 1990 to 2009 |
| `famkontanthjaelp_13` | numeric | value | Kontanthjælp i familien |  |
| `famlejevaerdi` | numeric | value | Beregnet lejeværdi af egen bolig | 1990 to 2012 |
| `famlejev_egen_bolig` | numeric | value | Beregnet lejeværdi af egen bolig |  |
| `famloenmv` | numeric | value | Lønindkomst i alt i familien | 1990 to 2012 |
| `famloenmv_13` | numeric | value | Lønindkomst i alt i familien |  |
| `fammidlertidyd` | numeric | value | Midlertidige overførselsindkomster | 1990 to 2012 |
| `famoevrigformue` | numeric | value | Anden formueindkomst for familien | 1990 to 2009 |
| `famoevrigformue_13` | numeric | value | Øvrige formueindkomster i familien |  |
| `famoffpens_eftlon_13` | numeric | value | Offentlige pensioner i familien |  |
| `famoff_overforsel_13` | numeric | value | Familiens offentlige overførsler |  |
| `famorlovsydelse` | numeric | value | Orlovsydelser udbetalt til familien | 1994 to 2009 |
| `famoverfoerindk` | numeric | value | Familiens samlede overførselsindkomster | 1990 to 2012 |
| `famovergangyd` | numeric | value | Familiens samlede overgangsydelse | 1994 to 2006 |
| `famovrig_dagpenge_akas_13` | numeric | value | Øvrige dagpenge fra A-kasser |  |
| `famovrig_kontanthjalp_13` | numeric | value | Aktiverings-, ledigheds- og revalideringsydelse |  |
| `famovrig_overforsel_13` | numeric | value | Øvrige overførselsindkomster i familien |  |
| `fampensionatp` | numeric | value | Pensionsudbetaling fra ATP for familien |  |
| `fampensionialt` | numeric | value | Pensioner i alt for familien | 1990 to 2012 |
| `fampensoffentlig` | numeric | value | Folke- og førtidspension for familien | 1990 to 2009 |
| `fampenstjeneste` | numeric | value | Tjenestemandspension for familien |  |
| `famprivat_pension_13` | numeric | value | Private pensioner i familien |  |
| `famrenteindk` | numeric | value | Samlede renteindtægter fra Danmark | 1990 to 2009 |
| `famrenteindk_13` | numeric | value | Familiens samlede skattepligtige renteindtægter |  |
| `famrenteudgifter` | numeric | value | Samlede fradragsberettigede renteudgifter | 1990 to 2012 |
| `famrenteudgifter_13` | numeric | value | Renteudgifter |  |
| `famrestbistandsyd` | numeric | value | Andre ydelser fra kommuner og A-kasser | 1990 to 2009 |
| `famrestindk` | numeric | value | Diverse indkomster ikke klassificeret | 1990 to 2012 |
| `famrestindk_13` | numeric | value | Anden personlig indkomst i familien |  |
| `famsamletindk` | numeric | value | Samlet indkomst for familien | 1990 to 2009 |
| `famskatfriyd` | numeric | value | Skattefrie indkomster i familien | 1990 to 2012 |
| `famskatmvialt` | numeric | value | Skat og arbejdsmarkedsbidrag betalt | 1990 to 2012 |
| `famskatmvialt_13` | numeric | value | Skat, arbejdsmarkedsbidrag og særlig pension |  |
| `famskatpligtindk` | numeric | value | Skattepligtig indkomst for familien |  |
| `famskattot` | numeric | value | Samlet indkomstskat betalt af familien | 1990 to 2009 |
| `famskattot_13` | numeric | value | Samlet personlig slutskat for en skatteyder |  |
| `famsociogrup` | character | code | Familiens socioøkonomiske gruppe | 1994 to 2009 |
| `famsu` | numeric | value | Stipendier fra Statens Uddannelsesstøtte - SU |  |
| `famsumindknettorent` | numeric | value | Samlet indkomst med nettorenter | 1990 to 2012 |
| `famsyg_barsel_13` | numeric | value | Familiens syge- og barselsdagpenge |  |
| `famtransportfradrag` | numeric | value | Samlet befordringsfradrag i familien | 1990 to 2009 |
| `famunderhbidrag` | numeric | value | Underholdsbidrag betalt af familien |  |
| `famvirkordind` | numeric | value | Beløb indsat i virksomhedsordningerne |  |
| `famvirkoverskud` | numeric | value | Nettooverskud af selvstændig virksomhed | 1990 to 2009 |
| `famvirkoverskud_13` | numeric | value | Familiens samlede overskud af selvstændig virksomhed |  |
| `version` | character | code | Moduldata version |  |

</details>

**Join key:** `familie_id`.

**Joins to other registers:**

- `familie_id` joins to **BEF** (one-to-many).

**How it is computed:**

- `FAMAEKVIVADISP_13 = FAMDISPONIBEL_13 / (1 + (0.5 * (number of people over 14 in the family - 1)) + (0.3 * number of people under 15 in the family))`

**Worth knowing:**

- **`pnr`:** Not in DST's variable list for FAIK, which documents the register as keyed on the household. Where it is present, the household's row is repeated once per family member, so joining on familie_id alone multiplies rows.
- **`familie_id`:** There is no person identifier here. Fetch familie_id from BEF for the relevant year, then join on it.
- **`famaekvivadisp_13`:** This is the family's disposable income divided by an equivalence factor, so that families of different sizes can be compared. The factor counts the first adult as 1.0, each further person over 14 as 0.5, and each child under 15 as 0.3: a couple with two young children comes to 1 + 0.5 + 0.6 = 2.1, so a family income of 420,000 is recorded as 200,000 for each of the four. `FAMDISPONIBEL_13` is the same money before that division, and `FAMAEKVIVAINDKNETTO` is a different income concept (total income with net interest), so check which one your analysis plan means. The `_13` suffix marks the definition that replaced the older variables from 2013: DST states that FAMDISPONIBEL was discontinued in 2013 and replaced by FAMDISPONIBEL_13. A study spanning 2013 has to know which side of that change it is on. DST's year ranges settle the relationship with the sister column FAMAEKVIVADISP, which has no _13: the old one runs 1990-2012, this one runs 1987-2024. The _13 definition was applied backwards as well as forwards, so it is not a newer variable covering later years only. A study spanning the 2013 changeover should use _13 for the whole period rather than splicing the two, which would mix two definitions in one series.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
