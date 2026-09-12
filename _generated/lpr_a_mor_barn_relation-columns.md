<!-- Generated from schema/registers/lpr_a_mor_barn_relation.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_MOR_BARN_RELATION`** | character | join key | Mother-child relation identifier |
| **`PNR_BARN`** | character | join key | Child's personal identification number |
| **`PNR_MOR`** | character | join key | Mother's personal identification number |

<details>
<summary>All other columns (13)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `DW_EK_BORGER_BARN` | character | code | Child's citizen identifier |
| `DW_EK_BORGER_MOR` | character | code | Mother's citizen identifier |
| `BORGER_KOEN_BARN` | character | code | Child's sex code |
| **`DW_EK_FORLOEB_BARN`** | character | join key | Child's course identifier |
| **`DW_EK_FORLOEB_MOR`** | character | join key | Mother's course identifier |
| `FORL_LABEL_BARN` | character | code | Child's course label code |
| `FORL_LABEL_BARN_TEKST` | character | derived | Child's course label, text |
| `FORL_LABEL_MOR` | character | code | Mother's course label code |
| `FORL_LABEL_MOR_TEKST` | character | derived | Mother's course label, text |
| `FORL_REF_TYPE_BARN` | character | code | Child's course reference type code |
| `FORL_REF_TYPE_BARN_TEKST` | character | derived | Child's course reference type, text |
| `CPRTJEK` | character | code | CPR check code |
| `CPRTYPE` | character | code | CPR type code |

- **`DW_EK_BORGER_BARN`:** A citizen data-warehouse key for the child, alongside the plain PNR_BARN - LPR3's own internal identifier, not something to join other registers on directly.
- **`BORGER_KOEN_BARN`:** The child's sex. Not confirmed to share `koen`'s numeric or `mfr_koen`'s letter encoding - DST gives no value definition here.
- **`DW_EK_FORLOEB_BARN`:** The child's LPR3 course-element key - joins to lpr_a_kontakt's own course-element references.
- **`DW_EK_FORLOEB_MOR`:** The mother's LPR3 course-element key.
- **`FORL_LABEL_BARN`:** An SKS course-label code for the child's course element, the same concept as mfr_barn_forloeb.yaml's own ForloebLabel.
- **`FORL_LABEL_BARN_TEKST`:** The text label for FORL_LABEL_BARN - this _TEKST-suffix pattern (a code column plus its own derived-text sibling) recurs across most other columns in this register and the rest of the LPR_A_* family newly found in this same pass.
- **`FORL_REF_TYPE_BARN`:** How the child's course element is referenced, the same concept as mfr_barn_forloeb.yaml's own ForloebReferenceMaade.
- **`CPRTJEK`:** Same name as ftbarn.yaml's own CPRTJEK - not confirmed to share its meaning or values, DST documents neither.

</details>

*No published source gives a data type for 16 of these 16 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `PNR_BARN`, `PNR_MOR`.

**Joins to other registers:**

- `PNR_BARN` joins to **BEF** (many-to-one).
- `PNR_MOR` joins to **BEF** (many-to-one).
- `PNR_BARN` joins to **MFR_NYFOEDTE** (one-to-one).
