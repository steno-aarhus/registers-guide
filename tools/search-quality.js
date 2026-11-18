#!/usr/bin/env node

// search-quality.js - measure how well "Search by meaning" ranks.
//
// Runs every query in tools/search-queries.csv through the search page's own
// script and prints where the expected place came out, then a summary.
// Run it with: just check-search
//
// Why node and not R: the ranking is JavaScript inside search.qmd. This file
// takes that script out of the page and runs it unchanged, so the test can
// never disagree with what a reader gets on the site. It uses only what comes
// with node, no packages.
//
// It is a measuring tool, not a gate: it always exits 0, and it is not part of
// check-guide or of any workflow.

const fs = require("fs");
const path = require("path");
const vm = require("vm");

const ROOT = path.join(__dirname, "..");
const read = (file) => fs.readFileSync(path.join(ROOT, file), "utf8");

// The page's script is whatever sits between <script> and </script>.
const pageScript = read("search.qmd").match(/<script>([\s\S]*?)<\/script>/)[1];
const index = JSON.parse(read("assets/search-index.json"));

// The script expects a browser. These are the few browser parts it touches,
// replaced by plain objects: three page elements (the box, the count line, the
// results), a fetch() that hands over the index from disk, and the address.
const elements = {};
let typed;  // the function the page runs when the reader types in the box
function getElementById(id) {
  if (!elements[id]) {
    elements[id] = {
      value: "", innerHTML: "", textContent: "",
      focus() {},
      addEventListener(event, fn) { if (id === "gs-q" && event === "input") typed = fn; },
    };
  }
  return elements[id];
}
const browser = {
  document: { getElementById },
  fetch: () => Promise.resolve({ json: () => Promise.resolve(index) }),
  location: { search: "", pathname: "/search.html" },
  history: { replaceState() {} },
  URLSearchParams,
};

// The result links in the order the page shows them, e.g. "joins.html#joins".
// The page shows the 25 best, so a place further down counts as not found.
function search(query) {
  elements["gs-q"].value = query;
  typed();
  const html = elements["gs-results"].innerHTML;
  return [...html.matchAll(/class="gs-head"><a href="([^"]*)"/g)].map((m) => m[1]);
}

// Position (1 = first) of the first link accepted by ok(), or 0 if none is.
function rank(links, ok) {
  return links.findIndex(ok) + 1;
}

function main() {
  const rows = read("tools/search-queries.csv").split("\n")
    .filter((line) => line.trim() && !line.startsWith("#"))
    .slice(1)  // the header line
    .map((line) => {
      const comma = line.indexOf(",");
      return {
        query: line.slice(0, comma),
        // "a.qmd#x | b.qmd" becomes ["a.html#x", "b.html"], the form links have
        places: line.slice(comma + 1).split("|")
          .map((p) => p.trim().replace(".qmd", ".html")),
      };
    });

  let first = 0, top3 = 0, sectionRows = 0, sectionFirst = 0, sectionTop3 = 0;
  const misses = [];
  console.log("page  section  query  (expected)");
  rows.forEach((row) => {
    const links = search(row.query);
    // Right page: the link goes to an expected page, whatever the section.
    const pages = row.places.map((p) => p.split("#")[0]);
    const pageRank = rank(links, (l) => pages.includes(l.split("#")[0]));
    // Right section: the link is exactly an expected place. Only asked of
    // places that name a section.
    const sections = row.places.filter((p) => p.includes("#"));
    const sectionRank = rank(links, (l) => sections.includes(l));

    if (pageRank === 1) first++;
    if (pageRank >= 1 && pageRank <= 3) top3++; else misses.push(row);
    if (sections.length) {
      sectionRows++;
      if (sectionRank === 1) sectionFirst++;
      if (sectionRank >= 1 && sectionRank <= 3) sectionTop3++;
    }
    row.got = links.slice(0, 3);
    const show = (r) => String(r || "-").padStart(4);
    console.log(show(pageRank) + (sections.length ? show(sectionRank) : "    ") +
      "     " + row.query + "  (" + row.places.join(" | ") + ")");
  });

  const n = rows.length;
  console.log("\nRight page first (hit@1):    " + first + " of " + n);
  console.log("Right page in top 3 (hit@3): " + top3 + " of " + n);
  console.log("Right section, of the " + sectionRows + " queries that name one: first " +
    sectionFirst + ", top 3 " + sectionTop3);
  console.log("\nMisses (right page not in the top 3): " + misses.length);
  misses.forEach((row) => {
    console.log("  " + row.query + "\n    wanted: " + row.places.join(" | ") +
      "\n    got:    " + (row.got.join(", ") || "nothing"));
  });
}

// Start the page's script. It fetches the index and only then starts
// listening for typing, so wait one turn before sending the queries.
vm.runInNewContext(pageScript, browser);
setTimeout(main, 0);
