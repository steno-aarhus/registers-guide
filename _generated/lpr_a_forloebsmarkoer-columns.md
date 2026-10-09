<!-- Generated from schema/registers/lpr_a_forloebsmarkoer.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_FORLOEB`** | character | join key | Course identifier |
| `MARKOER` | character | code | Marker code |

<details>
<summary>All other columns (7)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `DW_EK_HELBREDSFORLOEB` | character | code | Health course identifier |
| `DW_EK_MARKOERREGISTRERING` | character | identifier | Marker registration identifier |
| `LPRINDBERETNINGSSYSTEM` | character | code | Reporting system |
| `MARKOER_INDB_TIDSPUNKT` | datetime | date | Marker reporting time |
| `MARKOER_SKS_TYPE` | character | code | Marker SKS code type |
| `MARKOER_TEKST` | character | derived | Marker, text |
| `MARKOER_TIDSPUNKT` | datetime | date | Marker event time |

- **`DW_EK_HELBREDSFORLOEB`:** A level above dw_ek_forloeb, not documented anywhere else in this schema - a helbredsforloeb can group several forloeb rows. Not confirmed to match any single row in lpr_a_forloeb.yaml one-to-one.
- **`LPRINDBERETNINGSSYSTEM`:** Filter to 'LPR3' when combining with LPR2, or the same marker risks being counted under both systems.
- **`MARKOER_INDB_TIDSPUNKT`:** When the marker was reported to LPR3, not necessarily when the event happened - see markoer_tidspunkt for that.
- **`MARKOER_TEKST`:** The text label for markoer - the practical way to read this column without a SKS browser lookup.
- **`MARKOER_TIDSPUNKT`:** By LPR3_F's own definition (section 3.9) a marker IS its timestamp - this is the actual event time, distinct from markoer_indb_tidspunkt (when it was reported).

</details>

*No published source gives a data type for 7 of these 9 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `DW_EK_FORLOEB`.

**Joins to other registers:**

- `DW_EK_FORLOEB` joins to **LPR_A_FORLOEB** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `lprindberetningssystem` | `LPR3`, `MiniPAS`, `LPR2`, `LPR1` |

- **`lprindberetningssystem`:** Confirm the exact strings with `count(lprindberetningssystem)` before relying on "LPR2" or "LPR1" in a filter: they are well-established as concepts in this guide, but nobody has pasted the literal value back from DARTER the way pitfall 5 did for "LPR3". "MiniPAS" is safe to rely on, since kont_type.yaml's coalescing logic already depends on it being exactly that string. This column is unrelated to LPR_F vs LPR_A: that choice is made before you open a file, this one lives inside the file you already chose.

Where these values come from:

- **`lprindberetningssystem`:** [No DST/Sundhedsdatastyrelsen kodeark for this column exists; the value set below is reconstructed from DARTER-team-confirmed facts already established elsewhere in this guide (this pitfalls page, and kont_type.yaml), not from a published code list.](darter-pitfalls.qmd#lpr3-lprindberetningssystem).

</details>

**Worth knowing:**

- **`DW_EK_FORLOEB`:** No unique key exists for this table (Sundhedsdatastyrelsen's LPR3_F guidance, section 3.9): every row hangs off the course it was registered on.
- **`MARKOER`:** Three logical kinds share this one column, distinguished only by which code fires: a single-event marker (e.g. informed consent given), a period-start marker (e.g. referred for workup), or a period-end marker (e.g. cancer pathway ended). Not every period has both a start and an end marker: some periods hand off to the next with only a start.
