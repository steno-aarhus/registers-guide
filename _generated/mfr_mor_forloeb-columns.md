<!-- Generated from schema/registers/mfr_mor_forloeb.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_Foedsel`** | character | join key | Birth event key |

<details>
<summary>All other columns (29)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `ForloebLabel` | character | code | Course-element label |
| `AfslutningsMaade` | character | code | How the course element ended |
| `ForloebReferenceMaade` | character | code | How the course element was referenced |
| `StartDato_Forloeb` | date | date | Course-element start date |
| `StartTidspunkt_Forloeb` | character | value | Course-element start time |
| `SlutDato_Forloeb` | date | date | Course-element end date |
| `SlutTidspunkt_Forloeb` | character | value | Course-element end time |
| `HenvisningMaade` | character | code | Referral method |
| `HenvisningsDiagnose` | character | code | Referral diagnosis |
| `Dato_Henvisning` | date | date | Referral date |
| `Tidspunkt_Henvisning` | character | value | Referral time |
| `AnsvarligRegion_Geo_Kode` | character | code | Geographic region of the responsible unit (code) |
| `AnsvarligRegion_Geo_Tekst` | character | derived | Geographic region of the responsible unit (text) |
| `AnsvarligRegion_Org_Kode` | character | code | Organisational region of the responsible unit (code) |
| `AnsvarligRegion_Org_Tekst` | character | derived | Organisational region of the responsible unit (text) |
| `AnsvarligInstitution_Kode` | character | code | Responsible institution (code) |
| `AnsvarligInstitution_Tekst` | character | derived | Responsible institution (text) |
| `AnsvarligInstitution_KodeType` | character | code | Code type of AnsvarligInstitution_Kode |
| `EnhedensSpecialer` | character | value | Specialties of the responsible unit |
| `SOR_EjerEnhedsType` | character | code | SOR owner type (public/private) of the responsible unit |
| `SOR_EnhedsType` | character | code | SOR unit type (clinical/administrative) |
| `SOR_SundhedsInstitution` | character | code | SOR health institution code |
| `SOR_Enhed` | character | code | SOR unit code |
| `SHAK_Sygehus` | character | code | SHAK hospital code (4 characters) |
| `SHAK_Afdeling` | character | code | SHAK department code (6 characters) |
| `SHAK_Afsnit` | character | code | SHAK ward code (7 characters) |
| `IndberetningsSystem` | character | code | Reporting system for the course element |
| `PrioriteretFoedselsanmeldelse` | numeric | code | Priority birth-record indicator |
| `DW_EK_Forloeb` | character | code | LPR course-element key |

- **`AnsvarligRegion_Geo_Kode`:** Not DST's `reg` numbering - see mfr_nyfoedte.yaml's AnsvarligRegion_Geo_Kode.
- **`AnsvarligInstitution_Kode`:** SHAK before the LPR3 cutover, SOR from it - see mfr_nyfoedte.yaml's AnsvarligInstitution_Kode.
- **`PrioriteretFoedselsanmeldelse`:** Filter to `== 1` to reproduce Nyfoedte's own choice of birth contact, same logic as mfr_barn_forloeb.yaml.

</details>

**Join key:** `DW_EK_Foedsel`.

**Joins to other registers:**

- `DW_EK_Foedsel` joins to **MFR_NYFOEDTE** (many-to-one).

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

**Worth knowing:**

- **`DW_EK_Foedsel`:** Filter mfr_nyfoedte to `Foedsel == 1` before joining this table onward if you want one row per birth: otherwise a twin birth's shared DW_EK_Foedsel matches twice, once per twin.
