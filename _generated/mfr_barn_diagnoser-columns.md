<!-- Generated from schema/registers/mfr_barn_diagnoser.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_Nyfoedt`** | character | join key | Newborn key |
| `DiagnoseKode` | character | code | Diagnosis, contact-reason, or add-on code |
| `DiagnoseType` | character | code | Diagnosis role |

<details>
<summary>All other columns (18)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `DiagnoseType_Tekst` | character | derived | Diagnosis role (text) |
| `SenereAfkraeftet` | character | code | Later disproven |
| `DiagnoseKode_Parent` | character | code | Parent diagnosis code (when DiagnoseType = +) |
| `DiagnoseType_Parent` | character | code | Role of the parent diagnosis (when DiagnoseType = +) |
| `DiagnoseType_Parent_Tekst` | character | derived | Role of the parent diagnosis, text (when DiagnoseType = +) |
| `SenereAfkraeftet_Parent` | character | code | Whether the parent diagnosis was later disproven (when DiagnoseType = +) |
| `AktionsDiagnose` | character | code | Action diagnosis of the contact this row belongs to |
| `StartDato_Kontakt` | date | date | Start date of the contact this row belongs to |
| `SlutDato_Kontakt` | date | date | End date of the contact this row belongs to |
| `ForloebLabel` | character | code | Course-element label (via the contact) |
| `StartDato_Forloeb` | date | date | Start date of the course element (via the contact) |
| `SlutDato_Forloeb` | date | date | End date of the course element (via the contact) |
| `Indberetningssystem` | character | code | Reporting system for the diagnosis |
| `PrioriteretFoedselsanmeldelse` | numeric | code | Priority birth-record indicator |
| **`DW_EK_Kontakt`** | character | join key | LPR contact key |
| `DW_EK_Forloeb` | character | code | LPR course-element key |
| `DW_ID_Hjem` | character | code | Home/clinic birth paper-form key |
| `DW_ID_Doed` | character | code | Stillbirth paper-form key |

- **`SenereAfkraeftet`:** A pre-LPR3 "Nej" here does not mean the diagnosis was verified, it means the concept of tracking retraction did not exist yet and everything defaults to "Nej". Do not treat pre- and post-cutover "Nej" as equally informative.
- **`DiagnoseType_Parent`:** A narrower set than the full mfr_diagnose_type lookup: only A/B/C/G/H/M are valid here (no K or +), since an add-on cannot itself be a contact reason or another add-on.
- **`Indberetningssystem`:** No `code_system` attached, same reasoning as mfr_nyfoedte.yaml's IndberetningsSystem_Barn: this column also covers non-LPR paper-form sources, so it is not confirmed to share `lprindberetningssystem`'s exact value set. Confirm with `count(Indberetningssystem)` before filtering on it.
- **`PrioriteretFoedselsanmeldelse`:** Filter to `== 1` to reproduce Nyfoedte's own choice, same logic as the other satellite tables.

</details>

**Join key:** `DW_EK_Nyfoedt`.

**Joins to other registers:**

- `DW_EK_Nyfoedt` joins to **MFR_NYFOEDTE** (many-to-one).
- `DW_EK_Kontakt` joins to **MFR_BARN_KONTAKTER** (many-to-one).
- `DW_EK_Forloeb` joins to **MFR_BARN_FORLOEB** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |
| `mfr_diagnose_type` | `A` Aktionsdiagnose, `B` Bidiagnose, `C` Komplikation, `G` Grundmorbus, `H` Henvisningsdiagnose, `K` Kontaktårsag, `M` Midlertidig diagnose, `+` Tillægskode, Lokal recidiv, Metastase eller Sideangivelse |

- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.
- **`mfr_diagnose_type`:** When DiagnoseType is "+", DiagnoseKode is an add-on that only makes sense attached to another diagnosis: that parent diagnosis, its own type, and whether it was later disproven live in DiagnoseKode_Parent, DiagnoseType_Parent and SenereAfkraeftet_Parent on the same row, not in DiagnoseKode itself. `tobaksforbrug`'s DUT* codes and `mfr_fosterpraesentation`'s DUP* codes are exactly this kind of "+" add-on code before the LPR3 cutover.

Where these values come from:

- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).
- **`mfr_diagnose_type`:** [Sundhedsdatastyrelsen: Dokumentation af Fødselsregisteret 2019 og frem, sheet Kolonner](https://sundhedsdatastyrelsen.dk/Media/638650989728109987/Dokumentation_Foedselsregisteret_2019_og_frem.xlsx).

</details>

**Worth knowing:**

- **`DiagnoseKode`:** `code_system: icd10` fits the diagnosis case only: this column also holds non-ICD-10 SKS add-on and contact-reason codes (see DiagnoseType), which will not resolve against the ICD-10 lookup. Check DiagnoseType before assuming a value here is a diagnosis.
