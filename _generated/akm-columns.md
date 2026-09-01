<!-- Generated from schema/registers/akm.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `socio13` | integer | code | Socioeconomic classification, 2013 version |
| `socio02` | integer | code | Socioeconomic classification, 2002 version |
| `socio` | integer | code | Socioeconomic classification, 1994-2001 version |
| `socio_gl` | integer | code | Socioeconomic classification, 1976-1990 version |
| `beskst13` | integer | code | Main source of income |
| `year` | integer | date | Register year |

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
- **`beskst13`:** A different question from socio13: where the money came from, rather than what the person's labour market position was. The value set has not been sourced.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
