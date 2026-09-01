<!-- Generated from schema/registers/faik.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| **`familie_id`** | character | join key | Household key |
| `famaekvivadisp_13` | numeric | value | Household-equivalised disposable income |
| `year` | integer | date | Register year |

**Join key:** `familie_id`.

**Joins to other registers:**

- `familie_id` joins to **BEF** (one-to-many).

**How it is computed:**

- `FAMAEKVIVADISP_13 = FAMDISPONIBEL_13 / (1 + (0.5 * (number of people over 14 in the family - 1)) + (0.3 * number of people under 15 in the family))`

**Worth knowing:**

- **`pnr`:** Not in DST's variable list for FAIK, which documents the register as keyed on the household. Where it is present, the household's row is repeated once per family member, so joining on familie_id alone multiplies rows.
- **`familie_id`:** There is no person identifier here. Fetch familie_id from BEF for the relevant year, then join on it.
- **`famaekvivadisp_13`:** This is the family's disposable income divided by an equivalence factor, so that families of different sizes can be compared. The factor counts the first adult as 1.0, each further person over 14 as 0.5, and each child under 15 as 0.3: a couple with two young children comes to 1 + 0.5 + 0.6 = 2.1, so a family income of 420,000 is recorded as 200,000 for each of the four. `FAMDISPONIBEL_13` is the same money before that division, and `FAMAEKVIVAINDKNETTO` is a different income concept (total income with net interest), so check which one your analysis plan means. The `_13` suffix marks the definition that replaced the older variables from 2013: DST states that FAMDISPONIBEL was discontinued in 2013 and replaced by FAMDISPONIBEL_13. A study spanning 2013 has to know which side of that change it is on.
- **`year`:** Not a DST variable. It comes from fastreg's parquet conversion, which concatenates the yearly deliveries, so it exists in the data you read but not in DST's own documentation of this register.
