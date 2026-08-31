# Register schema

A machine-readable description of the Danish registers as they are documented by
Statistics Denmark (DST): register and column names, types, join keys, code
systems, coverage periods.

## What this is, and is not

**It is** structure: what the registers *are*.

**It is not** behaviour: no distributions, base rates, correlations, effect
sizes or confounding. That belongs in a separate scenario layer built on top.
Every register and column has a stable `id` so such a layer can reference them
without this schema changing.

**It contains no data.** Metadata only: zero rows, zero people. Enumerated code
sets (sex, marital status, region) are structural facts and belong here; real
observations do not.

## Layout

```
registers/<id>.yaml      # id matches fastreg's read_register() name
families/<id>.yaml       # facts shared by several datasets, e.g. the LPR2/LPR3 boundary
code-systems/<id>.yaml   # koen, civst, reg, and later icd10, atc ...
R/load_schema.R          # loader and query helpers
REVIEW.md                # everything uncertain, for review
```

## Using it

```r
source("schema/R/load_schema.R")

get_register("bef")        # one register, family fields merged in
get_columns("bef")         # its columns as a data frame
get_code_system("koen")    # a code system
unresolved()               # every fact that is inferred or unsourced
```

## Provenance, not a confirmed flag

Every fact records where it came from:

```yaml
provenance:
  source_url: ...
  source_type: dst_variable_list | dst_documentation | nomenclature | guide_prose | unknown
  verified_on: 2026-08-31
  verified_against: "DST variable list BEF"
  guide_page: register-reference.qmd
  credit: null
```

A boolean `confirmed` would blur three very different things: documented by DST,
observed in one project's delivery, and asserted in a guide page with no source.
For anyone generating synthetic data from this, that difference decides whether
the output matches other projects or only one.

**DST wins.** Where DST's documentation and the guide disagree, DST's version is
used and the guide's is recorded in a note. See REVIEW.md.

## Notes are for readers, not for maintainers

There is one note field, `reader_note`, and it renders onto the guide page. It is
for a caveat a researcher needs while reading the table: which period a code set
is valid for, or that a column is not actually a DST variable.

There is deliberately **no** field for maintenance commentary - where a value came
from, what the guide used to say, why something was decided. That belongs in
`provenance`, which is structured and queryable, or in git history. Free-text
notes about provenance drift out of date and end up contradicting the structured
fields beside them.

## Conventions learned the hard way

**Record the value domain, not just what was observed.** The format tables hold
codes a given delivery does not: `civst` has `9` (Uoplyst) and `reg` has `0`,
neither of which occurs in the DARTER data. A generator that only emits observed
values produces data that is too clean, and code never meets an "Uoplyst" until
it meets real data.

**Codes are version-dependent, and versions of the same thing look alike.** The
first geography format table opened here was `AMT_V1_KT`: the 16 pre-2007
counties (11-14, 21-24, 31-37, 88). The regions are 0 and 81-85, created by the
2007 reform. Mapping one onto the other would have put a county name on every
region code. The same applies to `kom`: v4 is valid from 2007, and before that
the same number can mean a different municipality.

**Never guess a label.** A guess that turns out right teaches the next person
that guessing is fine here; a guess that turns out wrong is invisible until
someone reports a result by region. Unresolved labels stay `null` and go on the
review list.

**Enumerate small sets, link out for large ones.** `reg` (6 codes) is listed
inline. `kom` (98) is `enumerated: false` with a link to DST's classification and
its CSV download: transcribing 98 codes by hand is 98 chances at an error nobody
would notice. If they are ever needed inline, they come from the CSV, not prose.

## Portability

The loader depends on **base R and the `yaml` package only**. It never reads
anything from the guide; the guide reads the schema, not the other way round.
This directory can therefore be moved to its own repository unchanged.
