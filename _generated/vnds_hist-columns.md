<!-- Generated from schema/registers/vnds_hist.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier | 2004 to 2004 |
| `indud_kode` | character | code | Immigration or emigration | 2004 to 2004 |
| `haend_dato` | date | date | Date of the migration event | 2004 to 2004 |
| `indud_land` | character | code | Country migrated from or to | 2004 to 2004 |

<details>
<summary>All other columns (2)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `cprtjek` | character | value |  | 2004 to 2004 |
| `cprtype` | character | value |  | 2004 to 2004 |

</details>

*No published source gives a data type for 6 of these 6 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

<details>
<summary>Value sets for the coded columns (1)</summary>

| Code system | Values |
| --- | --- |
| `indud_kode` | `I` Indvandring, `U` Udvandring |

- **`indud_kode`:** Use `U` for censoring at emigration. People who never emigrated have no `U` event at all, so they are simply absent rather than carrying a missing date. Two caveats from the guide: CPR only has complete immigration and emigration data from 1971, so someone who immigrated before that has no event and looks resident since birth; and a move to Greenland is a status of its own in CPR rather than an emigration. Confirm the values on your own delivery.

Where these values come from:

- **`indud_kode`:** [DST's variable list for VNDS](https://www.dst.dk/extranet/ForskningVariabellister/VNDS%20-%20Historiske%20vandringer.html).

</details>
