<!-- Generated from schema/registers/vnds.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `indud_kode` | character | code | Immigration or emigration |
| `haend_dato` | date | date | Date of the migration event |
| `indud_land` | character | code | Country migrated from or to |
| `cprtjek` | character | value | CPR check |
| `cprtype` | character | value | CPR type |

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `indud_kode` | `I` Indvandring, `U` Udvandring |

- **`indud_kode`:** Use `U` for censoring at emigration. People who never emigrated have no `U` event at all, so they are simply absent rather than carrying a missing date. Two caveats from the guide: CPR only has complete immigration and emigration data from 1971, so someone who immigrated before that has no event and looks resident since birth; and a move to Greenland is a status of its own in CPR rather than an emigration. Confirm the values on your own delivery.

</details>

**Worth knowing:**

- **`indud_land`:** Not listed in the guide's own table. The country code set has not been sourced.
