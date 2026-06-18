# Lokale noter — ikke committed til GitHub

### KRITISK: NMI R-implementering mangler
- Kun Stata .do-fil findes (pharmacoepi.sdu.dk/nmi/)
- Ingen R-pakke kendes
- Overvej at kontakte SDU Pharmacoepidemiology om R-kode / samarbejde



### Verificer: heaven::import_SAS() i fase 6
- Fase 6, fold-out "Konvertér SAS til parquet"
- Bekræft at `heaven::import_SAS()` eksisterer i `heaven`-pakken på DST, og at argumenterne er korrekte (`keep`, `where`, `obs`)
- Alternativt er det `haven::read_sas()` — de to pakker forveksles let

### Verificer: FAIK kolonnenavn famaekvivadisp_13 (fase 8)
- Fase 8 beslutningstabel har `famaekvivadisp_13` som nøglekolonne for FAIK
- Bekræft dette er det korrekte kolonnenavn mod den faktiske FAIK-parquet på DST

### Verificer: fakeregs generate_lpr_diag() API (fase 9 + 6)
- generate_lpr_diag(background_df = lpr_adm_synth) — API er et kvalificeret gæt
- generate_lpr_a_diagnose(background_df = lpr_a_k_synth) — samme
- Test disse kaldt i RStudio med fakeregs installeret; ret argumenterne hvis de fejler

### Udtræksguide mangler: laboratoriesvar (DARTER, kun projekt 708421)
- darter/01 registersti + faldgrube 6 henviser til en dedikeret udtræksguide der endnu ikke findes
- Skriv guide til `laboratorieproevesvar_` (>2,2 mia. rækker): NPU-kode-filtrering, enheder, character `samplevalue` ("ikke påvist" mv.), filter/select FØR collect
- Tilføj link i darter/01 + faldgrube 6 når klar (HTML-TODO-kommentarer markerer stederne)

### Udtræksguide mangler: DOD post-2001 (DARTER, kun projekt 708421)
- `dodsaars` dækker kun ~1970–2001 (`d_dodsdto`); DOD (~2001–2024, `doddato`) er IKKE i cleaned-data
- Post-2001 dødsfald kræver udtræk fra rå SAS-fil via datamanager — skriv guide
- Kun relevant i DARTER-delen: dødsregister-adgang er projektspecifik
- darter/01 tabel-række "DOD" + Kritiske noter henviser hertil (HTML-TODO-kommentar markerer stedet)
