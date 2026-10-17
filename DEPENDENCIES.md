# Dependencies and upstream updates

The published site is self-contained: HTML, CSS, JavaScript, search data, fonts,
and images are served locally. Building requires only Hugo 0.167.0. Python 3
is optional for `tests/site_test.py`; the test uses only its standard library.

| Component | Version | Location / source |
|---|---|---|
| Hugo standard edition | 0.167.0 | `.tools/hugo/hugo.exe`; official `gohugoio/hugo` releases |
| no-style-please adaptation | Commit `2f8dba2c23633b21e45dce0fe2e34ec2d79bb1ca` | `assets/css/main.css`, `layouts/`; MIT provenance in `vendor/no-style-please/` |
| Fira Sans Latin WOFF2 | `@fontsource/fira-sans` 5.3.0 | `static/assets/fonts/`; source notes in `vendor/fonts/` |
| Article icons and GitHub stats | Snapshot: 2026-10-03 | `static/assets/images/md-test/`; provenance in `vendor/article-assets/SOURCES.md` |
| Search | Project-owned, no library | `layouts/home.search.json`, `static/assets/js/search.js` |

Hugo versions are pinned in `setup.ps1` and `.github/workflows/pages.yml`.
Both verify the release archive against the official SHA-256 checksum file.
The local binary and generated `public/`, `resources/`, and `dist/` are ignored.
CI keeps the existing pinned GitHub Actions and Ubuntu 24.04 runner.

The Jekyll SCSS was converted to ordinary CSS without changing rule order or
values. Templates were translated from Liquid to Hugo templates. Keep the dark
palette, responsive layout, local fonts, accessibility, and search when updating.
Raw HTML is enabled for the repository's author-controlled article content.

Retain `vendor/no-style-please/LICENSE.txt`, `static/assets/fonts/Fira-LICENSE.txt`,
and the icon/stat licenses beside their assets. GitHub stats are dated SVG
snapshots, not a live statistics service. Do not fetch upstream assets while
rendering pages or building the site.

Build with `.\package.ps1`, then run `python tests/site_test.py dist/site`.
The ZIP can be served from the domain root by a static HTTP server. Search
requires HTTP; opening HTML via `file://` is unsupported. Review desktop and
mobile previews before publishing. No automatic dependency upgrades are made.
