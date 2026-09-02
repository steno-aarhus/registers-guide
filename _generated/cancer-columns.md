<!-- Generated from schema/registers/cancer.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_icd10` | character | code | ICD10 diagnose |
| `c_morfo03` | character | code | ICD3 - Histologi og morfologi |
| `c_topo3` | character | code | Tumorens lokalisation |
| `d_diagnosedato` | date | date | Diagnosedato |
| **`k_cprnr`** | character | join key | CPR-nummer |
| `k_tumornr` | character | code | Tumor løbenr. |
| `v_diagnosealder` | numeric | value | Patientens alder |

<details>
<summary>All other columns (28)</summary>

| Column | Type | Role | Label | Years |
| --- | --- | --- | --- | --- |
| `c_amtf07` | character | code | Amtskode | 1968 to 2006 |
| `c_behandling` | character | code | Behandlingskode | 1943 to 2003 |
| `c_diaggr` | character | code | Diagnosegruppering ICD7 |  |
| `c_diaggr_kp` | character | code | Diagnosegruppering KP |  |
| `c_diaggr_nordcan` | character | code | Diagnosegruppering NordCan |  |
| `c_grad` | character | code | Gradering | 1943 to 2008 |
| `c_idc7` | character | code | ICD7 diagnose | 1943 to 1977 |
| `c_komf07` | character | code | Patientens bopælskommune | 1968 to 2006 |
| `c_kommune` | character | code | Bopælskommune |  |
| `c_lateral` | character | code | Lateralitet |  |
| `c_makrogrundlag` | character | code | Makroskopisk grundlag |  |
| `c_mikrogrundlag` | character | code | Mikroskopisk grundlag |  |
| `c_orggr` | character | code | ICD7 diagnosegruppering |  |
| `c_orggr_idc10` | character | code | ICD10 diagnosegruppering |  |
| `c_region` | character | code | Patientens bopælsregion |  |
| `c_sarc` | character | code | Sarcom. eller ej |  |
| `c_sex` | character | code | Patientens køn |  |
| `c_status` | character | code | Patientens status |  |
| `c_tnm_m` | character | code | Angiver fjernmetastaser | 2004 to 2024 |
| `c_tnm_n` | character | code | Angiver lymfeknudemetastaser | 2004 to 2024 |
| `c_tmn_t` | character | code | Størrelse af tumor | 2004 to 2024 |
| `c_udbred` | character | code | Tumorens udbredelse | 1943 to 2003 |
| `c_udbred_klassifikation` | character | code | Anvendt udbredelsesklassifikation |  |
| `c_aa` | character | code | Ann Arbour klassifikation | 2004 to 2024 |
| `d_fdsdato` | date | date | Fødselsdato |  |
| `d_statdato` | date | date | Status dato |  |
| `v_diagmd` | numeric | value | Diagnosemåned |  |
| `v_diagaar` | numeric | value | Diagnoseår |  |

- **`c_grad`:** Only filled in for urinary tract tumours.
- **`c_idc7`:** ICD-7, the coding used before ICD-10. A series running back before 1978 needs both this and c_icd10.
- **`c_udbred`:** Replaced by the TNM columns and Ann Arbor from 2004, when the register moved from paper coding to electronic reporting through LPR. Nothing maps one to the other, so a stage variable across 2004 is two different things.

</details>

**Join key:** `k_cprnr`.

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://medinfo.dk/sks/brows.php) |
| `kom` | Not listed here - see [DST's classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts) |
| `reg` | `0` Uoplyst, `81` Nordjylland, `82` Midtjylland, `83` Syddanmark, `84` Hovedstaden, `85` Sjælland |

- **`icd10`:** The D prefix is a Danish addition, not part of the WHO code. Matching WHO codes directly against LPR without allowing for it returns nothing.
- **`kom`:** These codes are valid from 1 January 2007. A study reaching further back needs the pre-reform classification, where the same number can mean a different municipality.
- **`reg`:** Do not confuse these with AMT, the pre-2007 counties, which has 16 codes in the ranges 11-14, 21-24, 31-37 and 88. Different geography, different era.

Where these values come from:

- **`icd10`:** [SKS browser (medinfo.dk)](https://medinfo.dk/sks/brows.php).
- **`kom`:** [DST's municipality classification](https://www.dst.dk/da/Statistik/dokumentation/nomenklaturer/nuts).
- **`reg`:** [DST's regional classification](https://www.dst.dk/extranet/ForskningVariabellister/BEF%20-%20Befolkningen.html).

</details>

**Worth knowing:**

- **`c_icd10`:** The modern diagnosis code. Older years also carry ICD-7 in c_idc7, so a series running back before ICD-10 has to use both.
- **`c_morfo03`:** Histology and morphology, ICD-O-3. Together with c_topo3 (site) this is what distinguishes tumour types; the ICD-10 code alone does not.
- **`d_diagnosedato`:** The diagnosis date, which is the incidence date for this register.
- **`k_cprnr`:** The person key. Named k_cprnr rather than pnr, so rename before joining to a DST register.
- **`k_tumornr`:** One person can appear several times: the register counts incident tumours, not people. Deduplicating on the person alone collapses second primaries.
- **`v_diagnosealder`:** Age at diagnosis, precomputed. Recompute from d_fdsdato if your index date differs.
