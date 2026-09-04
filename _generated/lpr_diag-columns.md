<!-- Generated from schema/registers/lpr_diag.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier | 1977 to 2019 |
| `c_diag` | character | code | Diagnosis code | 1977 to 2019 |
| `c_diagtype` | character | code | Diagnosis type | 1977 to 2019 |
| `c_tildiag` | character | code | Supplementary diagnosis | 1995 to 2019 |
| `year` | integer | date | Register year |  |

<details>
<summary>All other columns (3)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `c_diagmod` | character | code | Diagnosis modification | 1977 to 1994 |
| `leverancedato` | date | date |  | 1977 to 2019 |
| `version` | character | code | Version | 1977 to 2019 |

</details>

*No published source gives a data type for 5 of these 8 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).

<details>
<summary>Value sets for the coded columns (2)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `diagtype` | `A` Aktionsdiagnose, `B` Bidiagnose, `G` Grundmorbus, naar forskellig fra aktionsdiagnose, `H` Henvisningsdiagnose, `M` Midlertidig diagnose, kun for aabne somatisk ambulante besoeg, `C` Komplikation |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.
- **`diagtype`:** The guide long described this as an A/B/G column. There are six codes, and three of them stop: **G runs 1995-2003 only**, M 1998-2013 and C 2002-2013. A and B run the whole period, H from 1995. So a comorbidity definition built on G silently covers nine years and nothing else, and filtering to A/B/G drops referral diagnoses entirely. Which types to keep is a case definition, not a technicality: outcomes usually use A and B. Carry the type column into the extract so the definition can be varied later.

Where these values come from:

- **`icd10`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`diagtype`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).

</details>

**Worth knowing:**

- **`year`:** Not a DST variable. It is the partition the yearly deliveries were written into, so filtering on it stops the other years being read at all. Use it to limit how much is read, not to decide when something happened: for that, use the register's own date column.
