<!-- Generated from schema/registers/lpr_foedsler.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`recnum`** | character | join key | Contact identifier |

<details>
<summary>All other columns (8)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `d_smendto` | date | date | Last menstruation date |
| `v_flernr` | character | value | Child number in a multiple birth (a-f) |
| `v_jmbes` | numeric | value | Number of midwife visits |
| `v_langde` | numeric | value | Newborn length, cm |
| `v_lbes` | numeric | value | Number of doctor visits |
| `v_paritet` | numeric | value | Parity (completed pregnancies, including stillbirths and this birth) |
| `v_spbes` | numeric | value | Number of specialist doctor visits |
| `v_vagt` | numeric | value | Newborn weight, grams |

- **`d_smendto`:** Used to estimate gestational age - a self-reported/clinically-estimated date, not confirmed against any independent source in this schema.
- **`v_flernr`:** Letter-coded (a-f), not numeric - the same multiple-birth concept as mfrhjmfo.yaml/mfrdfoed.yaml's own BARNSNUMMER_FLERFOLDSFOEDSEL, but with a different value encoding.

</details>

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **LPR_ADM** (many-to-one).

**Worth knowing:**

- **`recnum`:** Joins to the MOTHER's contact in lpr_adm - the newborn is not assumed to have its own recnum here.
