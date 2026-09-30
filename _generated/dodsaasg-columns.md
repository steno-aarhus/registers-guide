<!-- Generated from schema/registers/dodsaasg.yaml by tools/build-schema-tables.R. Do not edit by hand. -->

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| **`pnr`** | character | join key | Personal identifier |
| `d_dodsdato` | date | date | Date of death |
| `c_dodtilgrundl_acme` | character | code | Underlying cause of death (ACME) |
| `c_dod_1a` | character | code | Cause of death, certificate line 1a |
| `c_dodsmaade` | character | code | Manner of death |
| `aar` | integer | date | Year |

<details>
<summary>All other columns (35)</summary>

| Column | Type | Role | Label |
| --- | --- | --- | --- |
| `c_liste14` | character | code | Cause group, 14-item list |
| `c_liste49` | character | code | Cause group, 49-item list |
| `c_dodssted` | character | code | Place of death |
| `cprtjek` | character | code | CPR check |
| `cprtype` | character | code | CPR type |
| `c_bopamtf07` | character | code | County of residence (pre-2007 counties) |
| `c_bopkom` | character | code | Municipality of residence |
| `c_bopkomf07` | character | code | Municipality of residence (pre-2007 codes) |
| `c_dodkom` | character | code | Municipality of death |
| `c_dodregion` | character | code | Region of death |
| `c_dod_1b` | character | code | Contributing cause of death (line 1b) |
| `c_dod_1c` | character | code | Contributing cause of death (line 1c) |
| `c_dod_1d` | character | code | Underlying cause of death as written on the certificate (line 1d) |
| `c_dod_21` | character | code | Contributing cause of death (part 2, first) |
| `c_dod_22` | character | code | Contributing cause of death (part 2, second) |
| `c_dod_23` | character | code | Contributing cause of death (part 2, third) |
| `c_dod_24` | character | code | Contributing cause of death (part 2, fourth) |
| `c_dod_25` | character | code | Contributing cause of death (part 2, fifth) |
| `c_dod_26` | character | code | Contributing cause of death (part 2, sixth) |
| `c_dod_27` | character | code | Contributing cause of death (part 2, seventh) |
| `c_dod_28` | character | code | Contributing cause of death (part 2, eighth) |
| `c_findested` | character | code | Place where the deceased was found |
| `c_haendelsessted` | character | code | Place of the event leading to death |
| `c_laegefunktion` | character | code | Certifying doctor's role in relation to the patient |
| `c_listea` | character | code | Cause-of-death grouping, list A |
| `c_listeb` | character | code | Cause-of-death grouping, list B |
| `c_obduktion` | character | code | Whether an autopsy was performed |
| `c_operation` | character | code | Whether the deceased had surgery before death |
| `c_praecis_dodssted` | character | code | Place of death, detailed |
| `c_praecis_findested` | character | code | Place where found, detailed |
| `c_region` | character | code | Region of residence |
| `c_sex` | character | code | Sex |
| `d_findedato` | date | date | Date found |
| `d_statdato` | date | date | Date of death or date found |
| `v_alder` | numeric | value | Age of the deceased |

- **`c_dodssted`:** Incomplete from 2007, when the electronic death certificate was introduced: many certificates were still sent on paper, and the part with the place of death or finding (page 1) is missing for 20-25 percent of deaths a year in 2007-2012, except 2009, when it was entered by hand (about 3 percent missing). About 10 percent were still missing in 2014. Hospices count as nursing homes (so as own home) in 2002-2006 and as hospitals from 2007.
- **`c_bopamtf07`:** Filled until 2006, when the counties were abolished; 0 from 2007.
- **`c_bopkom`:** Uses the municipality codes valid from 2007 for every year, including 2002-2006, so a series can run across the 2007 reform; for 2002-2006 it is a geographic area, not the municipality that existed then.
- **`c_bopkomf07`:** Filled only for deaths up to 2006, with the municipality codes valid then. 547 deaths from delayed certificates carry newer codes anyway.
- **`c_dod_1b`:** Coding rules are updated regularly and some specific codes have breaks, for example accidents during surgical and medical treatment (group B-097) from 2007 and other accidents (B-098) from 2000.
- **`c_dod_1c`:** Coding rules are updated regularly and some specific codes have breaks, for example accidents during surgical and medical treatment (group B-097) from 2007 and other accidents (B-098) from 2000.
- **`c_dod_1d`:** Coding rules are updated regularly and some specific codes have breaks, for example accidents during surgical and medical treatment (group B-097) from 2007 and other accidents (B-098) from 2000.
- **`c_dod_25`:** Only filled in 2002 (80 deaths) and 2005 (295 deaths).
- **`c_dod_26`:** Only filled in 2002 (19 deaths) and 2005 (87 deaths).
- **`c_dod_27`:** Only filled in 2002 (6 deaths) and 2005 (37 deaths).
- **`c_dod_28`:** Only filled in 2002 (3 deaths) and 2005 (9 deaths).
- **`c_findested`:** Incomplete from 2007, when the electronic death certificate was introduced: many certificates were still sent on paper, and the part with the place of death or finding (page 1) is missing for 20-25 percent of deaths a year in 2007-2012, except 2009, when it was entered by hand (about 3 percent missing). About 10 percent were still missing in 2014.
- **`c_haendelsessted`:** Incomplete from 2007, when the electronic death certificate was introduced: many certificates were still sent on paper, and the part with the place of death or finding (page 1) is missing for 20-25 percent of deaths a year in 2007-2012, except 2009, when it was entered by hand (about 3 percent missing). About 10 percent were still missing in 2014.
- **`c_laegefunktion`:** Poorly recorded: missing for most deaths except in 2009 (about 98 percent filled), so Sundhedsdatastyrelsen considers it usable only for 2009.
- **`c_obduktion`:** '.' and -1 mean no information, usually because page 2 of the certificate was missing. Autopsies are likely under-recorded in 2007 (10,330 deaths with causes but no autopsy information).
- **`c_operation`:** Only recorded until June 2008, when this part of the report was dropped as inconsistently filled. From 2009 only -1 and "." occur.
- **`c_praecis_dodssted`:** Incomplete from 2007, when the electronic death certificate was introduced: many certificates were still sent on paper, and the part with the place of death or finding (page 1) is missing for 20-25 percent of deaths a year in 2007-2012, except 2009, when it was entered by hand (about 3 percent missing). About 10 percent were still missing in 2014.
- **`c_praecis_findested`:** Incomplete from 2007, when the electronic death certificate was introduced: many certificates were still sent on paper, and the part with the place of death or finding (page 1) is missing for 20-25 percent of deaths a year in 2007-2012, except 2009, when it was entered by hand (about 3 percent missing). About 10 percent were still missing in 2014.
- **`c_region`:** Uses the region codes valid from 2007 for every year, including 2002-2006, when the regions did not yet exist; for those years it is a geographic area.

