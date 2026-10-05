---
inclusion: always
---
# Structure

- `_posts/`: `YYYY-MM-DD-title.md`, front matter `layout: post`.
- `_layouts/`, `_includes/`: templates. Keep layout names used by content.
- `index.html`, `about.md`, `404.html`: pages.
- `search.html`, `search.json`, `assets/js/search.js`: search page, index, behavior.
- `_sass/no-style-please.scss`: upstream baseline, keep minimal edits.
  Custom styles go in `assets/css/main.scss`.
- `assets/fonts/`: Fira Sans WOFF2 with license. `assets/images/`: local images.
- `_config.yml`: metadata, menu, plugins, permalink, pagination, excludes.
- `vendor/`: theme provenance and licenses (not published).
- `README.md`, `DEPENDENCIES.md`: update only when documented behavior changes.
- `.github/workflows/pages.yml`: deploy pipeline. Do not edit unless asked.
- Local and untracked, leave alone: `README.local.md`, `deploy.ps1`, `deploy.sh`,
  `.claude/`.
- Generated, never hand-edit or commit: `_site/`, `dist/`, `.jekyll-cache/`.
