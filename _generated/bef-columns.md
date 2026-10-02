<!-- Generated from schema/registers/bef.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 1985 to 2026 |
| `koen` | numeric | code | Sex | 1985 to 2026 |
| `foed_dag` | date | date | Date of birth | 1985 to 2026 |
| **`familie_id`** | character | join key | Household key | 1985 to 2026 |
| `reg` | character | code | Region | 1985 to 2026 |
| `civst` | character | code | Marital status | 1985 to 2026 |
| `kom` | character | code | Municipality code | 1985 to 2026 |
| `year` | integer | date | Register year |  |
| `alder` | numeric | value | Age at the reference time point | 1985 to 2026 |
| `opr_land` | numeric | code | Country of origin | 1985 to 2026 |
| `referencetid` | date | date | Reference time point | 1985 to 2026 |

<details>
<summary>All other columns (30)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `mor_id` | character | identifier | Mother's person id | 1985 to 2026 |
| `far_id` | character | identifier | Father's person id | 1985 to 2026 |
| `aegte_id` | character | identifier | Spouse id | 1985 to 2026 |
| `e_faelle_id` | character | identifier | Cohabiting partner id | 1985 to 2026 |
| `fdato` | date | date | Date of birth, CPR form |  |
| `antboernf` | numeric | value | Number of children in the family | 1985 to 2026 |
| `antboernh` | numeric | value | Number of children in the household | 1985 to 2026 |
| `antpersf` | numeric | value | Number of people in the family | 1985 to 2026 |
| `antpersh` | numeric | value | Number of people in the household | 1985 to 2026 |
| `antefam` | numeric | value | Number of E-families in the household | 1985 to 2026 |
| `familie_type` | numeric | code | Family type | 1985 to 2026 |
| `fam_koen` | numeric | code | Sex of the family's reference person | 1985 to 2026 |
| `plads` | numeric | code | Position in the family | 1985 to 2026 |
| `hustype` | numeric | code | Household type | 1985 to 2026 |
| `fm_mark` | numeric | code | Parent marker | 1985 to 2026 |
| `civ_vfra` | date | date | Date the marital status took effect | 1985 to 2026 |
| `bop_vfra` | date | date | Date of moving in or immigrating | 1985 to 2026 |
| `ie_type` | numeric | code | Immigrant, descendant or Danish origin | 1985 to 2026 |
| `foedreg_kode` | numeric | code | Place of birth registration | 1985 to 2026 |
| `statsb` | numeric | code | Citizenship | 1985 to 2026 |
| `opholdmd_dk` | numeric | value | Months of residence in Denmark | 1985 to 2026 |
| `van_vtil` | date | date | Immigration date | 1985-12 to 2003-12 |
| `foerste_indvandring` | date | date | First immigration date | 2004-12 to 2026-06 |
| `seneste_indvandring` | date | date | Most recent immigration date | 2004-12 to 2026-06 |
| `adresse_id` | character | identifier | Address id | 1985 to 2026 |
| `fkirk` | character | code | Membership of the Danish National Church | 2004-12 to 2026-06 |
| `cprtjek` | character | code | CPR check | 2004-12 to 2026-06 |
| `cprtype` | character | code | CPR type | 2004-12 to 2026-06 |
| `version` | numeric | code | Module data version | 2004-12 to 2026-06 |
| `betalingskom` | character | code | Betalingskommune | 1985 to 2026 |

