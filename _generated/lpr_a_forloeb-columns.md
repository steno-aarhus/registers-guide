<!-- Generated from schema/registers/lpr_a_forloeb.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_FORLOEB`** | character | join key | Course identifier |
| **`PNR`** | character | join key | Personal identification number |

<details>
<summary>All other columns (33)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `DW_EK_BORGER` | character | code | Citizen identifier |
| `CPRTJEK` | character | code | CPR check code |
| `CPRTYPE` | character | code | CPR type code |
| `DW_EK_FORLOEB_FORRIGE` | character | code | Previous course identifier |
| `DW_EK_HELBREDSFORLOEB` | character | code | Health course identifier |
| `HELBREDSFORL_STARTTIDSPUNKT` | date | date | Health course start |
| `HELBREDSFORL_SLUTTIDSPUNKT` | date | date | Health course end |
| `FORL_STARTTIDSPUNKT` | date | date | Course start |
| `FORL_SLUTTIDSPUNKT` | date | date | Course end |
| `FORL_INDB_TIDSPUNKT` | date | date | Course reporting time |
| `FORL_LABEL` | character | code | Course label code |
| `FORL_LABEL_TEKST` | character | derived | Course label, text |
| `FORL_REF_TYPE` | character | code | Course reference type code |
| `FORL_REF_TYPE_TEKST` | character | derived | Course reference type, text |
| `FORL_AFSLUT_MAADE` | character | code | Course end method code |
| `FORL_AFSLUT_MAADE_TEKST` | character | derived | Course end method, text |
| `FORL_HENV_TIDSPUNKT` | date | date | Referral time |
| `FORL_HENV_MAADE` | character | code | Referral method code |
| `FORL_HENV_MAADE_TEKST` | character | derived | Referral method, text |
| `FORL_HENV_AARSAG` | character | code | Referral reason (diagnosis) code |
| `FORL_HENV_AARSAG_TEKST` | character | derived | Referral reason, text |
| `FORL_HENV_INSTANS` | character | code | Referring authority code |
| `FORL_FRITVALG` | character | code | Free hospital choice indicator |
| `FORL_FRITVALG_TEKST` | character | derived | Free hospital choice, text |
| `FORL_ANS` | character | code | Responsible unit code |
| `FORL_ANS_INST` | character | code | Responsible institution code |
| `FORL_INST_EJERTYPE` | character | code | Responsible institution owner type |
| `FORL_ANS_GEO_REG` | character | code | Responsible region code (geographic) |
| `FORL_ANS_GEO_REG_TEKST` | character | derived | Responsible region, text |
| `FORL_ANS_ORG_REG` | character | code | Responsible region code (organisational) |
| `FORL_ANS_ORG_REG_TEKST` | character | derived | Responsible region, text |
| `FORL_LPR_ENTITY_ID` | character | code | LPR entity ID |
| `LPRINDBERETNINGSSYSTEM` | character | code | Reporting system |

- **`DW_EK_BORGER`:** A citizen data-warehouse key alongside the plain PNR - LPR3's own internal identifier.
- **`DW_EK_FORLOEB_FORRIGE`:** The previous course element in a chain, by the variable name (forrige = previous) - lets course elements be linked into one longer episode.
- **`DW_EK_HELBREDSFORLOEB`:** A higher-level 'health course' grouping above the individual course element (helbredsforloeb = health course), with its own start/end below.
- **`FORL_INDB_TIDSPUNKT`:** Reporting (indberetning) timestamp, distinct from the course element's own start/end.
- **`FORL_LABEL`:** SKS course-element label, the general-population equivalent of mfr_barn_forloeb.yaml's ForloebLabel.
- **`FORL_REF_TYPE`:** How the course element was referenced, the general-population equivalent of mfr_barn_forloeb.yaml's ForloebReferenceMaade.
- **`FORL_AFSLUT_MAADE`:** How the course element ended, the general-population equivalent of mfr_barn_forloeb.yaml's AfslutningsMaade.
- **`FORL_HENV_TIDSPUNKT`:** Referral (henvisning) timestamp.
- **`FORL_HENV_MAADE`:** Referral method, the general-population equivalent of mfr_barn_forloeb.yaml's HenvisningMaade.
- **`FORL_HENV_AARSAG`:** Referral diagnosis (aarsag = reason), the general-population equivalent of mfr_barn_forloeb.yaml's HenvisningsDiagnose.
- **`FORL_HENV_INSTANS`:** The referring authority/instance (instans), by the variable name.
- **`FORL_FRITVALG`:** Free-hospital-choice (frit sygehusvalg) indicator, by the variable name. LPR2 had its own dedicated table for the same concept, LPR_FRITVALG, covering only 2004-2008 (extended free choice, treatment at a private hospital under the waiting-time guarantee) - not modelled as a separate register here. A study spanning both eras needs to check whether the underlying scheme/eligibility rules were the same across the gap between 2008 and this column's own coverage, not just whether a similarly-named column exists on both sides.
- **`FORL_ANS`:** Responsible (ansvarlig) unit code, the general-population equivalent of mfr_barn_forloeb.yaml's AnsvarligInstitution_Kode.
- **`FORL_INST_EJERTYPE`:** Owner type (ejertype) of the responsible institution - public/private, the general-population equivalent of mfr_barn_forloeb.yaml's SOR_EjerEnhedsType.
- **`FORL_ANS_GEO_REG`:** Not confirmed to share DST's own `reg` numbering - see mfr_nyfoedte.yaml's AnsvarligRegion_Geo_Kode for the same caution on an analogous column.

</details>

*No published source gives a data type for 35 of these 35 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `PNR`.

**Joins to other registers:**

- `PNR` joins to **BEF** (many-to-one).
- `DW_EK_FORLOEB` joins to **LPR_A_KONTAKT** (one-to-many).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |
| `lprindberetningssystem` | `LPR3`, `MiniPAS`, `LPR2`, `LPR1` |

- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.
- **`lprindberetningssystem`:** Confirm the exact strings with `count(lprindberetningssystem)` before relying on "LPR2" or "LPR1" in a filter: they are well-established as concepts in this guide, but nobody has pasted the literal value back from DARTER the way pitfall 5 did for "LPR3". "MiniPAS" is safe to rely on, since kont_type.yaml's coalescing logic already depends on it being exactly that string. This column is unrelated to LPR_F vs LPR_A: that choice is made before you open a file, this one lives inside the file you already chose.

Where these values come from:

- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).
- **`lprindberetningssystem`:** [No DST/Sundhedsdatastyrelsen kodeark for this column exists; the value set below is reconstructed from DARTER-team-confirmed facts already established elsewhere in this guide (this pitfalls page, and kont_type.yaml), not from a published code list.](darter-pitfalls.qmd#lpr3-lprindberetningssystem).

</details>
