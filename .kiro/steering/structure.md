---
inclusion: always
---
# Structure

- `_posts/`: dated Markdown and front matter (`layout: post`).
- `_layouts/`, `_includes/`: local templates; preserve layout names used by content.
- `_sass/no-style-please.scss`: adapted upstream baseline; custom styling belongs
  in `assets/css/main.scss`.
- `assets/fonts/`: Fira Sans WOFF2, version/source and license.
- `assets/images/`: local article images/icons; stats are dated SVG snapshots.
- `search.html`, `search.json`, `assets/js/search.js`: search page/index/behavior.
- `_config.yml`: metadata, navigation, plugins, permalink, pagination, excludes.
- `vendor/`: provenance/licenses, excluded from publication.
- `README.md`, `DEPENDENCIES.md`: run commands and maintenance contract.
- `package.ps1`: production build and ZIP, no publishing.
- `_site/`, `dist/`, caches: generated; do not hand-edit or commit.
- `.kiro/steering/`: short always-included context, excluded from publication.

Change only relevant files. Keep documentation accurate when behavior changes;
do not produce additional documentation artifacts unless requested.
