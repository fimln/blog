---
inclusion: always
---
# Tech

Jekyll 4.4.1, Ruby 3.3.8 (`.ruby-version`), Bundler 4.0.11, gems locked in
`Gemfile.lock`. Kramdown GFM, Liquid, Rouge, Sass. Plugins: jekyll-paginate,
jekyll-sitemap, jekyll-seo-tag. no-style-please is a vendored, locally adapted
fork (not a gem or remote theme). Search uses native JavaScript only.
Versions and upstreams: `DEPENDENCIES.md`.

## Code rules

- Internal links and assets use `relative_url` (baseurl `/blog`).
- JSON values use `jsonify`. Search results render with `textContent`.
- Search indexes all published posts. JS loads only on `/search/`; the index
  is fetched only after 2+ query characters.
- Do not change versions, pins, vendored upstream files or licenses.
- No new gems, npm packages, CDNs or frameworks.

## Commands

WSL terminal, repository root:

```bash
bundle exec jekyll serve --host 127.0.0.1 --port 4000 --force_polling
JEKYLL_ENV=production bundle exec jekyll build
```

Preview http://localhost:4000/blog/ (4001 if busy). Restart after
`_config.yml` changes. `.\package.ps1` (PowerShell) builds
`dist/blog-static.zip` via WSL Debian.

## Verification

Run the production build after changes; add focused syntax or data checks only
when relevant. No browser automation or new test files unless asked. Never
claim a visual check was done.

## Git and publishing

Pushing `master` deploys via `.github/workflows/pages.yml`. No commit, push,
force-push, Pages-setting change or `deploy.ps1`/`deploy.sh` run unless asked.
Check `git status` first and preserve unrelated local changes.