- **`mor_id`:** A pnr-like identifier for the mother, so BEF can be turned into a family structure without a separate register. It is only filled where the link is registered, which is not the case for everyone born before CPR.
- **`aegte_id`:** Not proof of a current marriage. What it points to depends on civst: the current spouse if married (G), the former spouse if divorced (F), the deceased spouse if widowed (E), and the same for registered partnerships (P, O, L). Read it together with civst before treating it as a living partner.
- **`fdato`:** Not on DST's variable list for BEF, which documents foed_dag instead. Present in this delivery. Prefer foed_dag unless you have checked what yours contains.
- **`antefam`:** A household can hold several families. That is why the family counts and the household counts differ, and why FAIK's household income cannot be read as one family's income without checking this.
- **`familie_type`:** DST flags a data break across variables: the older C-family series (C_TYPE, 1980-2007) uses other definitions, so do not join the two into one series. The December 2015 reorganisation within familie_type is in the code system. A couple without joint children and without a marriage or partnership (samboende par) is defined by the register, not by the people: two adults of different sex, less than 15 years apart in age, not closely related as far as CPR shows, and the only two adults at the address.
- **`plads`:** Code 1 is not a head of household. In a couple of a man and a woman it is always the woman; in every other family it is the oldest person. DST flags a data break across variables: the older C-families (1980-2007) use C_STATUS instead.
- **`hustype`:** A household is everyone registered in CPR at the same address, so one household can hold several families (code 6). The variable starts in 1986. The older H_TYPE (1980-2007) uses different codes.
- **`fm_mark`:** DST's high-quality page documents FMMARK, the C-family version (1980-2007), and says fm_mark is its counterpart in the family data from 1986, filled in for children aged 0-24. The marker is built from the parent references in CPR. Where those are missing, the value is 6 (does not live with parents), even if the person does. The references are almost complete for people born after about 1960 and almost absent for people born before 1950. So code 6 mixes "lives apart from parents" with "parents unknown to CPR". DST writes this for FMMARK, but both are built from the same parent references.
- **`civ_vfra`:** The date of the most recent change in marital status (marriage, divorce, death of spouse), not necessarily the wedding date. For people who have never married (civst U), DST sets it to the date of birth (the page says this applies "back to 2004"), so a filled-in civ_vfra is not an event. For immigrants it is only registered when the date is known and recognised by Danish authorities.
- **`ie_type`:** Can change for the same person over time. A child born in Denmark whose parents were born in Denmark but kept a foreign citizenship is a descendant. If one of those parents becomes a Danish citizen, the child is reclassified as Danish origin. When no parent is known, a person born abroad is an immigrant, a person with a foreign citizenship is a descendant, and a person born in Denmark is of Danish origin.
- **`foedreg_kode`:** Not the place of birth for everyone. It is the authority that registered the birth: for births before 1 January 1978 the parish where the birth took place, and from 1978 the mother's parish of residence. For immigrants it is a country code (5104-5902, 5999 unknown abroad). Danish code ranges include 0101-0961 for municipalities, 7001-9348 for parishes, 4601-4687 for recognised religious communities and 4999 for totally unknown. A blank or 0000 is replaced by the most recent known citizenship, and DST warns that some old, undocumented codes occur. This delivery stores the column as a number, which drops the leading zero of codes like 0101.
- **`van_vtil`:** Ends December 2003 and is replaced by foerste_indvandring and seneste_indvandring. A study spanning 2003 has to read both, or it silently loses immigration dates on one side of the break. A move to Denmark is only registered in CPR when the stay is meant to last more than 3 months, or more than 6 months for Nordic and EU/EEA citizens. Shorter stays never reach BEF.
- **`foerste_indvandring`:** Begins December 2004. Before that the information is in van_vtil.
- **`adresse_id`:** Identifies a dwelling, so two people with the same value live at the same address. It is not a geographic coordinate and cannot be decoded into one.

</details>

*No published source gives a data type for 1 of these 41 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `familie_id` joins to **FAIK** (many-to-one).

<details>
<summary>Value sets for the coded columns (9)</summary>

