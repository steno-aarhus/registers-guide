<!-- Generated from schema/registers/mfr_barn_procedurer.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_Nyfoedt`** | character | join key | Newborn key |
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
| `ProducerendeRegion_Kode` | character | code | Geographic region of the producing unit (code, legacy duplicate) |
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

- **`ProcedureType_Parent`:** Narrower than the full mfr_procedure_type lookup: after the LPR3 cutover only "P" is valid here (not "I"), before it only D/P/V - an add-on cannot itself be another add-on or, post-cutover, an indication.
- **`ProducerendeRegion_Kode`:** Appears to duplicate ProducerendeRegion_Geo_Kode exactly. Check both against `colnames()` on your own delivery before assuming which one to use.
- **`ProducerendeRegion_Geo_Kode`:** Not DST's `reg` numbering - see mfr_nyfoedte.yaml's AnsvarligRegion_Geo_Kode.
- **`ProducerendeInstitution_Kode`:** SHAK before the LPR3 cutover, SOR from it - see mfr_nyfoedte.yaml's AnsvarligInstitution_Kode.
- **`PrioriteretFoedselsanmeldelse`:** Filter to `== 1` to reproduce Nyfoedte's own choice, same logic as the other satellite tables.

</details>

**Join key:** `DW_EK_Nyfoedt`.

**Joins to other registers:**

- `DW_EK_Nyfoedt` joins to **MFR_NYFOEDTE** (many-to-one).
- `DW_EK_Kontakt` joins to **MFR_BARN_KONTAKTER** (many-to-one).
- `DW_EK_Forloeb` joins to **MFR_BARN_FORLOEB** (many-to-one).

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `mfr_procedure_type` | `I` Indikation, `P` Procedure (efter LPR3) / Vigtigste operation i et operativt indgreb (før LPR3), `D` Deloperation, anden operation(er) i et operativt indgreb, `V` Vigtigste operation i en afsluttet kontakt, `+` Tillægskode, Samhørende operation eller Sideangivelse (før LPR3) / Tillægskode, Anvendt kontrast, Handlingsspecifikation, Personalekategori eller Sideangivelse (efter LPR3) |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |
| `lprindberetningssystem` | `LPR3`, `MiniPAS`, `LPR2`, `LPR1` |

- **`mfr_procedure_type`:** Reading "P" as one stable category across the whole table conflates "the main operation" (pre-LPR3, one of three specific operation roles) with "any procedure at all" (post-LPR3, the default value for most rows). This will inflate counts of "main operations" for LPR3-era rows if not checked against IndberetningsSystem first. See ProcedureType_Parent for the narrower set of types (post-LPR3: only "P"; pre-LPR3: D/P/V) that a "+" add-on can actually attach to.
- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.
- **`lprindberetningssystem`:** Confirm the exact strings with `count(lprindberetningssystem)` before relying on "LPR2" or "LPR1" in a filter: they are well-established as concepts in this guide, but nobody has pasted the literal value back from DARTER the way pitfall 5 did for "LPR3". "MiniPAS" is safe to rely on, since kont_type.yaml's coalescing logic already depends on it being exactly that string. This column is unrelated to LPR_F vs LPR_A: that choice is made before you open a file, this one lives inside the file you already chose.

Where these values come from:

- **`mfr_procedure_type`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).
- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).
- **`lprindberetningssystem`:** [No DST/Sundhedsdatastyrelsen kodeark for this column exists; the value set below is reconstructed from DARTER-team-confirmed facts already established elsewhere in this guide (this pitfalls page, and kont_type.yaml), not from a published code list.](darter-pitfalls.qmd#lpr3-lprindberetningssystem).

</details>

**Worth knowing:**

- **`ProcedureKode`:** No `code_system` attached: the SKS procedure catalogue is an open space, the same reasoning as mfr_nyfoedte.yaml's Kejsersnit column and kont_type.yaml's own reader_note on the same issue.
