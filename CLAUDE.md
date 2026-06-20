# CLAUDE.md

Project instructions for this guide (registerbaseret forskning på DST).

## Skrivestil / writing style

- **Ingen em-dashes** (den lange tankestreg, Unicode U+2014). Brug den aldrig i tekst.
  Omskriv i stedet med komma, kolon, parentes eller punktum. Hvis en tankestreg er
  nødvendig, så brug en almindelig bindestreg med mellemrum (` - `). Dette gælder begge
  sprog (da + en) og alt indhold: brødtekst, overskrifter, titler/undertitler,
  sidebar-labels, callouts og kodekommentarer.
  *(No em-dashes (U+2014) anywhere. Same rule both languages.)*

## Bilingual + build

- Alt indhold findes på **både `docs/da` og `docs/en`**. Ret altid begge og hold paritet
  (overskrifter, callouts, kodeblokke, links, tabelrækker).
- Quarto bygges **ikke lokalt**, så verificér via GitHub Actions. `docs/_site/` er genereret
  output (gitignored); rediger aldrig der, kun kilden (`.qmd`, `_quarto.yml`, `custom.scss`,
  `_feedback.html`).
