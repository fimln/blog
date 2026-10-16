# alfi's Blog

Personal blog built with Jekyll and a locally vendored `no-style-please` theme, featuring a dark bluish color scheme and self-hosted Fira Sans fonts. The site is published at `https://blog.alfi.ai.id/` with category and slug permalinks (`/:categories/:title/`).

To run locally, install the Ruby version specified in `.ruby-version` and Bundler from `Gemfile.lock`, then run `bundle install` and `bundle exec jekyll serve --host 127.0.0.1 --port 4000 --force_polling` from the repository root. For a production build, run `JEKYLL_ENV=production bundle exec jekyll build`, or execute `.\package.ps1` to generate a self-contained static archive at `dist/blog-static.zip`.

Posts live in `_posts/YYYY-MM-DD-title.md` with `layout: post`, optional `image:` metadata, and optional `lang:` overrides. Site metadata and navigation are configured in `_config.yml`, styles in `assets/css/main.scss`, and templates in `_layouts/` and `_includes/`. Full-text client-side search is served at `/search/` via `search.json` and `assets/js/search.js`.

All runtime assets, fonts, and icons are self-hosted in `assets/` and `vendor/`. Version pins, licenses, and upstream provenance are documented in `DEPENDENCIES.md`.

Pushing to `master` builds and deploys the `_site` artifact to GitHub Pages via `.github/workflows/pages.yml`. The custom domain `blog.alfi.ai.id` uses a proxied Cloudflare `CNAME` pointing to `fimln.github.io`, while legacy `/blog` paths on `alfi.ai.id` redirect to `https://blog.alfi.ai.id` via Cloudflare Single Redirects.
