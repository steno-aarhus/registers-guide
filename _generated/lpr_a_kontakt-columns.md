<!-- Generated from schema/registers/lpr_a_kontakt.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`dw_ek_kontakt`** | character | join key | Contact identifier |
| `dw_ek_forloeb` | character | code | Course identifier |
| `pnr` | character | identifier | Personal identifier |
| `kont_starttidspunkt` | datetime | date | Contact start |
| `kont_sluttidspunkt` | datetime | date | Contact end |
| `kont_type` | character | code | Contact type |
| `lprindberetningssystem` | character | code | Reporting system |

**Join key:** `dw_ek_kontakt`.

**Joins to other registers:**

- `dw_ek_kontakt` joins to **LPR_A_DIAGNOSE** (one-to-many).

**Worth knowing:**

- **`dw_ek_kontakt`:** The key the diagnosis and procedure tables join on.
- **`dw_ek_forloeb`:** One level above the contact: a course of treatment can span several contacts, so joining on this is not the same as joining on the contact.
- **`kont_starttidspunkt`:** A datetime, not a date. as.Date() it before comparing with an index date.
- **`lprindberetningssystem`:** Filter to "LPR3". The table reaches back to 2017, and the outpatient contacts from before March 2019 are also in LPR2, so combining the two without this filter counts the same contact twice. The column also separates the two delivery formats, LPR_F and LPR_A.
