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

### `lmdb.year` - is it a DST variable or a partition column?

The guide lists `year` as an LMDB column ("Dispensing year"). It is **not**
confirmed against DST's variable list, and the LMDB parquet is partitioned by
year, so it is very likely the partition column rather than a DST variable -
exactly the situation `bef.aar` turned out to be.

Until it is checked it carries `source_type: guide_prose` and no `origin`.

```r
colnames(read_register("lmdb"))                      # is `year` there?
list.files("E:/workdata/708421/cleaned-data/parquet-registers/lmdb")[1:5]
```

Folders named `year=1995/`, `year=1996/` settle it: then `year` comes from the
partitioning, and it should be marked `origin: tooling, added_by: fastreg` like
`bef.aar`.

### `lmdb.pnr` - DST's list says `PNR12`

DST's variable list for LMDB has **`PNR12`**, not `PNR`. The column read through
fastreg is `pnr`. Most likely two names for the same thing at different stages,
but it is recorded as `server_verified` rather than as a DST fact until someone
confirms what the raw delivery calls it.

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
