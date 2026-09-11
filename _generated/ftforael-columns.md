<!-- Generated from schema/registers/ftforael.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`PNR`** | character | join key | Personnummer |
| **`FORAELDER_PNR`** | character | join key |  |
| `MOR_FAR` | character | code | Angiver om foraelder_id er moren eller faderen |

<details>
<summary>All other columns (17)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `FOED_DAG` | date | date | Fødselsdato |
| `DOED_DATO` | date | date | Barnets dødsdato |
| `MDOED` | character | code | Markering af evt. død |
| `FLERFOLD` | character | code |  |
| `ADOP` | character | code |  |
| `PARITET` | numeric | value | Moderens fødsel nummer |
| `DEMOGRAFISK_PARITET` | numeric | value |  |
| `ENKELT_PARITET` | numeric | value | Enkeltparitet |
| `FAMILIE_PARITET` | numeric | value | Familieparitet |
| `MEDICINSK_PARITET` | numeric | value | Medicinsk paritet |
| `DEMOGRAFISK_SPACING` | numeric | value | Demografisk afstand mellem børn |
| `ENKELT_SPACING` | numeric | value |  |
| `FAMILIE_SPACING` | numeric | value |  |
| `MEDICINSK_SPACING` | numeric | value |  |
| `CPRTJEK` | character | code | CPR-tjek |
| `CPRTYPE` | character | code | CPR-type |
| `VERSION` | character | value | Moduldata version |

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
