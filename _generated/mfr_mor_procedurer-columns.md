<!-- Generated from schema/registers/mfr_mor_procedurer.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_Foedsel`** | character | join key | Birth event key |
| `ProcedureKode` | character | code | Procedure, add-on, or indication code |
| `ProcedureType` | character | code | Procedure role |

<details>
<summary>All other columns (34)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `ProcedureType_Tekst` | character | derived | Procedure role (text) |
| `ProcedureKode_Parent` | character | code | Parent procedure code (when ProcedureType = +) |
| `ProcedureType_Parent` | character | code | Role of the parent procedure (when ProcedureType = +) |
| `ProcedureType_Parent_Tekst` | character | derived | Role of the parent procedure, text (when ProcedureType = +) |
| `StartDato_Procedure` | date | date | Procedure start date |
| `StartTidspunkt_Procedure` | character | value | Procedure start time |
| `SlutDato_Procedure` | date | date | Procedure end date |
| `SlutTidspunkt_Procedure` | character | value | Procedure end time |
| `ProducerendeRegion_Geo_Kode` | character | code | Geographic region of the producing unit (code) |
| `ProducerendeRegion_Geo_Tekst` | character | derived | Geographic region of the producing unit (text) |
| `ProducerendeRegion_Org_Kode` | character | code | Organisational region of the producing unit (code) |
| `ProducerendeRegion_Org_Tekst` | character | derived | Organisational region of the producing unit (text) |
| `ProducerendeInstitution_Kode` | character | code | Producing institution (code) |
| `ProducerendeInstitution_Tekst` | character | derived | Producing institution (text) |
| `ProducerendeInstitution_KodeType` | character | code | Code type of ProducerendeInstitution_Kode |
| `EnhedensSpecialer` | character | value | Specialties of the producing unit |
| `SOR_EjerEnhedsType` | character | code | SOR owner type (public/private) of the producing unit |
| `SOR_EnhedsType` | character | code | SOR unit type (clinical/administrative) |
| `SOR_SundhedsInstitution` | character | code | SOR health institution code |
| `SOR_Enhed` | character | code | SOR unit code |
| `SHAK_Sygehus` | character | code | SHAK hospital code (4 characters) |
| `SHAK_Afdeling` | character | code | SHAK department code (6 characters) |
| `SHAK_Afsnit` | character | code | SHAK ward code (7 characters) |
| `AktionsDiagnose` | character | code | Action diagnosis of the contact this procedure belongs to |
| `StartDato_Kontakt` | date | date | Start date of the contact this procedure belongs to |
| `SlutDato_Kontakt` | date | date | End date of the contact this procedure belongs to |
| `ForloebLabel` | character | code | Course-element label |
| `StartDato_Forloeb` | date | date | Start date of the course element |
| `SlutDato_Forloeb` | date | date | End date of the course element |
| `IndberetningsSystem` | character | code | Reporting system for the procedure |
| `PrioriteretFoedselsanmeldelse` | numeric | code | Priority birth-record indicator |
| `DW_EK_Kontakt` | character | code | LPR contact key |
| `DW_EK_Forloeb` | character | code | LPR course-element key |
| `DW_ID_Hjem` | character | code | Home/clinic birth paper-form key |

- **`ProcedureType_Parent`:** Narrower set, same as mfr_barn_procedurer.yaml's ProcedureType_Parent.
- **`ProducerendeRegion_Geo_Kode`:** Not DST's `reg` numbering - see mfr_nyfoedte.yaml's AnsvarligRegion_Geo_Kode.
- **`ProducerendeInstitution_Kode`:** SHAK before the LPR3 cutover, SOR from it, local code for paper-form procedures - see mfr_nyfoedte.yaml's AnsvarligInstitution_Kode for the SHAK/SOR half.
- **`IndberetningsSystem`:** Unlike mfr_barn_procedurer.yaml's IndberetningsSystem (examples only LPR2/LPR3), this column's examples include paper-form sources, so no `code_system` is attached - not confirmed to share `lprindberetningssystem`'s exact value set.
- **`PrioriteretFoedselsanmeldelse`:** Filter to `== 1` to reproduce Nyfoedte's own choice, same logic as the other satellite tables.

</details>

**Join key:** `DW_EK_Foedsel`.

**Joins to other registers:**

- `DW_EK_Foedsel` joins to **MFR_NYFOEDTE** (many-to-one).
- `DW_EK_Kontakt` joins to **MFR_MOR_KONTAKTER** (many-to-one).
- `DW_EK_Forloeb` joins to **MFR_MOR_FORLOEB** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `mfr_procedure_type` | `I` Indikation, `P` Procedure (efter LPR3) / Vigtigste operation i et operativt indgreb (før LPR3), `D` Deloperation, anden operation(er) i et operativt indgreb, `V` Vigtigste operation i en afsluttet kontakt, `+` Tillægskode, Samhørende operation eller Sideangivelse (før LPR3) / Tillægskode, Anvendt kontrast, Handlingsspecifikation, Personalekategori eller Sideangivelse (efter LPR3) |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |

- **`mfr_procedure_type`:** Reading "P" as one stable category across the whole table conflates "the main operation" (pre-LPR3, one of three specific operation roles) with "any procedure at all" (post-LPR3, the default value for most rows). This will inflate counts of "main operations" for LPR3-era rows if not checked against IndberetningsSystem first. See ProcedureType_Parent for the narrower set of types (post-LPR3: only "P"; pre-LPR3: D/P/V) that a "+" add-on can actually attach to.
- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.

Where these values come from:

- **`mfr_procedure_type`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).
- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).

</details>

**Worth knowing:**

- **`ProcedureKode`:** No `code_system` attached, same reasoning as mfr_barn_procedurer.yaml's ProcedureKode.
