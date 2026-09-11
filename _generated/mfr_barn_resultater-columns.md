<!-- Generated from schema/registers/mfr_barn_resultater.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_Nyfoedt`** | character | join key | Newborn key |
| `ResultatType` | character | code | Result type |

<details>
<summary>All other columns (32)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `ResultatIndberetningsType` | character | code | Result-report type |
| `ResultatIndberetningsStatus` | character | code | Result-report status (complete/incomplete) |
| `ResultatVaerdi` | character | value | Result value (polymorphic) |
| `Dato_Resultat` | date | date | Result date |
| `Tidspunkt_Resultat` | character | value | Result time |
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
| `AktionsDiagnose` | character | code | Action diagnosis of the contact this result belongs to |
| `StartDato_Kontakt` | date | date | Start date of the contact this result belongs to |
| `SlutDato_Kontakt` | date | date | End date of the contact this result belongs to |
| `ForloebLabel` | character | code | Course-element label |
| `StartDato_Forloeb` | date | date | Start date of the course element |
| `SlutDato_Forloeb` | date | date | End date of the course element |
| `IndberetningsSystem` | character | code | Reporting system for the result |
| `PrioriteretFoedselsanmeldelse` | numeric | code | Priority birth-record indicator |
| `DW_EK_Kontakt` | character | code | LPR contact key |
| `DW_EK_Forloeb` | character | code | LPR course-element key |
| `DW_ID_Hjem` | character | code | Home/clinic birth paper-form key |
| `DW_ID_Doed` | character | code | Stillbirth paper-form key |

- **`ResultatIndberetningsStatus`:** Several of mfr_nyfoedte's own resolved columns (Tobaksforbrug, Vaegt_Barn, Hoejde_Mor, and others) prioritise "komplet" (RAS01) results over "inkomplet" (RAS00) ones when more than one result exists for the same fact. Reproducing that resolution logic yourself means checking this column, not just the newest result.
- **`ResultatVaerdi`:** Reading this column as one consistent type will fail or silently coerce: for a `ResultatType` of RDA39 (weight) it is an integer number of grams, for RDA25 (smoking) or RDA41 (birthplace) it is itself an SKS code (RGAB*/RGAE*), for some boolean-style results 0 means "unknown" rather than "false" (not the usual R convention). Branch on `ResultatType` before parsing `ResultatVaerdi`, never parse it generically across the whole table.
- **`AnsvarligRegion_Geo_Kode`:** Not DST's `reg` numbering - see mfr_nyfoedte.yaml's AnsvarligRegion_Geo_Kode.
- **`AnsvarligInstitution_Kode`:** SHAK before the LPR3 cutover, SOR from it, local code for paper-form results - see mfr_nyfoedte.yaml's AnsvarligInstitution_Kode for the SHAK/SOR half.
- **`IndberetningsSystem`:** No `code_system` attached, same reasoning as the diagnosis tables' IndberetningsSystem: this column includes paper-form sources, unlike Forloeb/Kontakter/Procedurer's version which only exemplifies LPR2/LPR3.
- **`PrioriteretFoedselsanmeldelse`:** Filter to `== 1` to reproduce Nyfoedte's own choice, same logic as the other satellite tables.

</details>

**Join key:** `DW_EK_Nyfoedt`.

**Joins to other registers:**

- `DW_EK_Nyfoedt` joins to **MFR_NYFOEDTE** (many-to-one).
- `DW_EK_Kontakt` joins to **MFR_BARN_KONTAKTER** (many-to-one).
- `DW_EK_Forloeb` joins to **MFR_BARN_FORLOEB** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |

- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.

Where these values come from:

- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).

</details>

**Worth knowing:**

- **`ResultatType`:** No `code_system` attached: this is an open SKS result-type catalogue, not a small enumerated set, the same reasoning as ProcedureKode. Each RDAnn value determines both what ResultatVaerdi means and what data type it holds - see that column's reader_note.
