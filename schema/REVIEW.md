# Review list

**Open items only.** Anything resolved is recorded in the schema itself, in the
relevant `note` and `provenance` fields - not repeated here. Duplicating it
would recreate exactly the problem this schema exists to remove.

Regenerate the machine-checkable part with:

```r
source("schema/R/load_schema.R")
unresolved()
```

Last reviewed: 2026-08-31.

---

## Needs a decision or a lookup

*(nothing open)*

---

## Standing notes

These are resolved and correct, but stay visible because a consumer of the
schema has to know about them.

| Item | Why it stays visible |
|---|---|
| `bef.aar` | `origin: tooling`, added by fastreg's parquet conversion. Not a DST variable. Anyone reading BEF through fastreg sees it, so it is in the schema - but a synthetic-data package must not present it as a register fact. |

---

## How to add to this list

Set the field to `null` or `unknown` in the YAML rather than guessing, and add a
row above saying what is missing and where to look. An entry is removed only
when it has been resolved **against a source**, and that source is then written
into `provenance`.
