<!-- Generated from schema/registers/ftforael.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`PNR`** | character | join key | Personal identifier |
| **`FORAELDER_PNR`** | character | join key | Parent's personal identifier |
| `MOR_FAR` | character | code | Whether the parent is the mother or the father |

<details>
<summary>All other columns (17)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `FOED_DAG` | date | date | Date of birth |
| `DOED_DATO` | date | date | Child's date of death |
| `MDOED` | character | code | Death marker (stillborn, died in first year, survived first year, died later) |
| `FLERFOLD` | character | code | Multiple birth (single, twin, triplet, quadruplet) |
| `ADOP` | character | code | Adoptive or other non-biological relation to the child |
| `PARITET` | numeric | value | Mother's delivery number as recorded in MFR |
| `DEMOGRAFISK_PARITET` | numeric | value | Child's birth order among live-born siblings |
| `ENKELT_PARITET` | numeric | value | Child's order among singleton-born siblings |
| `FAMILIE_PARITET` | numeric | value | Child's order among siblings who survived their first year |
| `MEDICINSK_PARITET` | numeric | value | Mother's delivery number (stillbirths count, a multiple birth counts once) |
| `DEMOGRAFISK_SPACING` | numeric | value | Days to the next live-born sibling |
| `ENKELT_SPACING` | numeric | value | Days to the next singleton-born sibling |
| `FAMILIE_SPACING` | numeric | value | Days to the next sibling, both surviving their first year |
| `MEDICINSK_SPACING` | numeric | value | Days to the mother's next delivery |
| `CPRTJEK` | character | code | CPR check |
| `CPRTYPE` | character | code | CPR type |
| `VERSION` | character | value | Module data version |

- **`FOED_DAG`:** The child's birth date, not the parent's.
- **`ADOP`:** Adoption indicator, by the variable name - not confirmed by any DST description text, and no code values given.
- **`PARITET`:** A simple sequential birth number for the mother (labelled specifically as "moderens fødsel nummer"), distinct from the four PARITET/SPACING variant columns below, which DST does not further define relative to this one or to each other.

</details>

*No published source gives a data type for 20 of these 20 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `PNR`.

**Joins to other registers:**

- `PNR` joins to **FTBARN** (many-to-one).
- `FORAELDER_PNR` joins to **BEF** (many-to-one).

**Worth knowing:**

- **`PNR`:** The child's own personnummer, joining back to ftbarn.PNR - not the parent's.
- **`FORAELDER_PNR`:** The parent's personnummer, joining to bef.pnr. Which parent (mother or father) is given by MOR_FAR.
- **`MOR_FAR`:** Value codes not given by DST's page (likely something like Mor/Far, not confirmed). Group by PNR and count rows before assuming every child has exactly two: a child with an unknown or unregistered parent has only one row here, for the parent that is known.
