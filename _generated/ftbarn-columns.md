<!-- Generated from schema/registers/ftbarn.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`PNR`** | character | join key | Personnummer |
| `FOED_DAG` | date | date | Fødselsdato |
| `LEVENDE_ELLER_DOEDFOEDT` | character | code | Levende eller dødfødt barn |

<details>
<summary>All other columns (31)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `FOEDAAR` | numeric | value |  |
| `KOEN` | character | code | Køn |
| `FLERFOLD` | character | code |  |
| `VAEGT_BARN` | numeric | value | Barnets fødselsvægt |
| `LAENGDE_BARN` | numeric | value |  |
| `MFR_OPLYSNING` | character | code | Oplysninger fra MFR |
| `FOEDREG_DK` | character | code | Fødselsregistrering i Danmark |
| `FOEDREG_KODE` | character | code | Kode for personens fødselsregistreringssted |
| `FOEDTE_POPULATION` | character | code |  |
| `INDDAG` | numeric | value | Barnets alder ved første registrering i CPR (dage) |
| `CPRTJEK` | character | code | CPR-tjek |
| `CPRTYPE` | character | code | CPR-type |
| `MOR1` | character | code | Tidligste mor |
| `MOR2` | character | code | Seneste mor |
| `MOR_ALDER` | numeric | value | Moderens alder |
| `MOR_ALDER_ULT` | numeric | value | Moderens alder ultimo året |
| `MOR_FOED_ADOP` | character | code | Mors relation til barnet |
| `MOR_KOEN` | character | code |  |
| `MOR_VFRA` | character | value |  |
| `M_KILDE` | character | code | Kilde til mor1-oplysningen |
| `FAR1` | character | code | Tidligste far registreret |
| `FAR2` | character | code | Seneste far |
| `FAR_ALDER` | numeric | value | Fars alder |
| `FAR_ALDER_ULT` | numeric | value |  |
| `FAR_FOED_ADOP` | character | code | Fars relation til barnet |
| `FAR_KOEN` | character | code | Fars køn |
| `FAR_VFRA` | character | value |  |
| `F_KILDE` | character | code | Kilde til far1-oplysningen |
| `B_KILDE` | character | code | Kilde til barnets oplysninger |
| `MDOED` | character | code | Markering af evt. død |
| `VERSION` | character | value | Moduldata version |

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
