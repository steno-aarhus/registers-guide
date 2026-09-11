<!-- Generated from schema/registers/mfr_barn_kontakter.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`DW_EK_Nyfoedt`** | character | join key | Newborn key |
| `StartDato_Kontakt` | date | date | Contact start date |

<details>
<summary>All other columns (37)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `AktionsDiagnose` | character | code | Action diagnosis |
| `KontaktAarsag` | character | code | Contact reason |
| `Prioritet` | character | code | Priority (acute/planned) |
| `KontaktType` | character | code | Contact type |
| `StartTidspunkt_Kontakt` | character | value | Contact start time |
| `SlutDato_Kontakt` | date | date | Contact end date |
| `SlutTidspunkt_Kontakt` | character | value | Contact end time |
| `Alder_Ind_Aar` | numeric | value | Child's age in years at contact start |
| `Alder_Ind_Dage` | numeric | value | Child's age in days at contact start |
| `Alder_Ud_Aar` | numeric | value | Child's age in years at contact end |
| `Alder_Ud_Dage` | numeric | value | Child's age in days at contact end |
| `HenvisningsMaade` | character | code | Referral method |
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
| `ForloebLabel` | character | code | Course-element label the contact belongs to |
| `StartDato_Forloeb` | date | date | Start date of the course element the contact belongs to |
| `SlutDato_Forloeb` | date | date | End date of the course element the contact belongs to |
| `IndberetningsSystem` | character | code | Reporting system for the contact |
| `PrioriteretFoedselsanmeldelse` | numeric | code | Priority birth-record indicator |
| **`DW_EK_Kontakt`** | character | join key | LPR contact key |
| `DW_EK_Forloeb` | character | code | LPR course-element key this contact belongs to |

- **`AnsvarligRegion_Geo_Kode`:** Not DST's `reg` numbering - see mfr_nyfoedte.yaml's AnsvarligRegion_Geo_Kode.
- **`AnsvarligInstitution_Kode`:** SHAK before the LPR3 cutover, SOR from it - see mfr_nyfoedte.yaml's AnsvarligInstitution_Kode.
- **`PrioriteretFoedselsanmeldelse`:** Filter to `== 1` to reproduce Nyfoedte's own choice of birth contact when a child has more than one candidate. Same logic as mfr_barn_forloeb.yaml's column of the same name.
- **`DW_EK_Kontakt`:** Same key space as lpr_a_kontakt's dw_ek_kontakt: a birth-related contact found here should also be findable there, if you need LPR detail this satellite table does not carry.

</details>

**Join key:** `DW_EK_Nyfoedt`.

**Joins to other registers:**

- `DW_EK_Nyfoedt` joins to **MFR_NYFOEDTE** (many-to-one).
- `DW_EK_Forloeb` joins to **MFR_BARN_FORLOEB** (many-to-one).

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |
| `kont_type` | Not listed here - see [DST's classification](https://cdn1.gopublic.dk/sundhedsdatastyrelsen/media/15700/LPR_indberetningsvejledning_v.1.2.pdf) |
| `lprindberetningssystem` | `LPR3`, `MiniPAS`, `LPR2`, `LPR1` |

- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.
- **`kont_type`:** `ALCA00` means physical attendance, which is the closest LPR3 gets to LPR2's inpatient flag. It marks attendance, not admission, so a study that treats it as "was admitted" will include outpatient visits. Check what your own delivery holds before filtering: single digits and SKS codes have been seen side by side in the same year, so `kont_type == "ALCA00"` can silently drop rows that are the same kind of contact recorded in the other form. Cross-tabulate it against `lprindberetningssystem` first. MiniPAS was the route private providers reported through, so the two forms are not only two notations, they are also two different parts of the health service.
- **`lprindberetningssystem`:** Confirm the exact strings with `count(lprindberetningssystem)` before relying on "LPR2" or "LPR1" in a filter: they are well-established as concepts in this guide, but nobody has pasted the literal value back from DARTER the way pitfall 5 did for "LPR3". "MiniPAS" is safe to rely on, since kont_type.yaml's coalescing logic already depends on it being exactly that string. This column is unrelated to LPR_F vs LPR_A: that choice is made before you open a file, this one lives inside the file you already chose.

Where these values come from:

- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).
- **`kont_type`:** [Vejledning til indberetning til LPR3](https://cdn1.gopublic.dk/sundhedsdatastyrelsen/media/15700/LPR_indberetningsvejledning_v.1.2.pdf), published on [medinfo.dk](https://medinfo.dk/sks/brows.php).
- **`lprindberetningssystem`:** [No DST/Sundhedsdatastyrelsen kodeark for this column exists; the value set below is reconstructed from DARTER-team-confirmed facts already established elsewhere in this guide (this pitfalls page, and kont_type.yaml), not from a published code list.](darter-pitfalls.qmd#lpr3-lprindberetningssystem).

</details>