| Code system | Values |
| --- | --- |
| `koen` | `1` Mand, `2` Kvinde, `9` Uoplyst |
| `reg` | `0` Uoplyst, `81` Nordjylland, `82` Midtjylland, `83` Syddanmark, `84` Hovedstaden, `85` Sjælland |
| `civst` | `U` Ugift, `G` Gift (+ separeret), `F` Skilt, `E` Enke/Enkemand, `P` Registreret partnerskab, `O` Ophævet partnerskab, `L` Længstlevende af 2 partnere, `D` Død, `9` Uoplyst civilstand |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) |
| `familie_type` | `1` Ægtepar, `2` Registreret partnerskab, `3` Samlevende par, `4` Samboende par, `5` Enlig (herunder også ikke hjemmeboende børn), `7` Ægtepar forskellig køn, `8` Ægtepar samme køn, `9` Enlig, `10` Ikke hjemmeboende børn |
| `plads` | `1` Hovedperson, `2` Ægtefælle/partner, `3` Hjemmeboende barn |
| `hustype` | `1` Enlig mand, `2` Enlig kvinde, `3` Ægtepar, `4` Par i øvrigt, `5` Ikke hjemmeboende børn (under 18 år), `6` Andre husstande bestående af flere familier |
| `fm_mark` | `1` Bor sammen med begge forældrene, `2` For børn: Bor hos mor, der er i nyt par. For voksne: Bor sammen med mor, `3` For børn: Bor hos enlig mor. For voksne: Værdien findes ikke, `4` For børn: Bor hos far, der er i nyt par. For voksne: Bor sammen med far, `5` For børn: Bor hos enlig far. For voksne: Værdien findes ikke, `6` Bor ikke hos forældrene |
| `herkomst` | `1` Personer med dansk oprindelse, `2` Indvandrere, `3` Efterkommere, `9` Uoplyst |

