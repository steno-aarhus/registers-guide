<!-- Generated from schema/registers/faik.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |  |
| **`familie_id`** | character | join key | Household key |  |
| `famaekvivadisp_13` | numeric | value | Household-equivalised disposable income |  |
| `year` | integer | date | Register year |  |
| `famdisponibel_13` | numeric | value | Disposable income |  |
| `famindkomstialt_13` | numeric | value | Total income before taxes |  |
| `famsociogrup_13` | numeric | code | Socioeconomic group, 2013 definition | 1993 to 2024 |
| `famtype` | numeric | code | Family type |  |

<details>
<summary>All other columns (79)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `famaekvivadisp` | numeric | value | Equivalised disposable family income | 1990 to 2012 |
| `famaekvivaindknetto` | numeric | value | Equivalised total income including net interest | 1990 to 2012 |
| `famaktieindk` | numeric | value | Share income | 1990 to 2009 |
| `famandenpension` | numeric | value | Other pension payments to the family |  |
| `famandoverforsel` | numeric | value | Other transfers to the family | 1990 to 2012 |
| `famantalfskattepligtige` | numeric | value | Number of fully taxable adults in the family |  |
| `famarbejdsloesp` | numeric | value | Unemployment benefit and training allowance |  |
| `famarbmabidrag` | numeric | value | Labour market contributions |  |
| `famboernetilskud` | numeric | value | Child benefit and family allowances |  |
| `famboligform` | numeric | code | Housing tenure | 2000 to 2024 |
| `famboligstoette` | numeric | value | Housing benefit paid to the family |  |
| `famboligtype` | numeric | code | Dwelling type | 2000 to 2024 |
| `fambruttoindk` | numeric | value | Gross family income | 1990 to 2009 |
| `famdagpenge_kontant_13` | numeric | value | Total benefits and social assistance |  |
| `famdisponibel` | numeric | value | Disposable family income | 1990 to 2012 |
| `famefterloen` | numeric | value | Early retirement pay |  |
| `famejdskat_ejerbolig` | numeric | value | Property tax, homeowners | 2010 to 2024 |
| `famejdskat_lejerbolig` | numeric | value | Property tax, tenants | 2010 to 2024 |
| `famejendomsvurdering` | numeric | value | Cash property value |  |
| `famerhvervsindk` | numeric | value | Business income for the family | 1990 to 2012 |
| `famerhvervsindk_13` | numeric | value | Business income: wages and net profit |  |
| `famfolkefortid_13` | numeric | value | State and early retirement pension in the family |  |
| `famformrest_ny05` | numeric | value | Net residual wealth at year end |  |
| `famformueaktiver` | numeric | value | Total assets |  |
| `famformueindk` | numeric | value | Total capital income for the family | 1990 to 2012 |
| `famformueindk_brutto` | numeric | value | Capital income, gross |  |
| `famfradragialt` | numeric | value | Total calculated deductions | 1990 to 2012 |
| `famfrynsegoder` | numeric | value | Taxable value of fringe benefits | 1993 to 2009 |
| `famgaeldialt` | numeric | value | Liabilities |  |
| `famgron_check` | numeric | value | Green check | 2010 to 2024 |
| `famhoejstudda` | character | code | Highest education among the adults | 2000 to 2024 |
| `famhonny` | numeric | value | Fees liable to labour market contributions |  |
| `famindkomstialt` | numeric | value | Total family income before tax | 1990 to 2012 |
| `famkontanthjaelp` | numeric | value | Social assistance for the family | 1990 to 2009 |
| `famkontanthjaelp_13` | numeric | value | Social assistance in the family |  |
| `famlejevaerdi` | numeric | value | Imputed rental value of owner-occupied dwelling | 1990 to 2012 |
| `famlejev_egen_bolig` | numeric | value | Imputed rental value of owner-occupied dwelling |  |
| `famloenmv` | numeric | value | Total wage income in the family | 1990 to 2012 |
| `famloenmv_13` | numeric | value | Total wage income in the family |  |
| `fammidlertidyd` | numeric | value | Temporary transfer incomes | 1990 to 2012 |
| `famoevrigformue` | numeric | value | Other capital income for the family | 1990 to 2009 |
| `famoevrigformue_13` | numeric | value | Other capital incomes in the family |  |
| `famoffpens_eftlon_13` | numeric | value | Public pensions in the family |  |
| `famoff_overforsel_13` | numeric | value | Public transfers to the family |  |
| `famorlovsydelse` | numeric | value | Leave benefits paid to the family | 1994 to 2009 |
| `famoverfoerindk` | numeric | value | Total transfer incomes | 1990 to 2012 |
| `famovergangyd` | numeric | value | Total transitional allowance | 1994 to 2006 |
| `famovrig_dagpenge_akas_13` | numeric | value | Other benefits from unemployment funds |  |
| `famovrig_kontanthjalp_13` | numeric | value | Activation, unemployment and rehabilitation allowance |  |
| `famovrig_overforsel_13` | numeric | value | Other transfer incomes in the family |  |
| `fampensionatp` | numeric | value | ATP pension payments |  |
| `fampensionialt` | numeric | value | Total pensions for the family | 1990 to 2012 |
| `fampensoffentlig` | numeric | value | State and early retirement pension | 1990 to 2009 |
| `fampenstjeneste` | numeric | value | Civil servant pension |  |
| `famprivat_pension_13` | numeric | value | Private pensions in the family |  |
| `famrenteindk` | numeric | value | Total interest income from Denmark | 1990 to 2009 |
| `famrenteindk_13` | numeric | value | Total taxable interest income |  |
| `famrenteudgifter` | numeric | value | Total deductible interest expenses | 1990 to 2012 |
| `famrenteudgifter_13` | numeric | value | Interest expenses |  |
| `famrestbistandsyd` | numeric | value | Other benefits from municipalities and unemployment funds | 1990 to 2009 |
| `famrestindk` | numeric | value | Miscellaneous unclassified income | 1990 to 2012 |
| `famrestindk_13` | numeric | value | Other personal income in the family |  |
| `famsamletindk` | numeric | value | Total income for the family | 1990 to 2009 |
| `famskatfriyd` | numeric | value | Tax-free incomes in the family | 1990 to 2012 |
| `famskatmvialt` | numeric | value | Tax and labour market contributions paid | 1990 to 2012 |
| `famskatmvialt_13` | numeric | value | Tax, labour market contributions and special pension |  |
| `famskatpligtindk` | numeric | value | Taxable income for the family |  |
| `famskattot` | numeric | value | Total income tax paid | 1990 to 2009 |
| `famskattot_13` | numeric | value | Total personal final tax |  |
| `famsociogrup` | numeric | code | Socioeconomic group | 1994 to 2009 |
| `famsu` | numeric | value | State education grants (SU) |  |
| `famsumindknettorent` | numeric | value | Total income including net interest | 1990 to 2012 |
| `famsyg_barsel_13` | numeric | value | Sickness and maternity benefits |  |
| `famtransportfradrag` | numeric | value | Total commuting deduction | 1990 to 2009 |
| `famunderhbidrag` | numeric | value | Maintenance payments made by the family |  |
| `famvirkordind` | numeric | value | Amounts placed in the business tax schemes |  |
| `famvirkoverskud` | numeric | value | Net profit from self-employment | 1990 to 2009 |
| `famvirkoverskud_13` | numeric | value | Total profit from self-employment |  |
| `version` | numeric | code | Module data version |  |