</details>

*DST publishes no labels for 2 of these columns. Where the Label column is filled in anyway, it is this guide's reading of the column name, not an official description.*

*No published source gives a data type for 38 of these 41 columns, so the Type column is our own assumption. Check with `sapply(class)` on a row of your own data before relying on it, especially for code columns, which lose their leading zeros if they arrive as numbers.*

**Join key:** `pnr`.

**Joins to other registers:**

- `pnr` joins to **BEF** (many-to-one).

<details>
<summary>Value sets for the coded columns (3)</summary>

| Code system | Values |
| --- | --- |
| `icd10` | Not listed here - see [DST's classification](https://icd.who.int/browse10/) |
| `c_dodsmaade_2002` | `0` Ulykke, `1` Voldshandling, `2` Selvmord, `4` Uoplyst, `5` Naturlig død |
| `c_dodssted` | `-1` Ikke valgt (fordi afdøde er fundet død), `0` Død på sygehus eller hospice, `1` Død på bopælsadressen, `2` Død på kendt adresse, `3` Dødssted uden adresse |

- **`icd10`:** Do not strip a leading D from these codes. The habit comes from LPR, where the D is really there, and applying it here removes the first character of a real code: E119 becomes 119, which matches nothing and raises no error. The danger is worst where a code genuinely begins with D. ICD-10 chapter D covers in-situ and benign neoplasms, so D46 is myelodysplastic syndrome, a whole code. Strip its "prefix" and you get 46, which looks like a code and is not one.
- **`c_dodsmaade_2002`:** This is the set behind the `c_dodsmaade` column in dodsaasg, and the numbers do not mean what the same numbers mean in `dodsaars`. There, under `c_dodsmaade`, 1 is Naturlig død, 2 is Ulykke and 5 is Uoplyst. Here 1 is Voldshandling, 2 is Selvmord and 5 is Naturlig død. A study that spans 2001 and 2002 is reading two different code sets out of two columns with the same name, and every value maps to something plausible in the other set, so nothing looks wrong. A blank is a registration error, not a missing manner of death.
- **`c_dodssted`:** All five codes are valid from 1 January 2002. The variable says nothing about deaths before that, which is the whole period dodsaars covers.

Where these values come from:

- **`icd10`:** [WHO ICD-10 browser](https://icd.who.int/browse10/).
- **`c_dodsmaade_2002`:** [Kodeark for Doedsaarsagsregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Doedsaarsagsregisteret/17_Kodeark_DAR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=17).
- **`c_dodssted`:** [Kodeark for Doedsaarsagsregisteret](https://www.esundhed.dk/-/media/Files/Dokumentation/Doedsaarsagsregisteret/17_Kodeark_DAR---pdf.ashx), published on [www.esundhed.dk](https://www.esundhed.dk/Dokumentation/DocumentationExtended?id=17).

</details>

**Worth knowing:**

- **`d_dodsdato`:** Note the spelling: d_dodsdato here, d_dodsdto in DODSAARS. The two registers do not use the same column names.
- **`c_dodtilgrundl_acme`:** The underlying cause, selected by the ACME algorithm. This is usually the one an analysis wants, rather than the individual certificate lines. The 2002-2004 certificates were coded at the Danish Cancer Society with less follow-up of missing certificates and no forensic reports, so drug deaths and poisonings are under- represented in those years. Since 2013 the ACME tables behind IRIS are used.
- **`c_dod_1a`:** Coding rules are updated regularly and some specific codes have breaks, for example accidents during surgical and medical treatment (group B-097) from 2007 and other accidents (B-098) from 2000.
- **`c_dodsmaade`:** When Sundhedsdatastyrelsen did not receive page 2 of the certificate, this is set to 5 and the underlying cause to R990.
- **`aar`:** A real DST variable in this register, unlike the `year` column the parquet conversion adds to most others. If you have seen `aar` referred to as the partition column elsewhere, this is where the name comes from.
