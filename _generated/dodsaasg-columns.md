<!-- Generated from schema/registers/dodsaasg.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `d_dodsdato` | date | date | Date of death |
| `c_dodtilgrundl_acme` | character | code | Underlying cause of death (ACME) |
| `c_dod_1a` | character | code | Cause of death, certificate line 1a |
| `c_liste14` | character | code | Cause group, 14-item list |
| `c_liste49` | character | code | Cause group, 49-item list |
| `c_dodsmaade` | character | code | Manner of death |
| `c_dodssted` | character | code | Place of death |
| `aar` | integer | date | Year |

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.

</details>

**Worth knowing:**

- **`d_dodsdato`:** Note the spelling: d_dodsdato here, d_dodsdto in DODSAARS. The two registers do not use the same column names.
- **`c_dodtilgrundl_acme`:** The underlying cause, selected by the ACME algorithm. This is usually the one an analysis wants, rather than the individual certificate lines.