- **`famaekvivadisp`:** The same weighting scheme as FAMAEKVIVADISP_13 below, just algebraically rearranged on the source page: the first adult over 14 counts as 1.0, each further person over 14 as 0.5, and each child under 15 as 0.3. All persons belonging to the same family on 31 December of the income year (same E-familienummer), including resident children under 25, are assigned the family's equivalised income. `FAMDISPONIBEL` is the same money before that division.
- **`famandoverforsel`:** DST flags a data break both within this variable and across variables, and discontinued it in 2013. It sums housing benefit, child benefit and student grants, each of which changed rules over the period (child benefit rates, for example), so year-to-year changes can be rule changes rather than real ones.
- **`famdisponibel`:** DST flags a data break within this variable. It was discontinued in 2013 and replaced by famdisponibel_13, which runs 1987-2024 on one definition; use that for any time series. The main changes in this old series: labour market contribution introduced in 1994, imputed rental value of owner-occupied homes calculated differently from 1994 and again from 2007, and tax-free social assistance and heating aid included from 2002.
- **`famerhvervsindk`:** DST flags a data break both within this variable and across variables. It was discontinued in 2013 and replaced by famerhvervsindk_13, which also includes business interest, so the two are not the same quantity. In this old series, fees subject to labour market contribution are included from 1994, and wages of foreign researchers under the researcher tax scheme are included only in 2002-2003 and from 2008.
- **`famformueindk`:** DST flags a data break within this variable. It was discontinued in 2013 and replaced by famformueindk_brutto, which leaves out the imputed rental value of the family's own home, so the two are not the same quantity. Changes in this old series: share income taxed separately from 1991, rental income from letting a holiday home or the family's home included from 1993, the rental value rule changed in 1994, and gains from selling property included from 1996.
- **`famfradragialt`:** DST flags a data break within this variable, because the deductions it sums follow the tax rules of each year. For example, the deduction for changing workplaces moved to famtransportfradrag in 1994, early-retirement contributions entered in 1999 and the employment deduction was introduced in 2004.
- **`famindkomstialt`:** DST flags a data break within this variable. It was discontinued in 2013 and replaced by famindkomstialt_13; use that for any time series. Changes in this old series include: rehabilitation benefit made taxable (and so larger) from October 1990, share income not always included in 1991-2000, and wages of people under the researcher tax scheme left out in 1992-2001 and 2004-2007, partly included in 2002-2003 and fully included from 2008.
- **`famlejevaerdi`:** DST flags a data break both within this variable and across variables, and discontinued it in 2013; famlejev_egen_bolig replaces it. The rule changed in 1994: until 1993 every home and holiday home a person owned counted, and from 1994 at most one home and one holiday home, prorated when owned for part of the year. The underlying calculation changed again in 2007.
- **`famloenmv`:** DST flags a data break both within this variable and across variables, and discontinued it in 2013 (famloenmv_13 is the current series). Group life insurance through an employer pension is included from 1993 (before that it sits in famrestindk), and from 1994 wages come mainly from the final tax assessment rather than from employers' information slips.
- **`fammidlertidyd`:** DST flags a data break both within this variable and across variables, and discontinued it in 2013. Rehabilitation benefit was made taxable (and so larger) from October 1990, and leave benefits were introduced in 1992 (in famrestindk for 1992-1993) and ended in 2011.
- **`famoverfoerindk`:** DST flags a data break both within this variable and across variables, and discontinued it in 2013. It sums pensions, temporary benefits and other transfers, so it inherits every change in those: for example rehabilitation benefit made taxable from October 1990 and civil-service pensions included only from 1991.
- **`fampensionialt`:** DST flags a data break both within this variable and across variables, and discontinued it in 2013. Civil-service, labour-market and private pensions are formed for the first time in 1991 (before that they sit in famrestindk). In 2008 flex benefit is included here but not in famefterloen, so adding up the sub-variables for 2008 misses that amount.
- **`famrestindk`:** DST flags a data break both within this variable and across variables. It is a catch-all for income that fits nowhere else, and its content has shifted: several items (fringe benefits, group life insurance, foreign business profit) are only in it until 1993 or 1994 before moving to their own variables, and from 2002 it includes a tax-free part of child support that DST models rather than observes.
- **`famskatfriyd`:** DST flags a data break both within this variable and across variables. Most social assistance was made taxable in 1994 and left this variable, which drops as a result; the small part that stayed tax-free is not included in 1994-2001. The tax-free part of child support is included from 2002.
- **`famskatmvialt`:** DST flags a data break within this variable (famskatmvialt_13 is the current series). Taxes follow each year's tax system: labour market contribution is included from 1994, the special pension contribution in 1998-2003, county tax until 2006 and the health contribution from 2007, and wealth tax only before 1997.
- **`famsumindknettorent`:** DST flags a data break within this variable. It has the same changes as famindkomstialt: rehabilitation benefit made taxable from October 1990, share income not always included in 1991-2000, and wages under the researcher tax scheme left out in 1992-2001 and 2004-2007.
- **`famvirkoverskud`:** Discontinued in 2013 and replaced by famvirkoverskud_13, which is the net profit after interest in the business, so the two are not the same quantity.

