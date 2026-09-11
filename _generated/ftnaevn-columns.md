<!-- Generated from schema/registers/ftnaevn.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`PNR`** | character | join key | Personnummer |
| `AAR` | numeric | date | Register-, eller tællingsår |

<details>
<summary>All other columns (13)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `FOED_DAG` | date | date | Fødselsdato |
| `KOEN` | character | code | Køn |
| `ALDER_START` | numeric | value |  |
| `ALDER_SLUT` | numeric | value |  |
| `ANDEL` | numeric | value | Andel af fertile alder |
| `ANTAL_BOERN_START` | numeric | value |  |
| `ANTAL_BOERN_SLUT` | numeric | value |  |
| `ANTAL_DAGE_START` | numeric | value |  |
| `ANTAL_DAGE_SLUT` | numeric | value |  |
| `PRIMO_ULTIMO` | character | code |  |
| `CPRTJEK` | character | code | CPR-tjek |
| `CPRTYPE` | character | code | CPR-type |
| `VERSION` | character | value | Moduldata version |

- **`KOEN`:** Not confirmed against either `koen` (DST's numeric 1/2/9) or `mfr_koen` (SDS's letter K/M/Ukendt) - see ftbarn.yaml's own KOEN column for the same unresolved question.
- **`ALDER_START`:** Age at the start of the reference year, by the variable name.
- **`ALDER_SLUT`:** Age at the end of the reference year, by the variable name.
- **`ANDEL`:** The proportion of the year this person spent within the fertile age range - the core denominator quantity this register exists to supply. Exact age bounds for "fertile age" are not given on DST's variable-list page.
- **`ANTAL_BOERN_START`:** Number of children at the start of the reference year, by the variable name.
- **`ANTAL_BOERN_SLUT`:** Number of children at the end of the reference year, by the variable name.
- **`PRIMO_ULTIMO`:** "Primo" (start of period) vs "ultimo" (end of period), by the variable name - plausibly an indicator of which of the _START/_SLUT column pairs above a given row's other values line up with, but this is read from the name alone, not confirmed by any DST description text.

</details>

*No published source gives a data type for 15 of these 15 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `PNR`, `AAR`.

**Joins to other registers:**

- `PNR` joins to **BEF** (many-to-one).

**Worth knowing:**

- **`AAR`:** Together with PNR this is the row's key: one row per person per year.
