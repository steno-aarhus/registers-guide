<!-- Generated from schema/registers/ssko.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `spec2` | character | code | Specialty, 2-digit |
| `kontaktagg` | numeric | value | Contacts, aggregated |

<details>
<summary>All other columns (5)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `koenimp` | character | code | Sex, imputed values included |  |
| `alderimp` | numeric | value | Age at end of year, imputed values included |  |
| `cprtjek` | character | code | CPR-tjek | 2013 to 2025 |
| `cprtype` | character | code | CPR-type | 2013 to 2025 |
| `version` | numeric | date | Version | 2013 to 2025 |

- **`koenimp`:** Imputed where the source was missing, so it is not identical to koen in BEF. Prefer BEF when you need sex as a study variable.

</details>

*No published source gives a data type for 7 of these 8 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `koen` | `1` Mand, `2` Kvinde, `9` Uoplyst |

- **`koen`:** DST's classification KOEN_V1_1980 also defines `9` for not stated, which a delivery may not contain but a value set should. Sex is taken from the tenth digit of the CPR number: even is female, odd is male.

Where these values come from:

- **`koen`:** [DST's classification KOEN_V1_1980](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/koen) ([the code list as CSV](https://www.dst.dk/klassifikationsbilag/e267e7c0-d998-4922-b2c4-6b44b15dd149csv_da)).

</details>

**Worth knowing:**

- **`spec2`:** The kind of provider (general practice, specialist, dentist, psychologist and so on), the same code as spec2 in SSSY. General practice is spread over several codes, so take the list from DST's value set rather than picking a single code.
- **`kontaktagg`:** The number of contacts summed per person and specialty. A contact is a direct meeting between patient and provider: a consultation (including phone and e-mail) or a home visit, with any examinations in the same contact counted once. For dentists only the first visit counts, and DST calls the count uncertain for chiropody, physiotherapy and riding physiotherapy. DST notes a small number of negative values in 2008-2010 from settlement corrections, and that the definition of a contact has changed over time.