</details>

*No published source gives a data type for 67 of these 87 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `familie_id`.

**Joins to other registers:**

- `familie_id` joins to **BEF** (one-to-many).

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `famboligform` | `1` Ejerbolig, `2` Lejebolig, `9` Uoplyst |
| `socio13` | `11` Selvstændige, `110` Selvstændige, `111` Selvstændige erhvervsdrivende med 10 eller flere ansatte, `112` Selvstændige erhvervsdrivende med 5-9 ansatte, `113` Selvstændige erhvervsdrivende med 1-4 ansatte, `114` Selvstændige erhvervsdrivende uden ansatte, `12` Medarbejdende ægtefælle, `120` Medarbejdende ægtefælle, `13` Lønmodtagere, `131` Lønmodtagere med ledelsesarbejde, `132` Lønmodtager i arbejde der forudsætter færdigheder på højeste niveau, `133` Lønmodtager i arbejde der forudsætter færdigheder på mellemniveau, `134` Lønmodtager i arbejde der forudsætter færdigheder på grundniveau, `135` Andre lønmodtagere, `139` Lønmodtager uden nærmere angivelse, `21` Arbejdsløs mindst halvdelen af året, `210` Arbejdsløse mindst halvdelen af året, `22` Sygedagpenge, orlov mv., `220` Modtager af sygedagpenge, uddannelsesgodtgørelse, orlovsydelser mv., `31` Uddannelsessøgende, `310` Under uddannelse, inkl. skoleelever på min. 15 år, `32` Pensionist/efterløn, `321` Førtidspensionister, `322` Folkepensionister, `323` Efterlønsmodtagere mv., `33` Kontanthjælp, `330` Kontanthjælpsmodtagere, `41` Andre, `410` Andre, `42` Børn, `420` Børn under 15 år, ultimo året |
| `famtype` | `0` Ingen oplysninger, `1` Ægtepar forskelligt køn, `2` Registreret partnerskab, `3` Samlevende par, `4` Samboende par, `6` Enlig mænd (herunder også ikke hjemmeboende børn), `7` Enlig kvinder (herunder også ikke hjemmeboende børn), `8` Ægtepar samme køn |

