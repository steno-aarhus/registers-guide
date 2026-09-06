<!-- Generated from schema/registers/t_psyk_adm.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| **`recnum`** | character | join key | Contact identifier |
| `c_pattype` | character | code | Contact type |
| `c_adiag` | character | code | Primary diagnosis |
| `d_inddto` | date | date | Admission date |
| `d_uddto` | date | date | Discharge date |

<details>
<summary>All other columns (32)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_indm` | character | code | Admission mode |
| `c_udm` | character | code | Discharge mode |
| `c_sgh` | character | code | Hospital |
| `c_afd` | character | code | Department |
| `c_spec` | character | code | Specialty |
| `v_indtime` | integer | value | Admission hour |
| `v_indminut` | integer | value | Admission minute |
| `v_udtime` | integer | value | Discharge hour |
| `cprtjek` | character | code | CPR-tjek |
| `cprtype` | character | code | CPR-type |
| `c_amt` | character | code | AMT |
| `c_blok` | character | code | Inddeling af speciale i blokke |
| `c_hafd` | character | code | Henvisende afdeling |
| `c_henm` | character | code | Henvisningsmåde |
| `c_hsgh` | character | code | Henvisende sygehus |
| `c_kom` | character | code | Kommune |
| `c_kontaars` | character | code | Kontaktårsag |
| `c_nyafd` | character | code |  |
| `c_sex` | character | code | Køn |
| `c_sghamt` | character | code | Sygehusamt |
| `d_ebhdto` | date | date | Data for endelig behandling (Variabel udgået efter 31.12.2003) |
| `d_fusdto` | date | date | Dato for forundersøgelse (Variabel udgået efter 31.12.2003) |
| `d_hendto` | date | date | Henvisningsdato |
| `d_opdatdto` | date | date | Intern dato for opdatering af kontakten |
| `k_afd` | character | code | Afdelingskode |
| `leverancedato` | date | date |  |
| `version` | character | code | Version |
| `v_alddg` | numeric | value | Alder i dage ved kontaktens start |
| `v_alder` | numeric | value | Alder i år ved kontaktens start |
| `v_aldmdr` | numeric | value | Alder i måneder ved kontaktens start |
| `v_behdage` | numeric | value | Behandlingsdage (Variabel udgået efter 31.12.2001) |
| `v_sengdage` | numeric | value | Sengedage |

</details>

*No published source gives a data type for 18 of these 38 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `recnum`.

**Joins to other registers:**

- `recnum` joins to **T_PSYK_DIAG** (one-to-many).

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `pattype` | `0` Heldoegnspatient (to 2001), Indlagt patient (2002-), `1` Dagpatient (to 1986), Deldoegnspatient (1987-2001), `2` Natpatient (to 1986), Ambulant patient (1987-), `3` Skadestuepatient |
| `icd10_sks` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `indm` | `1` Akut, `2` Ikke akut, `9` Uoplyst |

- **`pattype`:** There are four codes, not six, and they changed meaning. Code `1` was Dagpatient until 1986 and Deldoegnspatient from 1987; code `2` was Natpatient until 1986 and Ambulant from 1987. The register only started using `1`, `2` and `3` in 1994, so before that essentially every contact is `0`. Code `3` was discontinued at the end of 2013, and from 2014 an emergency-room visit arrives as `2` with an acute admission mode in `c_indm`. Reading `2` as outpatient across the whole register therefore mislabels night patients before 1987 and emergency visits after 2013.
- **`icd10_sks`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing. Do not carry the habit across to the cause-of-death registers: they hold the plain code, so stripping a D there removes the first real character instead.
- **`indm`:** From 2014 this is what separates an emergency-room visit from an ordinary outpatient one, because `c_pattype` code `3` was discontinued and both arrive as `2`. Code `9` (Uoplyst) stops at the end of 2003, so a missing value after that is genuinely missing rather than coded as unknown.

Where these values come from:

- **`pattype`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).
- **`icd10_sks`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`indm`:** [Kodeark for Landspatientregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Landspatientregisteret/5_Kodeark_LPR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=5).

</details>

**Worth knowing:**

- **`pnr`:** DST's variable list calls this column PNR. Some deliveries rename it: some deliveries hand it over as `v_cpr`. The name is a product of the data processing, not of the register, so check your own columns and rename.
- **`recnum`:** DST's variable list calls this column RECNUM, the same name the somatic lpr_adm uses. Some deliveries rename it, and not consistently: the contact table can arrive as `k_recnum` and the diagnosis table as `v_recnum`. Rename both to recnum before joining.
- **`c_pattype`:** Present here even where the somatic lpr_adm extract leaves it out, so the psychiatric side of a study can be classified when the somatic side cannot. Do not assume symmetry between the two extracts.
