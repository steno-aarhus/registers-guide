<!-- Generated from schema/registers/ by tools/build-schema-tables.R. Do not edit by hand. -->

| Register | Read as | Join key | Period | Often used |
| --- | --- | --- | --- | --- |
| [AKM](https://www.dst.dk/extranet/ForskningVariabellister/AKM%20-%20Arbejdsklassifikationsmodulet.html) | `"akm"` | `pnr` | 1976 to 2024 | `socio13`, `socio02`, `socio` |
| [BEF](https://www.dst.dk/extranet/ForskningVariabellister/BEF%20-%20Befolkningen.html) | `"bef"` | `pnr` | 1985-12 to 2026-06 | `koen`, `foed_dag`, `familie_id` |
| [CANCER](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=23) | `"cancer"` | `k_cprnr` | 1943 to 2024 | `c_icd10`, `c_morfo03`, `c_topo3` |
| [DOD](https://www.dst.dk/extranet/ForskningVariabellister/DOD%20-%20D%C3%B8de%20i%20Danmark.html) | `"dod"` | `pnr` | 1970 to 2025 | `doddato` |
| [DODSAARS](https://www.dst.dk/extranet/ForskningVariabellister/DODSAARS%20-%20D%C3%B8ds%C3%A5rssagsregistret.html) | `"dodsaars"` | `pnr` | 1970 to 2001 | `d_dodsdto`, `c_dodsmaade`, `c_dod1` |
| [DODSAARSAGER](https://www.dst.dk/extranet/ForskningVariabellister/DODSAARSAGER%20-%20D%C3%B8ds%C3%A5rsagsregister.html) | `"dodsaarsager"` | `pnr` | 2022 to 2024 | `doedsdato`, `doedsaarsag_tilgrundliggende`, `doedsaarsag_kode_1` |
| [DODSAASG](https://www.dst.dk/extranet/ForskningVariabellister/DODSAASG%20-%20D%C3%B8ds%C3%A5rsagsregister.html) | `"dodsaasg"` | `pnr` | 2002 to 2022 | `d_dodsdato`, `c_dodtilgrundl_acme`, `c_dod_1a` |
| [FAIK](https://www.dst.dk/extranet/ForskningVariabellister/FAIK%20-%20Familieindkomster.html) | `"faik"` | `familie_id` | 1987 to 2024 | `pnr`, `famaekvivadisp_13`, `year` |
| [LAB_DM_FORSKER](https://sundhedsdatastyrelsen.dk/data-og-registre/nationale-sundhedsregistre/laboratoriedatabasen) | `"lab_dm_forsker"` | `patient_cpr` | 2008 to 2025 | `samplingdate`, `analysiscode`, `value` |
| [LMDB](https://www.dst.dk/extranet/ForskningVariabellister/LMDB%20-%20L%C3%A6gemiddeldatabasen.html) | `"lmdb"` | `pnr` | 1995-12 to 2025-12 | `eksd`, `atc`, `atc1` |
| [LPR_A_DIAGNOSE](https://www.dst.dk/extranet/ForskningVariabellister/LPR_A_DIAGNOSE%20-%20Landspatientregistret%20%28LPR3%29%20-Diagnoseoplysning.html) | `"lpr_a_diagnose"` | `dw_ek_kontakt` | 2019 to 2025 | `diag_kode`, `diag_kode_type`, `senere_afkraeftet` |
| [LPR_A_KONTAKT](https://www.dst.dk/extranet/ForskningVariabellister/LPR_A_KONTAKT%20-%20Landspatientregistret%20%28LPR3%29%20-Kontaktoplysninger%20omkring%20de%20enkelte%20kontakter.html) | `"lpr_a_kontakt"` | `dw_ek_kontakt` | 2017 to 2025 | `dw_ek_forloeb`, `pnr`, `kont_starttidspunkt` |
| [LPR_A_PROCREGISTRERING](https://www.dst.dk/extranet/ForskningVariabellister/LPR_A_PROCREGISTRERING%20-%20Landspatientregisteret%20%28LPR3%29%20-%20Oplysninger%20om%20procedureregistreringer.html) | `"lpr_a_procregistrering"` | `dw_ek_kontakt` | *not recorded* | `proc_kode`, `proc_starttidspunkt`, `proc_kode_type` |
| [LPR_ADM](https://www.dst.dk/extranet/ForskningVariabellister/LPR_ADM%20-%20Landspatientregistret%20-%20administrative%20oplysninger.html) | `"lpr_adm"` | `recnum` | 1977 to 2019-03 | `pnr`, `d_inddto`, `d_uddto` |
| [LPR_DIAG](https://www.dst.dk/extranet/ForskningVariabellister/LPR_DIAG%20-%20Landspatientregistret%20-%20diagnoser.html) | `"lpr_diag"` | `recnum` | 1977 to 2019-03 | `c_diag`, `c_diagtype`, `c_tildiag` |
| [LPR_SKSOPR](https://www.dst.dk/extranet/ForskningVariabellister/LPR_SKSOPR%20-%20Landspatientregistret%20-%20operationer.html) | `"lpr_sksopr"` | `recnum` | 1996 to 2019 | `c_opr`, `c_oprart`, `c_osgh` |
| [LPR_SKSUBE](https://www.dst.dk/extranet/ForskningVariabellister/LPR_SKSUBE%20-%20Landspatientregistret%20-%20unders%C3%B8gelser%20og%20behandlinger.html) | `"lpr_sksube"` | `recnum` | 1999 to 2019 | `c_opr`, `d_odto`, `year` |
| [MFR](https://www.dst.dk/extranet/forskningvariabellister/Bestillingsliste.xlsx) | `"mfr"` | `cpr_barn` | 1997 to 2018 | `alder_moder`, `bmi_moder`, `cpr_moder` |
| [SSSY](https://www.dst.dk/extranet/ForskningVariabellister/SSSY%20-%20Sygesikring%20%286-cifret%29.html) | `"sssy"` | `pnr` | 2005 to 2025 | `ydernr`, `speciale`, `ydlant` |
| [SYSI](https://www.dst.dk/extranet/ForskningVariabellister/SYSI%20-%20Sygesikring%20%286-cifret%29.html) | `"sysi"` | `pnr` | 1990 to 2005 | `ydernr`, `speciale`, `ydlant` |
| [T_PSYK_ADM](https://www.dst.dk/extranet/ForskningVariabellister/PSYK_ADM%20-%20Landspatientregistret%20psykiatri%20-%20administrative%20oplysninger.html) | `"t_psyk_adm"` | `recnum` | 1995 to 2019 | `pnr`, `c_pattype`, `c_adiag` |
| [T_PSYK_DIAG](https://www.dst.dk/extranet/ForskningVariabellister/PSYK_DIAG%20-%20Landspatientregistret%20psykiatri%20-%20diagnoser.html) | `"t_psyk_diag"` | `recnum` | 1995 to 2019 | `c_diag`, `c_diagtype`, `c_tildiag` |
| [UDDA](https://www.dst.dk/extranet/ForskningVariabellister/UDDA%20-%20Uddannelser%20%28BUE%29.html) | `"udda"` | `pnr` | 1980-12 to 2025-09 | `hfaudd`, `udd`, `hf_vfra` |
| [VNDS](https://www.dst.dk/extranet/ForskningVariabellister/VNDS%20-%20Historiske%20vandringer.html) | `"vnds"` | `pnr` | 1973 to 2024 | `indud_kode`, `haend_dato`, `indud_land` |
| [VNDS_HIST](https://www.dst.dk/extranet/ForskningVariabellister/VNDS_HIST%20-%20Historiske%20vandringer%20fra%201973%20til%202004.html) | `"vnds_hist"` | `pnr` | 1973 to 2004 | `indud_kode`, `haend_dato`, `indud_land` |
| [VNDS_IND](https://www.dst.dk/extranet/ForskningVariabellister/VNDS_IND%20-%20Indvandringer.html) | `"vnds_ind"` | `pnr` | 2005 to 2025 | `haend_dato`, `indv_land`, `indvmd` |
| [VNDS_UD](https://www.dst.dk/extranet/ForskningVariabellister/VNDS_UD%20-%20Udvandringer.html) | `"vnds_ud"` | `pnr` | 2005 to 2025 | `haend_dato`, `udv_land`, `udvmd` |
