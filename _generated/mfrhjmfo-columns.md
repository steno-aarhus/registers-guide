<!-- Generated from schema/registers/mfrhjmfo.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`FK_MFR`** | character | join key |  |

<details>
<summary>All other columns (31)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`CPR_MODER`** | character | join key |  |  |
| `FOEDSELSDATO` | date | date |  |  |
| `FOEDSELSKLOKKESLAET` | character | value |  |  |
| `KOEN_BARN` | character | code |  |  |
| `LEVENDE_ELLER_DOEDFOEDT` | character | code |  |  |
| `ENKELT_ELLER_FLERFOLDSFOEDSEL` | character | code |  |  |
| `BARNSNUMMER_FLERFOLDSFOEDSEL` | numeric | value |  | 1997 to 2008 |
| `GESTATIONSALDER_UGER` | numeric | value |  |  |
| `GESTATIONSALDER_DAGE_EFTER_UGER` | numeric | value |  |  |
| `TERMINSDATO` | date | date |  |  |
| `PARITET` | numeric | value |  |  |
| `NORMAL_GRAVIDITET` | character | code |  | 2002 to 2018 |
| `RISIKOFAKTORER` | character | value |  |  |
| `RYGERSTATUS_MODER` | character | code |  |  |
| `VAEGT_BARN` | numeric | value |  |  |
| `LAENGDE_BARN` | numeric | value |  |  |
| `HOVEDOMFANG` | numeric | value |  |  |
| `ABDOMINALOMFANG` | numeric | value |  |  |
| `PLACENTAVAEGT` | numeric | value |  |  |
| `APGARSCORE_EFTER5MINUTTER` | numeric | value |  |  |
| `TEGN_PAA_ASPHXI` | character | code |  |  |
| `FOSTERPRAESENTATION` | character | code |  |  |
| `MISDANNELSER` | character | code |  |  |
| `AMNITOMI_UNDER_FOEDSEL_HSP` | character | code |  |  |
| `EPISIOTOMI` | character | code |  |  |
| `FOEDSELSKODER` | character | code |  |  |
| `BESOEGHOSJORDEMODER` | character | value |  |  |
| `BESOEGHOSLAEGE` | character | value |  |  |
| `BESOEGHOSSPECIALLAEGE` | character | value |  |  |
| `INSTITUTION_INTERN` | character | code |  |  |
| `TIMES` | numeric | value |  |  |

- **`KOEN_BARN`:** Value codes not given by DST's page - not confirmed to share `koen` or `mfr_koen`'s encoding.
- **`BARNSNUMMER_FLERFOLDSFOEDSEL`:** Not continuously available across its own 1997-2008 window: check per-year before assuming this column exists for a given year.
- **`GESTATIONSALDER_DAGE_EFTER_UGER`:** The remainder days beyond GESTATIONSALDER_UGER's whole weeks, by the variable name.
- **`TERMINSDATO`:** Estimated due date, by the variable name. Not available for year 2000 specifically.
- **`RISIKOFAKTORER`:** Not available for year 2003 specifically.
- **`RYGERSTATUS_MODER`:** The mother's smoking status for home births specifically. Not confirmed to share `tobaksforbrug`'s DUT*/RGAB* SKS coding: this register predates the 2019+ restructuring entirely and DST's page gives no value definitions to check against.
- **`TEGN_PAA_ASPHXI`:** Signs of asphyxia (birth asphyxia), by the variable name.
- **`FOSTERPRAESENTATION`:** Fetal presentation for home births specifically. Not confirmed to share `mfr_fosterpraesentation`'s DUP*/RGAD* SKS coding: this register predates the 2019+ restructuring entirely.
- **`MISDANNELSER`:** Congenital malformations, by the variable name.
- **`AMNITOMI_UNDER_FOEDSEL_HSP`:** Membrane rupture during labour (HSP), by the variable name - the same induction method mfr_nyfoedte.yaml's Igangsaettelse_HSP describes for the 2019+ era.
- **`FOEDSELSKODER`:** Plural in name; likely holds more than one delivery-related code per row rather than a single simple value, but this is not confirmed.
- **`BESOEGHOSJORDEMODER`:** Visit(s) to a midwife, by the variable name.
- **`BESOEGHOSLAEGE`:** Visit(s) to a doctor (general practitioner), by the variable name.
- **`BESOEGHOSSPECIALLAEGE`:** Visit(s) to a specialist doctor, by the variable name.
- **`TIMES`:** Hours, by the variable name - possibly labour duration, not confirmed.

</details>

*No published source gives a data type for 32 of these 32 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `FK_MFR`.

**Joins to other registers:**

- `FK_MFR` joins to **MFR** (one-to-one).
- `CPR_MODER` joins to **BEF** (many-to-one).

**Worth knowing:**

- **`FK_MFR`:** By its name, a foreign key back to mfr.yaml's own row for this birth. The exact column it matches on mfr.yaml's side (assumed here to be cpr_barn, mfr.yaml's own join_keys) is not confirmed by either variable list, since neither page documents the join.
