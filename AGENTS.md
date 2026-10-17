# Project guidance

- Reply in the user's language, usually Indonesian. Make the smallest complete
  change; preserve unrelated work. Do not add dependencies or features unasked.
- This is a public, static Hugo 0.167.0 blog at `https://blog.alfi.ai.id/`.
  Use standard Hugo, Go templates, ordinary CSS and native JavaScript.
  No Ruby, Sass, Node.js build step, backend or external runtime assets.
- Posts: `content/posts/YYYY-MM-DD-title.md`. Preserve existing `slug`, `url`,
  dates and article text. Use explicit time zones and `<!--more-->` for excerpts.
  Images go in `static/assets/images/`, referenced as `/assets/images/...`.
- Templates: `layouts/`; stylesheet: `assets/css/main.css`; configuration:
  `hugo.toml`; search: `layouts/home.search.json` and `static/assets/js/search.js`.
- Preserve the dark palette, local Fira Sans, desktop post width, stable scrollbar
  gutter, responsive layout, accessibility, permalinks and licenses. Home lists
  posts directly. Keep search UI minimal and its index limited to posts.
  Do not add analytics, RSS, comments, live widgets or new branding.
- Article HTML is trusted author content. Keep JSON escaped with `jsonify` and
  search text rendered with `textContent`.
- Never commit credentials, private email addresses, machine paths, local notes,
  generated output or downloaded tools. Inspect staged changes before committing.
  Tracked drafts and Git history are public; `static/` is copied into the site.
  Preserve intentional public author identity and third-party attribution.
  Report historical exposure without repeating sensitive values. Do not rewrite
  history or force-push without explicit authorization.
- Keep Hugo pins in `setup.ps1` and `.github/workflows/pages.yml` aligned when
  an upgrade is requested. Keep checksum verification and pinned Actions.

## Local verification

```powershell
.\setup.ps1
.\.tools\hugo\hugo.exe server --bind 127.0.0.1 --port 1313 --disableFastRender
.\package.ps1
python tests/site_test.py dist/site
```

Preview at `http://localhost:1313/`. For template or CSS edits, check desktop and
mobile, including home-to-post navigation. Report only checks actually run.
Keep README concise and update it when documented behavior changes.

Do not commit, push or deploy without authorization. Preview locally before
publishing; pushing `master` triggers GitHub Pages. When publication is requested,
wait for Actions to finish and report its result. Never commit `.tools/`, `dist/`,
`public/`, `resources/` or local deployment scripts.
