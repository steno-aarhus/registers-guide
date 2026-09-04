<!-- Generated from schema/registers/akm.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |  |
| `socio13` | integer | code | Socioeconomic classification, 2013 version | 1991 to 2024 |
| `socio02` | integer | code | Socioeconomic classification, 2002 version | 2002 to 2013 |
| `socio` | integer | code | Socioeconomic classification, 1994-2001 version | 1994 to 2001 |
| `socio_gl` | integer | code | Socioeconomic classification, 1976-1990 version | 1976 to 1990 |
| `year` | integer | date | Register year |  |

<details>
<summary>All other columns (41)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `beskst13` | integer | code | Main source of income | 1991 to 2024 |
| `disco08_alle_indk_13` | character | code | Occupation code, DISCO-08 | 2010 to 2024 |
| `nace_db07_13` | character | code | Industry, DB07 | 2007 to 2024 |
| `alder_ult_ink` | integer | value | Age at 31 December | 1991 to 2024 |
| `ant_ansat_arbsted` | numeric | value | Antal ansatte for væsentligste arbejdssted ( optælling af ansatte sker for hver arbejdessted under SENR (AKM) | 2006 to 2013 |
| `ant_ansat_arbsted_13` | numeric | value | Antal ansatte for væsentligste arbejdssted ( optælling af ansatte sker for hver arbejdessted under SENR (AKM) | 2010 to 2024 |
| `ant_ansat_senr` | numeric | value | Antal ansatte for væsentligste beskæftigelse (AKM) | 1976 to 2005 |
| `atpsum2` | numeric | value | Beskæftigelsesmål baseret på ATP- indbetalinger (AKM) | 1976 to 2010 |
| `beskst` | numeric | value | Beskæftigelsesstatus 1980 til 2001 (Indkomst/AKM) | 1976 to 2001 |
| `beskst02` | numeric | value | Beskæftigelsesstatus fra 2002 (Indkomst/AKM) | 2002 to 2013 |
| `branche_77` | character | code | Dansk branchekode 1977 til 1993 (AKM) | 1980 to 1999 |
| `brchi` | character | code | Branchekode for indehaver | 1976 to 2002 |
| `brchl` | character | code | Branchekode for lønmodtager | 1976 to 1999 |
| `cprtjek` | character | code | CPR-tjek | 1991 to 2024 |
| `cprtype` | character | code | CPR-type | 1991 to 2024 |
| `disco08_alle_indk` | character | code | Fagklassifikation for beskæftigelsesforhold, fra 2010 (AKM) | 2010 to 2013 |
| `disco08_loen_indk` | character | code | Fagkode for væsentligste lønmodtagerbeskæftigelse i året. (AKM) | 2010 to 2024 |
| `disco08_sel_indk` | character | code | Fagkode for arbejde i selvstændig virksomhed (AKM) | 2010 to 2024 |
| `discoalle_indk` | character | code | Fagklassifikation for beskæftigelsesforhold, fra 1991 TIL 2009 (AKM) | 1993 to 2009 |
| `discoloen_indk` | character | code | Fagkode for væsentligste lønmodtagerbeskæftigelse i året. (AKM) | 1991 to 2009 |
| `discosel_indk` | character | code | Fagkode for arbejde i selvstændig virksomhed (AKM) | 1991 to 2009 |
| `discotyp` | character | code | Kilde til lønmodtager DISCO-koden (AKM) | 1991 to 2024 |
| `disco_alle_indk_13` | character | code | Fagklassifikation for beskæftigelsesforhold, fra 1991 TIL 2009 (AKM) | 1991 to 2009 |
| `funk_timeant` | numeric | value | Personens samlede antal arbejdstimer i året. | 2008 to 2024 |
| `nace` | character | code | Branche for væsentligste beskæftigelse, fra 1992 til 2007 (AKM) | 1992 to 2007 |
| `nacea` | character | code | Branchegruppering for arbejdssted (1993 til 2007) (AKM) | 1992 to 2007 |
| `nacea_db07` | character | code | Branchegruppering for arbejdssted ( fra 2007) (AKM) | 2007 to 2024 |
| `nacei` | character | code | Branchekode for selvstændige og medarbejdende ægtefællers virksomhed(1993 til 2007) (AKM) | 1993 to 2007 |
| `nacei_db07` | character | code | Branchegruppering for indehaver (Selvstændig eller medhjælpende ægtefælle) (fra 2007) (AKM) | 2007 to 2024 |
| `nace_13` | character | code | Branche for væsentligste beskæftigelse, fra 1993 til 2007 (AKM) | 1993 to 2007 |
| `nace_db07` | character | code | Branche for væsentligste beskæftigelse, fra 2008-2013 (AKM) | 2007 to 2013 |
| `nystgr` | character | code | Stillingsgruppering 1980 til 1995 (AKM) | 1980 to 1999 |
| `omfang` | character | code | Omfang af skattepligt | 1991 to 2024 |
| `senr` | character | code | SE-nummer | 1985 to 2002 |
| `senri` | character | code | SE-nummer for den virksomhed som personen ejer | 1985 to 2002 |
| `senrl` | character | code | SE-nummer for lønmodtager | 1985 to 1998 |
| `typ` | character | code | Stillingstype | 1980 to 1999 |
| `version` | character | code | Moduldata version | 1991 to 2024 |
| `virkf` | numeric | value | Virksomhedskode angiver hvilken form for ejerskab der er på den arbejdsplads personen får størst erhrvsindkomst fra (AKM) | 2001 to 2013 |
| `virkfa` | numeric | value | Virksomhedskode angiver hvilken form for ejerskab der er på den arbejdsplads personen får størstklønindkomst/arbejdstimer (AKM) | 2001 to 2024 |
| `virkf_13` | numeric | value | Virksomhedskode angiver hvilken form for ejerskab der er på den arbejdsplads personen får størst erhrvsindkomst fra (AKM) | 2001 to 2024 |

- **`beskst13`:** A different question from socio13: where the money came from, rather than what the person's labour market position was. The value set has not been sourced.
- **`disco08_alle_indk_13`:** Occupation, not socioeconomic position. DISCO-08 only starts in 2010; 1991-2009 uses the older disco_alle_indk_13 with a different code set, so an occupation series across 2010 is not continuous.
- **`nace_db07_13`:** Industry classification from 2007. The pre-2007 series uses nace_13, which is a different classification rather than a renamed one.
- **`alder_ult_ink`:** Age at the end of the year, not at your index date. Recompute from a birth date if the exact age matters.

</details>

*No published source gives a data type for 46 of these 47 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `socio13` | `11` Selvstændige, `110` Selvstændige, `111` Selvstændige erhvervsdrivende med 10 eller flere ansatte, `112` Selvstændige erhvervsdrivende med 5-9 ansatte, `113` Selvstændige erhvervsdrivende med 1-4 ansatte, `114` Selvstændige erhvervsdrivende uden ansatte, `12` Medarbejdende ægtefælle, `120` Medarbejdende ægtefælle, `13` Lønmodtagere, `131` Lønmodtagere med ledelsesarbejde, `132` Lønmodtager i arbejde der forudsætter færdigheder på højeste niveau, `133` Lønmodtager i arbejde der forudsætter færdigheder på mellemniveau, `134` Lønmodtager i arbejde der forudsætter færdigheder på grundniveau, `135` Andre lønmodtagere, `139` Lønmodtager uden nærmere angivelse, `21` Arbejdsløs mindst halvdelen af året, `210` Arbejdsløse mindst halvdelen af året, `22` Sygedagpenge, orlov mv., `220` Modtager af sygedagpenge, uddannelsesgodtgørelse, orlovsydelser mv., `31` Uddannelsessøgende, `310` Under uddannelse, inkl. skoleelever på min. 15 år, `32` Pensionist/efterløn, `321` Førtidspensionister, `322` Folkepensionister, `323` Efterlønsmodtagere mv., `33` Kontanthjælp, `330` Kontanthjælpsmodtagere, `41` Andre, `410` Andre, `42` Børn, `420` Børn under 15 år, ultimo året |

- **`socio13`:** Two codes are easy to misread. `410` is **Andre** (other), not unemployed: the unemployed are `210`. And `420` is **children under 15**, a known category rather than a missing value, so it appearing in an adult cohort means the index date is wrong rather than the data being incomplete.

Where these values come from:

- **`socio13`:** [DST's SOCIO classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/socio) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/007fb11c-4b35-4c7a-ad2d-f0a2cb0155c0csv_da)).

</details>

**Worth knowing:**

- **`socio13`:** This is the version to use. It runs from 1991, so it reaches back further than its name suggests and covers the periods of the three older versions as well.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
