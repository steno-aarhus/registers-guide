<!-- Generated from schema/registers/mfrdfoed.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`FK_MFR`** | character | join key |  |
| `LEVENDE_ELLER_DOEDFOEDT` | character | code |  |

<details>
<summary>All other columns (17)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`CPR_MODER`** | character | join key |  |
| **`CPR_FADER`** | character | join key |  |
| `FOEDSELSDATO` | date | date |  |
| `FOEDSELSKLOKKESLAET` | character | value |  |
| `KOEN_BARN` | character | code |  |
| `BARNSNUMMER_FLERFOLDSFOEDSEL` | numeric | value |  |
| `GESTATIONSALDER_UGER` | numeric | value |  |
| `GESTATIONSALDER_DAGE_EFTER_UGER` | numeric | value |  |
| `FOSTERPRAESENTATION` | character | code |  |
| `VAEGT_BARN` | numeric | value |  |
| `LAENGDE_BARN` | numeric | value |  |
| `HOVEDOMFANG` | numeric | value |  |
| `ABDOMINALOMFANG` | numeric | value |  |
| `PLACENTAVAEGT` | numeric | value |  |
| `MISDANNELSER` | character | code |  |
| `SYGEHUS` | character | code |  |
| `BEMAERKNING` | character | value |  |

- **`CPR_FADER`:** The father's CPR-number - a column mfr.yaml and mfrhjmfo.yaml do not carry, specific to this stillbirth-detail table.
- **`KOEN_BARN`:** Value codes not given by DST's page - not confirmed to share `koen` or `mfr_koen`'s encoding.
- **`BARNSNUMMER_FLERFOLDSFOEDSEL`:** The child's number within a multiple birth, by the variable name - matching mfrhjmfo.yaml's own BARNSNUMMER_FLERFOLDSFOEDSEL.
- **`FOSTERPRAESENTATION`:** Not confirmed to share mfr_fosterpraesentation.yaml's DUP*/RGAD* SKS coding - this register predates the 2019+ restructuring entirely.
- **`MISDANNELSER`:** Congenital malformations, by the variable name - matching mfrhjmfo.yaml's own MISDANNELSER.
- **`SYGEHUS`:** A hospital identifier, unencoded by name - not confirmed whether this is a SHAK code or something else, DST's page does not say.
- **`BEMAERKNING`:** A free-text remark field, by the variable name (bemærkning = remark/comment).

</details>

*No published source gives a data type for 19 of these 19 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `FK_MFR`.

**Joins to other registers:**

- `FK_MFR` joins to **MFR** (one-to-one).
- `CPR_MODER` joins to **BEF** (many-to-one).

**Worth knowing:**

- **`FK_MFR`:** Foreign key back to mfr.yaml, same pattern as mfrhjmfo.yaml - not confirmed to match mfr's own cpr_barn specifically.
- **`LEVENDE_ELLER_DOEDFOEDT`:** Present here too even though this register is specifically the stillbirth detail table - presumably always "stillbirth" for every row, but not confirmed as a constant by DST's documentation.
