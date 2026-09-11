<!-- Generated from schema/registers/lpr_a_diagnose.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`dw_ek_kontakt`** | character | join key | Contact identifier |
| `diag_kode` | character | code | Diagnosis code |
| `diag_kode_type` | character | code | Diagnosis type |
| `senere_afkraeftet` | character | code | Later retracted |
| `diag_kode_tekst` | character | value | Diagnosis code, text |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (6)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `diag_parent_kode` | character | code | Parent diagnosis code |
| `lprindberetningssystem` | character | code | Reporting system |
| `diag_kode_type_tekst` | character | value | Diagnosis type, text |
| `diag_parent_kode_tekst` | character | value | Parent diagnosis code, text |
| `diag_parent_kode_type` | character | code | Parent diagnosis type |
| `diag_parent_kode_type_tekst` | character | value | Parent diagnosis type, text |

- **`lprindberetningssystem`:** Filter to "LPR3": the table holds rows from two reporting formats, and not doing so duplicates rows.

</details>

*DST publishes no labels for 11 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

**Join key:** `dw_ek_kontakt`.

**Joins to other registers:**

- `dw_ek_kontakt` joins to **LPR_A_KONTAKT** (many-to-one).

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `icd10_sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `diagtype` | `A` Aktionsdiagnose, `B` Bidiagnose, `G` Grundmorbus, naar forskellig fra aktionsdiagnose, `H` Henvisningsdiagnose, `M` Midlertidig diagnose, kun for aabne somatisk ambulante besoeg, `C` Komplikation |
| `lprindberetningssystem` | `LPR3`, `MiniPAS`, `LPR2`, `LPR1` |

- **`icd10_sks`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing. Do not carry the habit across to the cause-of-death registers: they hold the plain code, so stripping a D there removes the first real character instead.
- **`diagtype`:** The guide long described this as an A/B/G column. There are six codes, and three of them stop: **G runs 1995-2003 only**, M 1998-2013 and C 2002-2013. A and B run the whole period, H from 1995. So a comorbidity definition built on G silently covers nine years and nothing else, and filtering to A/B/G drops referral diagnoses entirely. Which types to keep is a case definition, not a technicality: outcomes usually use A and B. Carry the type column into the extract so the definition can be varied later.
- **`lprindberetningssystem`:** Confirm the exact strings with `count(lprindberetningssystem)` before relying on "LPR2" or "LPR1" in a filter: they are well-established as concepts in this guide, but nobody has pasted the literal value back from DARTER the way pitfall 5 did for "LPR3". "MiniPAS" is safe to rely on, since kont_type.yaml's coalescing logic already depends on it being exactly that string. This column is unrelated to LPR_F vs LPR_A: that choice is made before you open a file, this one lives inside the file you already chose.

Where these values come from:

- **`icd10_sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`diagtype`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`lprindberetningssystem`:** [No DST/Sundhedsdatastyrelsen kodeark for this column exists; the value set below is reconstructed from DARTER-team-confirmed facts already established elsewhere in this guide (this pitfalls page, and kont_type.yaml), not from a published code list.](darter-pitfalls.qmd#lpr3-lprindberetningssystem).

</details>

**Worth knowing:**

- **`senere_afkraeftet`:** A diagnosis that was subsequently withdrawn. Keeping these counts conditions the patient turned out not to have.
- **`diag_kode_tekst`:** The code spelled out. Convenient for reading, but do not group on it: the text can change between years while the code stays the same.
- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
