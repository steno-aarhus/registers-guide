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

</details>

*The Type column is read off the column name for 67 of these 87 columns: no published source gives a data type for them. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `familie_id`.

**Joins to other registers:**

- `familie_id` joins to **BEF** (one-to-many).

**How it is computed:**

**`famaekvivadisp_13`**

```
FAMAEKVIVADISP_13 = FAMDISPONIBEL_13 / (1 + (0.5 * (number of people over 14 in the family - 1)) + (0.3 * number of people under 15 in the family))
```

**Worth knowing:**

- **`pnr`:** Not in DST's variable list for FAIK, which documents the register as keyed on the household. Where it is present, the household's row is repeated once per family member, so joining on familie_id alone multiplies rows.
- **`familie_id`:** There is no person identifier here. Fetch familie_id from BEF for the relevant year, then join on it.
- **`famaekvivadisp_13`:** This is the family's disposable income divided by an equivalence factor, so that families of different sizes can be compared. The factor counts the first adult as 1.0, each further person over 14 as 0.5, and each child under 15 as 0.3: a couple with two young children comes to 1 + 0.5 + 0.6 = 2.1, so a family income of 420,000 is recorded as 200,000 for each of the four. `FAMDISPONIBEL_13` is the same money before that division, and `FAMAEKVIVAINDKNETTO` is a different income concept (total income with net interest), so check which one your analysis plan means. The `_13` suffix marks the definition that replaced the older variables from 2013: DST states that FAMDISPONIBEL was discontinued in 2013 and replaced by FAMDISPONIBEL_13. A study spanning 2013 has to know which side of that change it is on. DST's year ranges settle the relationship with the sister column FAMAEKVIVADISP, which has no _13: the old one runs 1990-2012, this one runs 1987-2024. The _13 definition was applied backwards as well as forwards, so it is not a newer variable covering later years only. A study spanning the 2013 changeover should use _13 for the whole period rather than splicing the two, which would mix two definitions in one series.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
