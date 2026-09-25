import assert from "node:assert/strict";
import { readFile, stat } from "node:fs/promises";
import { dirname, join, resolve } from "node:path";
import test from "node:test";

const root = resolve(import.meta.dirname, "..");
const pages = ["index.html", "about.html", "faq.html", "release-notes.html", "support.html", "privacy.html", "age-suitability.html", "404.html"];
const read = (path) => readFile(join(root, path), "utf8");

test("public pages retain their accessible static foundation", async () => {
  for (const page of pages) {
    const html = await read(page);
    assert.match(html, /<html lang="en">/);
    assert.match(html, /<meta name="viewport"/);
    assert.match(html, /<title>/);
    assert.match(html, /<main/);
    assert.match(html, /skip-link/);
  }
});

test("local links and assets resolve", async () => {
  for (const page of pages) {
    const html = await read(page);
    for (const [, value] of html.matchAll(/(?:href|src)="([^"]+)"/g)) {
      if (/^(?:https?:|mailto:|#)/.test(value)) continue;
      const pathOnly = value.split("#")[0].split("?")[0];
      if (!pathOnly) continue;
      const absolute = resolve(root, dirname(page), pathOnly);
      const info = await stat(absolute);
      if (info.isDirectory()) await stat(join(absolute, "index.html"));
    }
  }
});

test("canonical host, attribution, and irreplaceable content stay present", async () => {
  const maintained = await Promise.all(pages.slice(0, 7).map(read));
  const combined = maintained.join("\n");
  assert.doesNotMatch(combined, /savioronezero\.github\.io/);
  assert.match(combined, /https:\/\/not-there-yet\.sync33\.com\//);
  assert.match(combined, /A Sync33 Laboratories product/);
  for (const phrase of ["Road Crew", "Great Britain", "Adventure Log", "Age Suitability", "v1.0", "v1.4"]) {
    assert.ok(combined.includes(phrase), `missing preserved content: ${phrase}`);
  }
  const home = maintained[0];
  assert.equal([...home.matchAll(/assets\/screenshots\//g)].length, 7, "seven product screenshots must remain");
});
