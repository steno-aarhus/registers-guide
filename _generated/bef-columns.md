<!-- Generated from schema/registers/bef.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |  |
| `koen` | integer | code | Sex |  |
| `foed_dag` | date | date | Date of birth |  |
| **`familie_id`** | character | join key | Household key |  |
| `reg` | character | code | Region |  |
| `civst` | character | code | Marital status |  |
| `kom` | character | code | Municipality code |  |
| `year` | integer | date | Register year |  |
| `referencetid` | date | date | Reference time point |  |

<details>
<summary>All other columns (31)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `mor_id` | character | identifier | Mother's person id |  |
| `far_id` | character | identifier | Father's person id |  |
| `aegte_id` | character | identifier | Spouse id |  |
| `e_faelle_id` | character | identifier | Cohabiting partner id |  |
| `fdato` | date | date | Date of birth, CPR form |  |
| `alder` | integer | value | Age at the reference time point |  |
| `antboernf` | integer | value | Number of children in the family |  |
| `antboernh` | integer | value | Number of children in the household |  |
| `antpersf` | integer | value | Number of people in the family |  |
| `antpersh` | integer | value | Number of people in the household |  |
| `antefam` | integer | value | Number of E-families in the household |  |
| `familie_type` | character | code | Family type |  |
| `fam_koen` | integer | code | Sex of the family's reference person |  |
| `plads` | character | code | Position in the family |  |
| `hustype` | character | code | Household type |  |
| `fm_mark` | character | code | Parent marker |  |
| `civ_vfra` | date | date | Date the marital status took effect |  |
| `bop_vfra` | date | date | Date of moving in or immigrating |  |
| `ie_type` | character | code | Immigrant, descendant or Danish origin |  |
| `opr_land` | character | code | Country of origin |  |
| `foedreg_kode` | character | code | Place of birth registration |  |
| `statsb` | character | code | Citizenship |  |
| `opholdmd_dk` | integer | value | Months of residence in Denmark |  |
| `van_vtil` | date | date | Immigration date | 1985-12 to 2003-12 |
| `foerste_indvandring` | date | date | First immigration date | 2004-12 to 2026-06 |
| `seneste_indvandring` | date | date | Most recent immigration date | 2004-12 to 2026-06 |
| `adresse_id` | character | identifier | Address id |  |
| `fkirk` | character | code | Membership of the Danish National Church | 2004-12 to 2026-06 |
| `cprtjek` | character | code | CPR check | 2004-12 to 2026-06 |
| `cprtype` | character | code | CPR type | 2004-12 to 2026-06 |
| `version` | character | code | Module data version | 2004-12 to 2026-06 |

- **`mor_id`:** A pnr-like identifier for the mother, so BEF can be turned into a family structure without a separate register. It is only filled where the link is registered, which is not the case for everyone born before CPR.
- **`fdato`:** Not on DST's variable list for BEF, which documents foed_dag instead. Present in this delivery. Prefer foed_dag unless you have checked what yours contains.
- **`alder`:** Age at the snapshot, not at any date you choose. Recompute from foed_dag and your own index date rather than reusing it.
- **`antefam`:** A household can hold several families. That is why the family counts and the household counts differ, and why FAIK's household income cannot be read as one family's income without checking this.
- **`van_vtil`:** Ends December 2003 and is replaced by foerste_indvandring and seneste_indvandring. A study spanning 2003 has to read both, or it silently loses immigration dates on one side of the break.
- **`foerste_indvandring`:** Begins December 2004. Before that the information is in van_vtil.
- **`adresse_id`:** Identifies a dwelling, so two people with the same value live at the same address. It is not a geographic coordinate and cannot be decoded into one.

</details>

**Join key:** `pnr`.

**Joins to other registers:**

- `familie_id` joins to **FAIK** (many-to-one).

<details>
<summary>Value sets for the coded columns (4)</summary>

| Code system | Values |
| --- | --- |
| `koen` | `1` Mand, `2` Kvinde |
| `reg` | `0` Uoplyst, `81` Nordjylland, `82` Midtjylland, `83` Syddanmark, `84` Hovedstaden, `85` Sjælland |
| `civst` | `U` Ugift, `G` Gift (+ separeret), `F` Skilt, `E` Enke/Enkemand, `P` Registreret partnerskab, `O` Ophævet partnerskab, `L` Længstlevende af 2 partnere, `D` Død, `9` Uoplyst civilstand |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts) |

- **`reg`:** Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.
- **`civst`:** Codes P, O and L came in with the registered-partnership act of 1 October 1989; before that the set was smaller. Registered partnerships could no longer be entered into from 15 June 2012.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.

</details>

**Worth knowing:**

- **`pnr`:** A person appears once per snapshot, not once in total. Taking a single year loses people who were resident but not in that particular snapshot, so a population is built from the union of all snapshots in the window.
- **`year`:** Not a DST variable. It comes from the parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of BEF. Because it is made rather than delivered, the name is not guaranteed: check colnames() rather than assuming.
- **`referencetid`:** The date the snapshot describes. Every other column in the row is a status as of this moment, which is what makes BEF a status register rather than an event register.