- **`socio13`:** Two codes are easy to misread. `410` is **Andre** (other), not unemployed: the unemployed are `210`. And `420` is **children under 15**, a known category rather than a missing value, so it appearing in an adult cohort means the index date is wrong rather than the data being incomplete.
- **`famtype`:** There is no code 5. The sequence runs 0 to 4 and then 6 to 8, which is easy to read as a missing value rather than as a code that never existed.

Where these values come from:

- **`famboligform`:** [DST TIMES documentation: famboligform](https://www.dst.dk/da/Statistik/dokumentation/Times/familieindkomst/famboligform).
- **`socio13`:** [DST's SOCIO classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/socio) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/007fb11c-4b35-4c7a-ad2d-f0a2cb0155c0csv_da)).
- **`famtype`:** [DST high-quality variable documentation: famtype](https://www.dst.dk/da/TilSalg/data-til-forskning/generelt-om-data/dokumentation-af-data/hoejkvalitetsvariable/familieindkomst/famtype).

</details>

**How it is computed:**

**`famaekvivadisp_13`**

```
FAMAEKVIVADISP_13 = FAMDISPONIBEL_13 / (1 + (0.5 * (number of people over 14 in the family - 1)) + (0.3 * number of people under 15 in the family))
```
**`famaekvivadisp`**

```
FAMAEKVIVADISP = FAMDISPONIBEL / (0.5 + (0.5 * number of people over 14 in the family) + (0.3 * number of people under 15 in the family))
```
**`famaekvivaindknetto`**

```
FAMAEKVIVAINDKNETTO = FAMSUMINDKNETTORENT / (0.5 + (0.5 * number of people over 14 in the family) + (0.3 * number of people under 15 in the family))
```
- `FAMANDOVERFORSEL = FAMOEVRIG_OVERFORSEL_13 + FAMGRON_CHECK (from 2010)`
**`famdagpenge_kontant_13`**

```
FAMDAGPENGE_KONTANT_13 = FAMARBLHUMV + FAMOVRIG_DAGPENGE_AKAS_13 + FAMKONTANTHJ_13 + FAMOVRIG_KONTANTHJALP_13 + FAMSYG_BARSEL_13
```
- `FAMDISPONIBEL = FAMSUMINDKNETTORENT - FAMSKATMVIALT - FAMUNDERHBIDRAG`
**`famdisponibel_13`**

```
FAMDISPONIBEL_13 = FAMINDKOMSTIALT_13 + FAMLEJEV_EGEN_BOLIG - FAMRENTEUDGIFTER_13 - FAMSKATMVIALT_13 - FAMUNDERHBIDRAG
```
- `FAMERHVERVSINDK = FAMLOENMV + FAMVIRKOVERSKUD`
- `FAMFORMUEINDK = FAMRENTEINDK + FAMOEVRIGFORMUE + FAMLEJEVAERDI`
**`famfradragialt`**

```
FAMFRADRAGIALT = FAMBRUTTOINDK - FAMSKATPLIGTIGINDK - FAMARBMABIDRAG (from 1994)
```
**`famindkomstialt_13`**

```
FAMINDKOMSTIALT_13 = FAMERHVERVSINDK_13 + FAMOFF_OVERFORSEL_13 + FAMPRIVAT_PENSION_13 + FAMRENTEINDK_13 + FAMOEVRIGFORMUE_13 + FAMRESTINDK_13
```
**`fammidlertidyd`**

```
FAMMIDLERTIDYD = FAMKONTANTHJAELP + FAMARBEJDSLOESP + FAMORLOVSYDELSE + FAMRESTBISTANDYD
```
**`fampensionialt`**

```
FAMPENSIONIALT = FAMPENSOFFENTLIG + FAMPENSIONATP + FAMEFTERLOEN + FAMOVERGANGYD (1994-2006) + FAMPENSTJENESTE (from 1991) + FAMANDENPENSION
```
**`famrestindk`**

```
FAMRESTINDK = FAMINDKOMSTIALT - FAMERHVERVSINDK - FAMOVERFOERINDK - FAMFORMUEINDK
```
- `FAMSKATMVIALT = FAMSKATTOT + FAMARBMABIDRAG`
**`famsumindknettorent`**

```
FAMSUMINDKNETTORENT = FAMINDKOMSTIALT + FAMLEJEVAERDI - FAMRENTEUDGIFTER
```

**Worth knowing:**

- **`pnr`:** Not in DST's variable list for FAIK, which documents the register as keyed on the household. Where it is present, the household's row is repeated once per family member, so joining on familie_id alone multiplies rows.
- **`familie_id`:** There is no person identifier here. Fetch familie_id from BEF for the relevant year, then join on it.
- **`famaekvivadisp_13`:** This is the family's disposable income divided by an equivalence factor, so that families of different sizes can be compared. The factor counts the first adult as 1.0, each further person over 14 as 0.5, and each child under 15 as 0.3: a couple with two young children comes to 1 + 0.5 + 0.6 = 2.1, so a family income of 420,000 is recorded as 200,000 for each of the four. `FAMDISPONIBEL_13` is the same money before that division, and `FAMAEKVIVAINDKNETTO` is a different income concept (total income with net interest), so check which one your analysis plan means. The `_13` suffix marks the definition that replaced the older variables from 2013: DST states that FAMDISPONIBEL was discontinued in 2013 and replaced by FAMDISPONIBEL_13. A study spanning 2013 has to know which side of that change it is on. DST's year ranges settle the relationship with the sister column FAMAEKVIVADISP, which has no _13: the old one runs 1990-2012, this one runs 1987-2024. The _13 definition was applied backwards as well as forwards, so it is not a newer variable covering later years only. A study spanning the 2013 changeover should use _13 for the whole period rather than splicing the two, which would mix two definitions in one series.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
