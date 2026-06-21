# Hvad mangler vi hjælp til? / What do we need help with?

**Idéer er meget velkomne** - også selvom du ikke har færdig kode. Se hvordan du bidrager (e-mail eller pull request) på siden **"Vil du hjælpe?"** i guiden.

**Ideas are very welcome** - even if you don't have finished code. See how to contribute (email or pull request) on the **"Want to help?"** page in the guide.

---

### NMI R-implementering mangler
- Kun Stata .do-fil findes (pharmacoepi.sdu.dk/nmi/)
- Ingen R-pakke kendes
- Overvej at kontakte SDU Pharmacoepidemiology om R-kode / samarbejde

### Verificer: heaven::import_SAS() i fase 6
- Fase 6, fold-out "Konvertér SAS til parquet"
- Bekræft at `heaven::import_SAS()` eksisterer i `heaven`-pakken på DST, og at argumenterne er korrekte (`keep`, `where`, `obs`)
- Alternativt er det `haven::read_sas()` 

### Udtræksguide mangler: laboratoriesvar 
- Skriv guide til `laboratorieproevesvar_` (>2,2 mia. rækker): NPU-kode-filtrering, enheder, character `samplevalue` ("ikke påvist" mv.), filter/select FØR collect

### Udtræksguide mangler: DOD post-2001 (DARTER, kun projekt 708421)
- `dodsaars` dækker kun ~1970–2001 (`d_dodsdto`); DOD (~2001–2024, `doddato`) er IKKE i cleaned-data
- Post-2001 dødsfald kræver udtræk fra rå SAS-fil via datamanager - skriv guide
- Kun relevant i DARTER-delen: dødsregister-adgang er projektspecifik
- darter/01 tabel-række "DOD" + Kritiske noter henviser hertil (HTML-TODO-kommentar markerer stedet)

## Sider der mangler / endnu ikke færdige · Pages still missing / incomplete

- **Fase 11a Udfald / Outcomes:** konkret udfaldsudtræk fra LPR + censurering (død, emigration). / Concrete outcome extraction from LPR + censoring.

- **Fase 13 Analyse / Analysis:** Table 1, figurer, regression, time-to-event, konkurrerende risici, IPTW. / Table 1, figures, regression, time-to-event, competing risks, IPTW.

- **Databehandling / Data handling:** manglende data (`mice`), tidsvarierende variable. / Missing data, time-varying variables.

**Kode / Code:**

- Etnicitet / Ethnicity (BEF/IEPE)
- Medicin og medicinforbrug / Medication use: DDD, vægtet forbrug, PDC/MPR, insulin, lag-time, langtidsrecepter
- Familiekobling / Family linkage (CPR / familie-id)
- Nordic Multimorbidity Index (NMI) - R-implementering (i dag kendes kun en Stata-version) / R implementation (only a Stata version is known today)
- Socioøkonomisk klassifikation / Socioeconomic classification (SEPLINE)
- Tidsvarierende variable / Time-varying variables (blodprøver, BMI, vægt)
- Simuleret data / Simulated data

