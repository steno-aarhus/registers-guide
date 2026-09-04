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
REVIEW.md                # local only, gitignored: see below
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
  source_type: dst_variable_list | dst_documentation | nomenclature | unverified | unknown
  verified_on: 2026-08-31
  verified_against: "DST variable list BEF"
  guide_page: register-reference.qmd
  credit: null
```

A boolean `confirmed` would blur two very different things: documented by DST,
and asserted with no published source behind it. For anyone generating synthetic
data from this, that difference decides how much weight the value carries.

**DST wins.** Where DST's documentation and the guide disagree, DST's version is
used and the guide's is recorded in a note.

### What `unverified` means

`unverified` means exactly that: no published source states this, so it is a
working assumption and should be read as one. Types are the usual case, because
DST publishes none (see below), and so is any name or label that DST's own pages
do not spell out.

Nothing in this schema is derived from data held on the DST server. Facts come
from DST's and Sundhedsdatastyrelsen's published documentation, and where those
are silent the field says `unverified` rather than being filled in from
somewhere else. Anything about your own delivery is yours to check inside your
project, with the results-export procedure for anything that leaves.


## What `coverage` means

`coverage` is **what DST documents that it holds**, dated by
`provenance.verified_on`. It is not what your project was delivered: that is a
subset chosen when the data was ordered, and no single answer is true for
everyone. Check your own extract before relying on the range.

Two DST sources give it, and they agree: the per-register variable list linked
from each register's `source_url`, and [DST's order
list](https://www.dst.dk/extranet/forskningvariabellister/Bestillingsliste.xlsx),
a spreadsheet of every variable in every DST register with its period. The order
list is the faster one to work from - 30,921 rows covering 532 registers - and
it is what the column-level `coverage` values were filled from. Health registers
are documented separately by Sundhedsdatastyrelsen on
[esundhed.dk](https://www.esundhed.dk/Dokumentation), which is the only source
found so far that publishes **data types**.

## Notes are for readers, not for maintainers

There is one note field, `reader_note`, and it renders onto the guide page. It is
for a caveat a researcher needs while reading the table: which period a code set
is valid for, or that a column is not actually a DST variable.

There is deliberately **no** field for maintenance commentary - where a value came
from, what the guide used to say, why something was decided. That belongs in
`provenance`, which is structured and queryable, or in git history. Free-text
notes about provenance drift out of date and end up contradicting the structured
fields beside them.

## Everything is written in English

The sources are Danish. The schema is not: labels, notes and derivations are
written in English so the whole thing reads as one document.

What makes that safe is `provenance.source_url` on every fact. A reader who
wants DST's own wording follows the link and finds it, so nothing is lost by
rendering it in English here.

Danish is kept in exactly two places, where it is the fact rather than a
description of one:

- `label.da` - DST's own label, beside our `label.en`.
- Code values and their Danish labels in `code-systems/`, because "Ugift" is
  what the format table says and translating it would make the lookup wrong.

## A column name can change on the way to you

`name` is the column as DST documents it. What you read may differ: LMDB is
documented as `PNR12` but arrives as `pnr`. Treat a name here as a starting
point and confirm with `colnames()`.

## Conventions learned the hard way

**Record the value domain the format table publishes, not a shorter list.** The
format tables hold codes a given delivery may never contain: `civst` has `9`
(Uoplyst) and `reg` has `0`. A generator built from a shortened list produces
data that is too clean, and code never meets an "Uoplyst" until it meets real
data.

**Codes are version-dependent, and versions of the same thing look alike.** The
first geography format table opened here was `AMT_V1_KT`: the 16 pre-2007
counties (11-14, 21-24, 31-37, 88). The regions are 0 and 81-85, created by the
2007 reform. Mapping one onto the other would have put a county name on every
region code. The same applies to `kom`: v4 is valid from 2007, and before that
the same number can mean a different municipality.

**Check whether the source has already answered it before writing a query.** The
VNDS successors overlap the old register by twenty years, and the obvious next
step was a row count on the server to see whether they were a copy. DST's own
two-paragraph notice about the split said outright that the old register
contained duplicates and that the split was the fix. The query would also have
been impossible: the project at hand has no VNDS_UD.

**A delivery is narrower than the register.** DST's variable list describes the
register; a project receives only the variables it ordered. Document what DST
publishes and warn that it has to be ordered - never delete a column because one
delivery lacks it. The clean proof: `lpr_adm` in one delivery has no
`c_pattype`, `c_indm`, `c_sgh`, `c_afd` or `v_alder`, while `t_psyk_adm` in the
*same* delivery has all of them.

**Column names can come from the data processing.** DST gives both psychiatric
tables `RECNUM` and `PNR`; one delivery hands them over as `k_recnum`,
`v_recnum` and `v_cpr`, so one key ends up with three names. DST's names are
canonical here and in the general chapters, with the delivery-specific name in a
`reader_note`. The `darter-*` pages use the DARTER names, which is correct there.

**The guide is not an independent source.** Every word of it was written from
one delivery, so when the guide and the data agree that is one source, not two.
Corroboration means DST's own documentation, or a second delivery. This produced
a real error: `c_dod1` to `c_dod4` were deleted from the site because DST's page
supposedly lacked them. It did not.

**DST publishes no data types. Do not look again.** Checked 2026-09-02 against
the BEF and AKM variable lists, the order list, DST's own documentation overview
(*"no reference to formats whatsoever"*) and the per-variable Times pages, which
give a definition and nothing technical. So a `type` on a DST register is a
reading of the column name unless `provenance.type_source` says otherwise. When
FAIK was finally checked against data, six of nine `character` guesses were
wrong.

Two things do exist. Sundhedsdatastyrelsen publishes `Format` and `Laengde` per
variable on [esundhed.dk](https://www.esundhed.dk/Dokumentation), which covers
LPR2, LMDB, the death registers and the cancer register. And on the server, a
SAS format whose name starts with `$` is a character format, so the format
catalogue implies the type - but `sapply(class)` on one row answers it directly
and is the method the review list uses.

It matters most for code columns stored as numbers, which lose their leading
zeros.

**Establishing a type must not require taking data out.** Use `head(0)`, which
returns the column structure with zero rows: the classes are still correct
because a data frame carries its types independently of its contents, and the
output is a list of names and the words character, numeric, Date. `glimpse()`
and `head(1)` print real values from real records, so they are the right tools
for looking at data inside DST and the wrong ones for producing anything that
leaves. Everything that leaves goes through the official results-export
procedure, a list of column types included.

**A type checked against data is evidence about one delivery, not the register.**
`class()` can only be run on the columns a project actually ordered, so a
register documented at 40 columns may only ever get types for the 12 it
received. The rest stay inferred until somebody with a wider delivery checks
them, and that is a permanent limitation rather than a task on a list. The type
also comes from whoever converted the SAS files to parquet, so a second project
could in principle get a different one for the same column. `type_source` names
the delivery and the date for exactly this reason.

**Never guess a label.** A guess that turns out right teaches the next person
that guessing is fine here; a guess that turns out wrong is invisible until
someone reports a result by region. Unresolved labels stay `null` and go on the
review list.

**Enumerate small sets, link out for large ones.** `reg` (6 codes) is listed
inline. `kom` (98) is `enumerated: false` with a link to DST's classification and
its CSV download: transcribing 98 codes by hand is 98 chances at an error nobody
would notice. If they are ever needed inline, they come from the CSV, not prose.

## Validation

```r
source("schema/R/load_schema.R")
source("schema/R/validate_schema.R")
validate_schema()
```

Returns a data frame of problems with a `severity`:

- **error** - the schema is wrong. A type outside the allowed set, a duplicate
  id, a `code_system` with no file, a join key that is not one of the register's
  own columns.
- **warning** - the schema is incomplete. A relationship pointing at a register
  that has not been written yet is normal while the schema is being built out,
  and it stays visible until that file exists.

The validator lives here rather than in the consuming project, so it travels
with the schema.

## Portability

The loader depends on **base R and the `yaml` package only**. It never reads
anything from the guide; the guide reads the schema, not the other way round.
This directory can therefore be moved to its own repository unchanged.

## One field that is editorial, not factual

`key: true` on a column decides what the generated table shows. It is a
judgement call, not a fact about the register, and it lives in the schema so the
decision is reviewable in a diff rather than hidden in the generator.

It marks the handful of columns a researcher actually reaches for; everything
else folds into a `<details>` block, with its `reader_note` going along. Rule of
thumb: every column used in a code example in the guide must be marked, and a
register wants roughly four to ten.

A deprecated register still gets a normal open table. Being superseded is not
the same as being unusable: LPR2, `vnds_hist`, `sysi` and the older death
registers are each the only source for their own years, and `vnds` is still the
only migration register many projects have, because the three replacements are
so new.
