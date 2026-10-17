---
inclusion: always
---
# Structure

- `content/posts/`: `YYYY-MM-DD-title.md`, explicit date and original URL.
- `content/_index.md`, `content/search.md`: home and search metadata.
- `layouts/`, `layouts/_partials/`: Hugo templates, including 404 and search JSON.
- `assets/css/main.css`: upstream baseline followed by local styles; rule order matters.
- `static/assets/fonts/`, `static/assets/images/`, `static/assets/js/`: local runtime assets.
- `static/CNAME`, `static/favicon.ico`: domain and icon, copied to output root.
- `hugo.toml`: metadata, menu, URLs, pagination, Markdown, output formats.
- `vendor/`: provenance and licenses; font source notes (not published).
- `README.md`, `DEPENDENCIES.md`: update when documented behavior changes.
- `.github/workflows/pages.yml`: pinned Hugo build and GitHub Pages deployment.
- `setup.ps1`: install pinned Hugo with checksum verification.
- `package.ps1`: local static build and ZIP; never publishes.
- `tests/site_test.py`: standard-library production-output checks.
- Local deployment menus: `deploy.ps1`, `deploy.sh`; no push without authorization.
- Generated, never commit: `.tools/`, `public/`, `resources/`, `dist/`, `.hugo_build.lock`.
- Historical Jekyll output/cache may remain ignored in `_site/` and `.jekyll-cache/`.
