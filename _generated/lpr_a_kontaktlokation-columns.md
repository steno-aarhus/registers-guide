<!-- Generated from schema/registers/lpr_a_kontaktlokation.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `KONT_LOK_ENH` | character | code | Location SOR unit code |

<details>
<summary>All other columns (10)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_KONTAKT`** | character | join key | Contact identifier |
| `DW_EK_KONTAKTLOKATION` | character | identifier | Contact location identifier |
| `FLAG_FRAVAER` | character | code | Absence flag |
| `KONT_LOK_ENH_HOVEDSPEC` | character | code | Location unit main specialty code |
| `KONT_LOK_FRAVAER` | character | code | Location absence/leave code |
| `KONT_LOK_FRAVAER_TEKST` | character | derived | Location absence/leave, text |
| `KONT_LOK_INDB_TIDSPUNKT` | datetime | date | Location reporting time |
| `KONT_LOK_INST` | character | code | Location institution code |
| `KONT_LOK_SLUTTIDSPUNKT` | datetime | date | Location end |
| `KONT_LOK_STARTTIDSPUNKT` | datetime | date | Location start |

- **`FLAG_FRAVAER`:** Whether this location row represents an absence/leave rather than a physical stay - see kont_lok_fravaer for the specific absence code.

</details>

*No published source gives a data type for 10 of these 11 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `DW_EK_KONTAKT`.

**Joins to other registers:**

- `DW_EK_KONTAKT` joins to **LPR_A_KONTAKT** (many-to-one).

**Worth knowing:**

- **`KONT_LOK_ENH`:** The specific SOR (Sundhedsvaesenets Organisationsregister) unit the citizen physically stayed at. If only the RESPONSIBLE unit for the whole contact is needed rather than the physical location, use sorenhed_ans on lpr_a_kontakt/lpr_a_forloeb instead (LPR3_F guidance, section 3.2) - this table is not needed for that simpler question.
