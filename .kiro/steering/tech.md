---
inclusion: always
---
# Tech

Hugo 0.167.0 standard edition, Goldmark, Go templates, ordinary CSS.
no-style-please is adapted locally. Search uses native JavaScript only.
Versions, sources, licenses: `DEPENDENCIES.md`. No Ruby, Sass, or Node.js build step.

## Code rules

- Preserve public article and asset URLs at the domain root.
- JSON values use `jsonify`; search results render with `textContent`.
- Search indexes only posts. JS loads only on `/search/`; data is fetched after 2+ characters.
- Article HTML is author-controlled and rendered by Goldmark with unsafe enabled.
- Do not change dependency pins, licenses, branding, or responsive behavior without request.
- No new packages, CDNs, frameworks, RSS, or external runtime assets.

## Commands

```powershell
.\setup.ps1
.\.tools\hugo\hugo.exe server --bind 127.0.0.1 --port 1313 --disableFastRender
.\package.ps1
python tests/site_test.py dist/site
```

Preview: http://localhost:1313/ . The package is `dist/blog-static.zip`.
Run focused checks after changes. Compare desktop/mobile against the existing
layout when changing templates or CSS; report only checks actually performed.

## Git and publishing

Pushing `master` deploys via `.github/workflows/pages.yml`. No commit, push,
force-push, Pages-setting change, or deployment-menu run unless authorized.
Check Git status first; preserve unrelated changes. The migration must be
reviewed locally before commit and push.
