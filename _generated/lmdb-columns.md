<!-- Generated from schema/registers/lmdb.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 1995-Q2 to 2025-Q2 |
| `eksd` | date | date | Dispensing date | 1995-Q2 to 2025-Q2 |
| `atc` | character | code | ATC code, full 7 characters | 1995-Q2 to 2025-Q2 |
| `atc1` | character | code | ATC level 1 (1 character) | 1995-Q2 to 2025-Q2 |
| `atc2` | character | code | ATC level 2 (3 characters) | 1995-Q2 to 2025-Q2 |
| `atc3` | character | code | ATC level 3 (4 characters) | 1995-Q2 to 2025-Q2 |
| `atc4` | character | code | ATC level 4 (5 characters) | 1995-Q2 to 2025-Q2 |
| `vnr` | character | code | Item number (product key) | 1995-Q2 to 2025-Q2 |
| `apk` | numeric | value | Number of packages | 1995-Q2 to 2025-Q2 |
| `year` | integer | date | Dispensing year |  |

<details>
<summary>All other columns (55)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `indo` | character | code | Indication code | 2004-Q2 to 2025-Q2 |
| `packsize` | numeric | value | Package size | 1995-Q2 to 2025-Q2 |
| `strnum` | numeric | value | Strength, numeric | 1995-Q2 to 2025-Q2 |
| `strunit` | character | value | Unit for the numeric strength | 1995-Q2 to 2025-Q2 |
| `aldr` | numeric | value | Age at dispensing | 1995 to 2025 |
| `abc` | character | code | ABC-kode | 2007 to 2025 |
| `aip` | numeric | value | Registerpris ('Apotekets indkøbspris') (s) | 1995 to 2025 |
| `aref` | character | code | Andre refusionsordninger | 1995 to 2025 |
| `aup` | numeric | value | Registerpris ('Apotekets udsalgspris') (s) | 1995 to 2025 |
| `bald` | character | code |  | 1995 to 2011 |
| `cprtjek` | character | code | CPR-tjek | 1995 to 2025 |
| `cprtype` | character | code | CPR-type | 1995 to 2025 |
| `cpr_kom` | date | date | CPR-bopælskommune på ekspeditionsdatoen | 2005 to 2025 |
| `cpr_reg` | date | date | CPR-bopælsregion på ekspeditionsdatoen | 2005 to 2025 |
| `dosform` | character | code | Lægemiddelform (s) | 1995 to 2025 |
| `doso` | character | code | Doseringskode | 2004 to 2025 |
| `edbl` | character | code |  | 2020 to 2025 |
| `ejs` | character | code | Fravalg af substitution | 1997 to 2025 |
| `eksp` | numeric | value | Ekspeditionspris | 1995 to 2025 |
| `ekst` | character | code | Ekspeditionstype | 1995 to 2025 |
| `etid` | numeric | date | Ekspeditionstidspunkt | 1997 to 2025 |
| `ibgp` | numeric | value | Indberettet beregningsgrundlagspris | 2000 to 2025 |
| `ibnr` | character | code | Indberetternummer | 1995 to 2025 |
| `itype` | character | code | Indberettertype | 1995 to 2025 |
| `kom` | character | code | Kommunekode | 1995 to 2025 |
| `korr` | character | code | Korrektionskode | 1995 to 2025 |
| `name` | character | code | Lægemidlets navn (Store bogstaver) (s) | 1995 to 2025 |
| `ovnr` | character | code | Ordineret varenummer | 1997 to 2025 |
| `packtext` | character | code | PACKTEXT | 1995 to 2025 |
| `patt` | character | code | Patienttype | 2000 to 2025 |
| `pksubgr` | character | code | Pakningssubstitutionsgruppe | 2007 to 2025 |
| **`pnr12`** | character | join key | CPR-nummer | 1995 to 2025 |
| `pprs` | character | code | Udleveringsbestemmelse | 1995 to 2025 |
| `ptp` | character | code | Patientbetaling | 1995 to 2025 |
| `ramt` | character | code | Amtskommunekode | 1995 to 2025 |
| `reca` | character | code | Autorisationskode for receptudsteder | 2005 to 2025 |
| `recu` | character | code | Receptudsteder | 1995 to 2025 |
| `rgl1` | character | code | 1. Kommuneregelnummer | 1995 to 2025 |
| `rgl2` | character | code | 2. kommuneregelnummer | 1995 to 2025 |
| `rgla` | character | code | Amtskommunalt reglnummer | 1995 to 2025 |
| `rimb` | character | code | Tilskudskode | 1995 to 2025 |
| `rinr` | character | code | Reiterationsnummer | 1995 to 2025 |
| `sektor` | character | code | Sektor | 1995 to 2025 |
| `streng` | character | code | Styrke, klartekst (s) | 1995 to 2025 |
| `takd` | date | date | Takstdato | 1995 to 2025 |
| `tard` | date | date | Takseringsdato | 2000 to 2025 |
| `tilpris` | numeric | value | Tilskudspris pr. pakning | 1995 to 2025 |
| `tsk1` | character | code | 1. Kommunale tilskud | 1995 to 2025 |
| `tsk2` | character | code | 2. Kommunale tilskud | 1995 to 2025 |
| `tsk3` | character | code | Andre tilskud | 1995 to 2025 |
| `tska` | character | code | Amtskommunalt tilskud | 1995 to 2025 |
| `udlv` | character | code | Udleveringssted | 1995 to 2025 |
| `voltypecode` | character | code |  | 1995 to 2025 |
| `voltypetxt` | character | code |  | 1995 to 2025 |
| `volume` | character | code | Volume | 1995 to 2025 |

- **`indo`:** Recorded only when the prescriber picks an indication from the drop-down. Typed as free text it is not carried over, so the column is often empty.

</details>

*No published source gives a data type for 48 of these 65 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `atc` | Not listed here - see [DST's classification](https://atcddd.fhi.no/atc/structure_and_principles/) |

- **`atc`:** As a rule, filter on the full 7-character code rather than on the level columns: `atc2` holds three characters, so a longer pattern matched against it can never match, and it returns nothing at all with no error. The level columns are well suited to grouping, and to filtering when every code you want is the same length as the column.

Where these values come from:

- **`atc`:** [WHO ATC/DDD Index](https://atcddd.fhi.no/atc/structure_and_principles/).

</details>

**Worth knowing:**

- **`pnr`:** DST's variable list calls this column `PNR12`. Check whether your variable is named `pnr` or `pnr12`.
- **`eksd`:** The date the prescription was collected at the pharmacy. Not the date it was prescribed, and not evidence that the medicine was taken.
- **`vnr`:** The only reliable way to isolate one specific product. Two brands with the same active substance share an ATC code but have different item numbers.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
