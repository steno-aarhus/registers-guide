<!-- Generated from schema/registers/ftbarn.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`PNR`** | character | join key | Personal identifier |
| `FOED_DAG` | date | date | Date of birth |
| `LEVENDE_ELLER_DOEDFOEDT` | character | code | Live birth or stillbirth |

<details>
<summary>All other columns (31)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `FOEDAAR` | numeric | value | Year of birth |
| `KOEN` | character | code | Sex |
| `FLERFOLD` | character | code | Multiple birth (single, twin, triplet, quadruplet) |
| `VAEGT_BARN` | numeric | value | Birth weight in grams (from MFR) |
| `LAENGDE_BARN` | numeric | value | Birth length in cm (from MFR) |
| `MFR_OPLYSNING` | character | code | Child found in the Medical Birth Register (MFR) |
| `FOEDREG_DK` | character | code | Birth registered with a Danish authority code |
| `FOEDREG_KODE` | character | code | Birth registration authority code |
| `FOEDTE_POPULATION` | character | code | Population boundary relative to DST's births statistics |
| `INDDAG` | numeric | value | Child's age in days at first CPR registration |
| `CPRTJEK` | character | code | CPR check |
| `CPRTYPE` | character | code | CPR type |
| `MOR1` | character | code | Earliest registered mother |
| `MOR2` | character | code | Latest mother, if different from mor1 |
| `MOR_ALDER` | numeric | value | Mother's age |
| `MOR_ALDER_ULT` | numeric | value | Mother's age at the end of the year |
| `MOR_FOED_ADOP` | character | code | Mother's relation to the child (adoptive or other non-biological) |
| `MOR_KOEN` | character | code | Mother's (mor1) sex |
| `MOR_VFRA` | character | value | Date the current mother became the parent |
| `M_KILDE` | character | code | Source of the mor1 information |
| `FAR1` | character | code | Earliest registered father/co-mother |
| `FAR2` | character | code | Latest father/co-mother, if different from far1 |
| `FAR_ALDER` | numeric | value | Father's (far1) age on the child's birthday |
| `FAR_ALDER_ULT` | numeric | value | Father's (far1) age at the end of the birth year |
| `FAR_FOED_ADOP` | character | code | Father's relation to the child (adoptive or other non-biological) |
| `FAR_KOEN` | character | code | Father's (far1) sex |
| `FAR_VFRA` | character | value | Date the current father/co-mother became the parent |
| `F_KILDE` | character | code | Source of the far1 information |
| `B_KILDE` | character | code | Source of the child's data |
| `MDOED` | character | code | Death marker (stillborn, died in first year, survived first year, died later) |
| `VERSION` | character | value | Module data version |

- **`KOEN`:** Not confirmed against either `koen` (DST's numeric 1/2/9) or `mfr_koen` (SDS's letter K/M/Ukendt): DST's page for this register gives no value definitions at all, so which encoding this register actually uses is unverified. Check with `table()` on real data before assuming either.
- **`FLERFOLD`:** Multiple-birth indicator, by the variable name - not confirmed by any DST description text.
- **`VAEGT_BARN`:** -1 likely means not stated, matching mfr_nyfoedte's own Vaegt_Barn convention, per DST's October 2025 change note - not independently confirmed on this register's own variable-list page.
- **`MFR_OPLYSNING`:** The explicit link to the Medical Birth Register: this column is Sundhedsdatastyrelsen's own confirmation that FTBARN draws medical birth detail from MFR, not DST inventing an equivalent independently. Exact meaning of its values is not documented on DST's page.
- **`CPRTJEK`:** Likely a CPR-number validity check, by name analogy to mfr_er_cprnummer_gyldigt - not confirmed to share that code system's values, since DST's page for this register defines neither.
- **`MOR1`:** The earliest mother registered for this child. MOR1 and MOR2 can differ: CRS parental links are sometimes corrected or reassigned after the fact (e.g. following a legal dispute or a data error), and this register keeps both the original and the current answer rather than silently overwriting one with the other.
- **`MOR2`:** The current/most recently registered mother. See MOR1's reader_note.
- **`MOR_FOED_ADOP`:** Biological vs adoptive, by the variable name (FOED = født = born, ADOP = adopteret) - not itself confirmed by DST's description text.
- **`FAR1`:** The earliest father registered for this child. See MOR1's reader_note - same pattern, paternal side.

</details>

*No published source gives a data type for 33 of these 34 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `PNR`.

**Joins to other registers:**

- `PNR` joins to **BEF** (many-to-one).

**Worth knowing:**

- **`PNR`:** The child's own personnummer.
- **`LEVENDE_ELLER_DOEDFOEDT`:** Value codes not given by DST's page - see the register-level note on unconfirmed code values.
