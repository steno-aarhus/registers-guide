<!-- Generated from schema/registers/uaf_diag.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_diag` | character | code | Diagnosis code |
| `c_diagtype` | character | code | Diagnosis type |
| `year` | integer | date | Register year |

<details>
<summary>All other columns (3)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_tildiag` | character | code | Supplementary diagnosis |
| `leverancedato` | date | date | Delivery date |
| `version` | character | code | Version |

</details>

*No published source gives a data type for 4 of these 7 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **UAF_ADM** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `icd10_sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `diagtype` | `A` Aktionsdiagnose, `B` Bidiagnose, `G` Grundmorbus, naar forskellig fra aktionsdiagnose, `H` Henvisningsdiagnose, `M` Midlertidig diagnose, kun for aabne somatisk ambulante besoeg, `C` Komplikation |

- **`icd10_sks`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing. Do not carry the habit across to the cause-of-death registers: they hold the plain code, so stripping a D there removes the first real character instead.
- **`diagtype`:** The guide long described this as an A/B/G column. There are six codes, and three of them stop: **G runs 1995-2003 only**, M 1998-2013 and C 2002-2013. A and B run the whole period, H from 1995. So a comorbidity definition built on G silently covers nine years and nothing else, and filtering to A/B/G drops referral diagnoses entirely. Which types to keep is a case definition, not a technicality: outcomes usually use A and B. Carry the type column into the extract so the definition can be varied later.

Where these values come from:

- **`icd10_sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`diagtype`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).

</details>

**Worth knowing:**

- **`recnum`:** The key that links uaf_diag to uaf_adm. It identifies a contact, not a person. Sundhedsdatastyrelsen states that recnum is unique only within one update of the register. A contact can get a new recnum when the register is updated, and a recnum can be reused for a different contact. Join tables only within the same delivery and the same year, and do not use recnum to match an open contact to its closed version in lpr_adm.
- **`c_diagtype`:** Which types exist depends on the year (see the code system). Type M, a provisional diagnosis for an open somatic outpatient contact, was in use from 1998 to 2013, and an A and B filter leaves it out.
- **`year`:** Not a DST variable. It is the yearly file a row came from. In the open-contact tables that is a year in which the contact was open, and a contact open for several years is in several of them, so rows from different years can be the same contact. Use d_inddto in uaf_adm to say when a contact started.
