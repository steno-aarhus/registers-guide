# Parkeret indhold

Nedenstående tekst er fjernet fra `00_index.qmd` da det var en manuel indholdsliste
der nu er erstattet af sidebar-navigationens fase-struktur.

---

## Indhold (gammel liste fra index.qmd)

**Generelt**

- [Studieforberedelse](01_studieforberedelse.qmd) — analyseplan, STROBE, hvad er DST
- [Ressourcer og hjælp](02b_ressourcer-og-hjaelp.qmd) — hjælpeliste, kurser, AI-tips

**R og RStudio**

- [Kom i gang med R](02a_r-intro.qmd) — RStudio, første projekt, genveje
- [Datastrukturer](10a_datastrukturer.qmd) — langt og bredt format
- [Basiskommandoer](07_basiskommandoer.qmd) — udforsk og forstå dine data
- [Filformater](04_filformater.qmd) — SAS, Parquet, RDS, CSV

**DST-serveren**

- [Kom i gang på DST](03_getting-started-dst.qmd) — de første 10 minutter, det universelle mønster
- [Parquet, Arrow og DuckDB](05_parquet-arrow-duckdb.qmd) — doven evaluering, collect(), RAM

**Kode og data**

- [Første udtræk](06_foerste-udtraek.qmd) — trin-for-trin fra register til gemt datasæt
- [Funktioner — oversigt](14a_guide_til_funktioner.qmd) — filter, select, mutate, joins
- [Joins og pivots](10b_joins-og-pivots.qmd) — kobl datasæt sammen
- [Formateringstabeller](14b_formateringstabeller.qmd) — oversæt koder til tekst
- [Hospitalskontakter (LPR)](09a_forstaa_lpr.qmd) — LPR2 + LPR3, ICD-koder
- [Socioøkonomiske variable](11a_socioekonomiske-variable.qmd) — uddannelse, indkomst, beskæftigelse

**Pakker og algoritmer**

- [Oversigt](13a_pakker-oversigt.qmd) — OSDC, NMI og SEPLINE
- [OSDC](13b_osdc.qmd) — Open Source Diabetes Classifier
- [NMI](13c_nmi.qmd) — Nordic Multimorbidity Index
- [SEPLINE](11b_sepline.qmd) — socioøkonomisk position

**Reference og hjemsendelse**

- [Registerreference](08_register_reference.qmd) — bekræftede kolonnenavne for alle registre
- [Faldgruber](14c_dst_faldgruber.qmd) — 10 DST-specifikke fejl
- [Eksport og hjemsendelse](15_eksport-hjemsendelse.qmd) — GDPR og outputkontrol

---

## Fra 02a_r-intro.qmd: "Opret dit R-projekt" (DST-specifik — flyttes til Fase 3)

Et R-projekt er en mappe på computeren, der samler alle dine scripts, outputfiler og indstillinger.
**Hvert studie bør have sit eget projekt.**

**Sådan gør du:**

1. Åbn RStudio
2. **File → New Project → New Directory → New Project**
3. Giv projektet et navn og vælg en placering — på DST typisk under `E:/workdata/[projektnummer]/workspaces/[ditNavn]/`
4. Klik **Create Project**

Anbefalet mappestruktur:
```
mit-projekt/
  R/              ← alle dine scripts
  datasets/       ← mellemregninger og analysedatasæt (.rds filer)
  output/         ← tabeller og figurer klar til hjemsendelse
```

---

## Fra 02a_r-intro.qmd: Keyboard genveje-tabel (reference — evt. til Fase 13)

| Genvej (Windows/Mac i Remote Desktop) | Hvad den gør |
|---|---|
| **Ctrl+Enter** | Kør markeret linje/kode |
| **Ctrl+S** | Gem filen |
| **Alt + –** | Skriv tildelingsoperatoren `<-` (Mac: Option + –) |
| **Ctrl+Shift+M** | Skriv pipe-tegnet `|>` |
| **Ctrl+Shift+R** | Indsæt script-sektion |
| **Ctrl+Shift+A** | Formater/indenter kode automatisk |
| **Ctrl+Z / Ctrl+Shift+Z** | Fortryd / Gentag |
| **Alt+Shift+K** | Vis alle genveje |

---

## Fra 02a_r-intro.qmd: "Gem ikke workspace" tip

RStudio spørger ved lukning: *"Save workspace image?"* — **vælg altid Nej**.
Indstil det permanent under **Tools → Global Options → General → "Save workspace to .RData" → Never**.

---

## Fra 02b_ressourcer-og-hjaelp.qmd: DST-dokumentation (flyttes til Fase 3)

**TIMES — variabelbeskrivelser**
Slå op hvad en variabel betyder:
[dst.dk/da/Statistik/dokumentation/Times](https://www.dst.dk/da/Statistik/dokumentation/Times)

**Stjernen på skrivebordet**
Inde på DST-serveren: den stjerne-genvej på Windows-skrivebordet åbner DST's formateringstabel-guide.

---

## "Hvad er SDS og DST?" (fra 01_studieforberedelse.qmd, afsnit 3)

Som forsker arbejder du på **Danmarks Statistiks (DST) servere**.
DST modtager og bearbejder data fra bl.a. Sundhedsdatastyrelsen (SDS), som har de rå nationale sundhedsregistre (LPR, LMDB, cancerregister mv.), og stiller dem til rådighed for forskere via sikker fjernforbindelse.
