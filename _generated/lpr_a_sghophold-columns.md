<!-- Generated from schema/registers/lpr_a_sghophold.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_SYGEHUSOPHOLD`** | character | join key | Hospital stay identifier |
| **`PNR`** | character | join key | Personal identification number |

<details>
<summary>All other columns (23)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `DW_SK_SYGEHUSOPHOLD` | character | code | Hospital stay surrogate key |
| `DW_EK_BORGER` | character | code | Citizen identifier |
| `CPRTJEK` | character | code | CPR check code |
| `CPRTYPE` | character | code | CPR type code |
| `BORGER_KOEN` | character | code | Citizen sex code |
| `BORGER_ALDER_AAR_IND` | numeric | value | Age in years at admission |
| `BORGER_BO_REG_UD` | character | code | Region of residence at discharge |
| `SGH_OPH_ORG_REG_UD` | character | code | Organisational region at discharge |
| `SGH_OPH_STARTTIDSPUNKT` | date | date | Hospital stay start |
| `SGH_OPH_SLUTTIDSPUNKT` | date | date | Hospital stay end |
| `SGH_OPH_TYPE` | character | code | Hospital stay type code |
| `SGH_OPH_PRIORITET` | character | code | Hospital stay priority code |
| `BEH_TYPE_SGH_OPH` | character | code | Treatment type code |
| `FLAG_BEH_TYPE_PSYKIATRI` | character | code | Psychiatric treatment flag |
| `FLAG_BEH_TYPE_SOMATIK` | character | code | Somatic treatment flag |
| `FLAG_SGH_TYPE_HOSP` | character | code | Hospital facility flag |
| `FLAG_SGH_TYPE_OFF` | character | code | Public facility flag |
| `FLAG_SGH_TYPE_PRV` | character | code | Private facility flag |
| `FLAG_SGH_OPH_FINANSIERING_OFF` | character | code | Public financing flag |
| `FLAG_SGH_OPH_FINANSIERING_PRV` | character | code | Private financing flag |
| `ANTAL_KONT_SGH_OPH` | numeric | value | Number of contacts in the stay |
| **`DW_EK_KONTAKT_FOERSTE`** | character | join key | First contact identifier |
| **`DW_EK_KONTAKT_SIDSTE`** | character | join key | Last contact identifier |

- **`DW_SK_SYGEHUSOPHOLD`:** A surrogate key distinct from DW_EK_SYGEHUSOPHOLD - the SK/EK distinction is not documented, matching mfr_nyfoedte.yaml's own dw_sk_sygehusophold column on lpr_a_kontakt.
- **`BORGER_KOEN`:** Not confirmed to share `koen`'s numeric or `mfr_koen`'s letter encoding.
- **`BORGER_ALDER_AAR_IND`:** Age in years at admission (ind = indlaeggelse), by the variable name.
- **`BORGER_BO_REG_UD`:** Region of residence at discharge (ud = udskrivelse), by the variable name. Not confirmed to share `reg`'s numbering.
- **`SGH_OPH_PRIORITET`:** Priority (acute/planned), the same concept as lpr_a_kontakt's own Prioritet column.
- **`BEH_TYPE_SGH_OPH`:** Treatment type (behandling) for the stay - see the two FLAG_BEH_TYPE_* columns below for the psychiatric/somatic split of the same concept.
- **`FLAG_BEH_TYPE_PSYKIATRI`:** Whether this stay was psychiatric treatment, by the variable name.
- **`FLAG_BEH_TYPE_SOMATIK`:** Whether this stay was somatic treatment, by the variable name.
- **`FLAG_SGH_TYPE_HOSP`:** Whether the responsible facility was a hospital, by the variable name - see FLAG_SGH_TYPE_OFF/_PRV for the public/private split.
- **`FLAG_SGH_TYPE_OFF`:** Public (offentlig) facility indicator.
- **`FLAG_SGH_TYPE_PRV`:** Private facility indicator - together with the two columns above this distinguishes public/private hospital/non-hospital care in one stay, the same distinction the newly found PRIV_* register family (not in this schema) covers in full for private hospitals specifically.
- **`FLAG_SGH_OPH_FINANSIERING_OFF`:** Public financing (finansiering) of the stay, distinct from who ran the facility (FLAG_SGH_TYPE_*).
- **`FLAG_SGH_OPH_FINANSIERING_PRV`:** Private financing of the stay.
- **`ANTAL_KONT_SGH_OPH`:** Number of lpr_a_kontakt rows grouped into this one stay - the count that makes this table more than a simple first/last-contact wrapper.
- **`DW_EK_KONTAKT_FOERSTE`:** The first (foerste) contact in the stay - joins to lpr_a_kontakt.
- **`DW_EK_KONTAKT_SIDSTE`:** The last (sidste) contact in the stay.

</details>

*No published source gives a data type for 25 of these 25 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `PNR`.

**Joins to other registers:**

- `PNR` joins to **BEF** (many-to-one).
- `DW_EK_KONTAKT_FOERSTE` joins to **LPR_A_KONTAKT** (one-to-one).