- **`koen`:** DST's classification KOEN_V1_1980 also defines `9` for not stated, which a delivery may not contain but a value set should. Sex is taken from the tenth digit of the CPR number: even is female, odd is male.
- **`reg`:** Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.
- **`civst`:** Codes P, O and L came in with the registered-partnership act of 1 October 1989; before that the set was smaller. Registered partnerships could no longer be entered into from 15 June 2012.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality - confirmed for two reused codes against a current-only DST source: 707 is Norddjurs today, not its pre-2007 meaning, and likewise 849 is Jammerbugt. `lookup:` below covers only this post-2007 set (99 entries), not the full 278-code `values_from` file. Christiansø (411) is included in `lookup:` even though it is not a municipality (see description above): it is a real value a `kom` column can hold, and DST's own current-only classification lists it as its own area code alongside the 98 municipalities. Excluding it would just move the "unhandled code" problem this fix is meant to solve onto that one value.
- **`familie_type`:** There is no code 6, and the set changed in December 2015. Codes 7 and 8 split the old "Ægtepar" by sex, and codes 9 and 10 split the old "Enlig", which had included children not living at home. A series that crosses 2015 therefore changes composition without any code going missing: 1 and 5 stop being used and four new codes appear. The exact switch-over dates are on DST's page and should be read there before a study is dated around them.
- **`fm_mark`:** Codes 3 and 5 occur for children only. For an adult the value does not exist, so an adult cohort holding them means the row is not what you think.
- **`herkomst`:** A descendant is born in Denmark: neither parent is both a Danish citizen and born in Denmark. So the category says something about the parents, not about where the person was born. It can still change over a lifetime: if a parent born in Denmark becomes a Danish citizen, the child is reclassified from descendant to Danish origin (DST's high-quality page for IE_TYPE, https://www.dst.dk/da/TilSalg/data-til-forskning/generelt-om-data/dokumentation-af-data/hoejkvalitetsvariable/Udlaendinge/IE-TYPE).

Where these values come from:

- **`koen`:** [DST's classification KOEN_V1_1980](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/koen) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e267e7c0-d998-4922-b2c4-6b44b15dd149csv_da)).
- **`reg`:** [DST's regional classification](https://www.dst.dk/extranet/ForskningVariabellister/BEF%20-%20Befolkningen.html).
- **`civst`:** [DST's variable list for BEF](https://www.dst.dk/da/Statistik/dokumentation/Times/cpr-oplysninger/civst).
- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/amt-kom) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e6e3c1d3-df3b-4e69-bc2b-c5d3f343833ccsv_da)).
- **`familie_type`:** [DST high-quality variable documentation: familie-type](https://www.dst.dk/da/TilSalg/data-til-forskning/generelt-om-data/dokumentation-af-data/hoejkvalitetsvariable/familier/familie-type).
- **`plads`:** [DST high-quality variable documentation: plads](https://www.dst.dk/da/TilSalg/data-til-forskning/generelt-om-data/dokumentation-af-data/hoejkvalitetsvariable/familier/plads).
- **`hustype`:** [DST high-quality variable documentation: hustype](https://www.dst.dk/da/TilSalg/data-til-forskning/generelt-om-data/dokumentation-af-data/hoejkvalitetsvariable/husstande/hustype).
- **`fm_mark`:** [DST TIMES documentation: fm_mark](https://www.dst.dk/da/Statistik/dokumentation/Times/moduldata-for-befolkning-og-valg/fm-mark).
- **`herkomst`:** [DST's herkomst classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/herkomst) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/948ef1c3-072c-4d76-ba2b-ce7d34691593csv_da)).

</details>

**Worth knowing:**

- **`pnr`:** A person appears once per snapshot, not once in total. Taking a single year loses people who were resident but not in that particular snapshot, so a population is built from the union of all snapshots in the window. A CPR number is never reused. But a person who was given a number with the wrong birth date or sex gets a new one, and CPR keeps a reference between the old and the new number. So in rare cases one person has two numbers over time. DST's page does not say whether that reference reaches a research delivery.
- **`foed_dag`:** Derived from the CPR number (format YYYYMMDD), not reported on its own. It is as reliable as the CPR number it comes from.
- **`familie_id`:** Identifies an E-family from 1986: a single person or a couple, with any children living at home. It is not a stable key over time. A couple that splits up gets two new values, two people who move in together get a new shared value, and when one partner dies the survivor and their joint children living at home get a new value. A child who moves out gets a new value, while the parents keep theirs. Family data are formed quarterly, so a new familie_id first appears in the following quarter. A child counts as living at home only if under 25, never married, without children of their own in CPR, and not part of a couple. The older C-families (1980-2007) use c_familie_id instead.
- **`civst`:** Code G includes people who are separated but not divorced. From 15 June 2012 a registered partnership entered into in Denmark could be converted into a marriage. CPR then undoes the partnership and records a marriage dated back to the day of the partnership, so a person's history can change from P to G after the fact, and a G with a civ_vfra before 2012 can be a converted partnership.
- **`kom`:** Taken from the CPR address and covers Danish municipalities only. The 2007 reform merged 271 municipalities into 98. CPR has converted old addresses to the 98 new municipalities, and DST keeps the new codes for 1986-2007 in a separate table (MODULSTATUS_1986_2007). That suggests kom itself keeps the old codes before 2007: check which codes your early years contain before grouping by municipality. Thirteen old municipalities were split between new ones, so even the converted series has a small break at 2007.
- **`year`:** Not a DST variable. It comes from the parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of BEF. Because it is made rather than delivered, the name is not guaranteed: check colnames() rather than assuming.
- **`alder`:** Age at the snapshot, not at any date you choose. Recompute from foed_dag and your own index date rather than reusing it.
- **`opr_land`:** DST flags a data break within this variable. The former Soviet and Yugoslav republics only have their own codes from the date they became separate countries, and a number of country codes were retired in 1990 and folded into others (East Germany 5184 into Germany 5180, for example). Czechoslovakia (5162) was split in 1993. Grouping by country over time needs a mapping that handles these. How the country is chosen: persons of Danish origin always have Denmark. If no parent is known, an immigrant gets the country of birth and a descendant the country of citizenship. If parents are known, it follows the parent's country of birth (the mother's when both are known), or their citizenship if that parent was born in Denmark. Codes 5157, 5223, 5393 and 5437 are areas (Palestine, Gaza, West Bank, East Jerusalem), not countries.
- **`referencetid`:** The date the snapshot describes. Every other column in the row is a status as of this moment, which is what makes BEF a status register rather than an event register.
