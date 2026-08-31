<!-- Generated from schema/registers/dod.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `doddato` | date | date | Date of death |
| `alder_haend` | integer | value | Age at the time of death |
| `cprtjek` | character | value | CPR check |
| `cprtype` | character | value | CPR type |

**Join key:** `pnr`.

**Worth knowing:**

- **`doddato`:** This is the column to censor on. Not `d_dodsdto`, which belongs to DODSAARS and stops in 2001.
