<!-- Generated from schema/registers/t_psyk_psykio.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_indvilk` | character | code | Admission condition/legal basis code |

<details>
<summary>All other columns (2)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_indfra` | character | code | Admitted from code |
| `c_udtil` | character | code | Discharged to code |

- **`c_indfra`:** ind fra = admitted from, by the variable name - not confirmed by any DST label.
- **`c_udtil`:** ud til = discharged to, by the variable name - a different concept from t_psyk_udtilsgh.yaml's own hospital/department transfer destination, which is facility-coded rather than category-coded.

</details>

*No published source gives a data type for 3 of these 4 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).

**Worth knowing:**

- **`c_indvilk`:** ind vilkaar = admission condition/terms, by the variable name - plausibly the voluntary-vs-involuntary (frivillig/tvang) admission basis central to Danish psychiatric law, but this is not confirmed by any DST label or documentation found. Verify against real data and, if needed, the Psychiatric Act (Psykiatriloven) before using this column for anything involuntary-commitment related.
