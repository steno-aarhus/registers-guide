<!-- Generated from schema/registers/t_psyk_pers.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |
| `c_psykyd` | character | code | Outpatient psychiatric service |
| `d_ambdto` | date | date | Date of outpatient visit |

<details>
<summary>All other columns (4)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_perskat1` | character | code | Staff category involved in the visit (1) |
| `c_perskat2` | character | code | Staff category involved in the visit (2) |
| `c_perskat3` | character | code | Staff category involved in the visit (3) |
| `c_ydsted` | character | code | Location of the outpatient service |

- **`c_perskat1`:** Three parallel staff-category columns (c_perskat1/2/3) share the identical label on DST's page - up to three staff categories can be recorded per visit, not one per column type.
- **`c_ydsted`:** Distinguishes a home visit from an on-site visit from 2003 onward, per Sundhedsdatastyrelsen's LPR documentation (table t_pers).

</details>

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_ADM** (many-to-one).

**Worth knowing:**

- **`d_ambdto`:** Sundhedsdatastyrelsen's LPR documentation notes several visits can share the same date for the same patient - do not deduplicate by date alone when counting visits.
