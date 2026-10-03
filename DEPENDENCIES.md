# Dependencies and upstream updates

The published site is self-contained: HTML, CSS, JavaScript, fonts, images and
search data are served from this repository. External hyperlinks are references,
not resources fetched to render a page. Building still requires Ruby and gems.

## Pinned components

| Component | Local version | Location | Upstream |
|---|---|---|---|
| Ruby | 3.3.8 | `.ruby-version` | https://www.ruby-lang.org/ |
| Bundler | 4.0.11 | `Gemfile.lock` | https://bundler.io/ |
| Jekyll | 4.4.1 | `Gemfile.lock` | https://jekyllrb.com/ |
| Jekyll plugins and transitive gems | Exact versions and checksums in lockfile | `Gemfile`, `Gemfile.lock` | https://rubygems.org/ |
| no-style-please | Commit `2f8dba2c23633b21e45dce0fe2e34ec2d79bb1ca` | `_sass/`, `_layouts/`, `_includes/` | https://github.com/riggraz/no-style-please |
| Fira Sans Latin WOFF2 | `@fontsource/fira-sans` 5.3.0 | `assets/fonts/` | https://www.npmjs.com/package/@fontsource/fira-sans |
| Article icons and GitHub stats | Snapshot: 2026-10-03 | `assets/images/md-test/` | See `vendor/article-assets/SOURCES.md` |
| Search | Project-owned, no library | `search.json`, `assets/js/search.js` | This repository |

## Licenses and local adaptations

- Theme: MIT, `vendor/no-style-please/LICENSE.txt`. Changes are listed in
  `vendor/no-style-please/UPSTREAM.md`. Preserve this fork's dark palette,
  templates, responsive behavior and search when reviewing upstream.
- Fonts: SIL OFL 1.1, `assets/fonts/Fira-LICENSE.txt`.
- Icons: Devicon license file is beside the local assets.
  Logos retain their owners' trademarks. GitHub Readme Stats: MIT, also beside assets.
- Article asset source URLs and SHA-256 hashes: `vendor/article-assets/SOURCES.md`.
- GitHub stats are dated static snapshots; update them explicitly if needed.

## Maintenance

1. Check the relevant upstream release/commit only when an update is requested
   or scheduled by the maintainer. Do not fetch upstream during page loads/builds.
2. Read release notes and compare changes against local adaptations. Do not
   overwrite templates or update every dependency together.
3. Update only the chosen dependency. Preserve licenses, update its recorded
   version/source/hash, and deliberately update the lockfile for gem changes.
4. Build with the locked gems; inspect affected pages, assets and `/blog/` URLs.
   Make only checks justified by the change. Report anything not verified.
5. Keep updates local until publishing is explicitly requested.

## Reproducible build and portable output

Use Ruby from `.ruby-version`, Bundler from the lockfile, and `bundle install`.
In CI, freeze the lockfile (for example, `BUNDLE_FROZEN=true`) after installation.
GitHub Actions can build this source and upload `_site` with the official Pages
artifact/deployment actions. Actual Pages settings and workflow availability
must be checked before publishing; this migration does not restore a workflow.

From PowerShell with Ruby and Bundler installed in WSL Debian:

```powershell
.\package.ps1
```

This creates `dist/blog-static.zip` using a production build in `dist/site`,
without touching the preview `_site` or publishing anything. Extract the package
at the site's `/blog/` path, or deploy its contents as the existing Pages project.
The package requires only a static HTTP server, not Ruby. Search uses HTTP fetch;
opening HTML directly with `file://` is not a supported preview.

The packaging command resolves Ruby/Bundler from the WSL Debian environment.
On another machine, use the documented Jekyll production build and archive its
output. This does not promise offline builds or bundle Ruby/system libraries.
Gem caches can be added later if offline builds become a requirement.
