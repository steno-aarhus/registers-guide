<!-- Generated from schema/registers/faik.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`familie_id`** | character | join key | Household key |
| `famaekvivadisp_13` | numeric | value | Household-equivalised disposable income |
| `aar` | integer | date | Register year |

**Join key:** `familie_id`.

**Joins to other registers:**

- `familie_id` joins to **BEF** (one-to-many).

**How it is computed:**

- **`famaekvivadisp_13`** = FAMDISPONIBEL_13 / (1 + 0.5 * (people over 14 - 1) + 0.3 * (people under 15)), i.e. the OECD-modified equivalence scale.

**Worth knowing:**

- **`familie_id`:** There is no person identifier here. Fetch familie_id from BEF for the relevant year, then join on it.
- **`famaekvivadisp_13`:** This is the family's disposable income divided by an equivalence factor, so that families of different sizes can be compared: the first adult counts 1.0, each further person over 14 counts 0.5, and each child under 15 counts 0.3. `FAMDISPONIBEL_13` is the same money before that division, and `FAMAEKVIVAINDKNETTO` is a different income concept (total income with net interest), so check which one your analysis plan means. The `_13` suffix marks the definition that replaced the older variables from 2013: DST says of `FAMDISPONIBEL` that it "udgår 2013 og erstattes af FAMDISPONIBEL_13". A study spanning 2013 has to know which side it is on.
- **`aar`:** Not confirmed against DST's variable list, which shows no AAR. Very likely the partition column from the parquet conversion, as `aar` in BEF was confirmed to be. Treat it as such until checked.
