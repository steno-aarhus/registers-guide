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
<summary>All other columns (4)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `beskst13` | integer | code | Main source of income | 1991 to 2024 |
| `disco08_alle_indk_13` | character | code | Occupation code, DISCO-08 | 2010 to 2024 |
| `nace_db07_13` | character | code | Industry, DB07 | 2007 to 2024 |
| `alder_ult_ink` | integer | value | Age at 31 December | 1991 to 2024 |

- **`beskst13`:** A different question from socio13: where the money came from, rather than what the person's labour market position was. The value set has not been sourced.
- **`disco08_alle_indk_13`:** Occupation, not socioeconomic position. DISCO-08 only starts in 2010; 1991-2009 uses the older disco_alle_indk_13 with a different code set, so an occupation series across 2010 is not continuous.
- **`nace_db07_13`:** Industry classification from 2007. The pre-2007 series uses nace_13, which is a different classification rather than a renamed one.
- **`alder_ult_ink`:** Age at the end of the year, not at your index date. Recompute from a birth date if the exact age matters.

</details>

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `socio13` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/socio) |

- **`socio13`:** DST publishes four versions for different eras (SOCIO_GL, SOCIO, SOCIO02, SOCIO13). They are not interchangeable, so a study spanning the boundaries has to decide which one it uses and check that it covers the whole period.

</details>

**Worth knowing:**

- **`socio13`:** This is the version to use. It runs from 1991, so it reaches back further than its name suggests and covers the periods of the three older versions as well.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
