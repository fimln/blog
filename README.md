# alfi's Blog

Personal blog built with Hugo 0.167.0 and a local adaptation of `no-style-please`.
The dark bluish layout, Fira Sans fonts, images, and search JavaScript are local.
Published URL: `https://blog.alfi.ai.id/`.

On Windows, install the pinned official binary with checksum verification:

```powershell
.\setup.ps1
.\.tools\hugo\hugo.exe server --bind 127.0.0.1 --port 1313 --disableFastRender
```

Open `http://localhost:1313/`. To build and package without publishing:

```powershell
.\package.ps1
python tests/site_test.py dist/site
```

The output is `dist/site/` and `dist/blog-static.zip`. Python is needed only for
the validation script. On other systems, install Hugo 0.167.0 and use `hugo server`
or `hugo --gc`. No Ruby, Bundler, Node.js, or Sass installation is needed.

Posts live in `content/posts/YYYY-MM-DD-title.md`. Set `title`, `date` (including
the time zone), and `slug` in YAML front matter. Existing posts also pin their
original `url`. `<!--more-->` ends the preview excerpt. Optional fields are
`image` (a path or a map with `path`, `alt`, `width`, `height`), `contentLang`,
`tags`, and `categories`. Category labels do not automatically change URLs.

Configuration and navigation are in `hugo.toml`, templates in `layouts/`, and
the editable stylesheet in `assets/css/main.css`. Hugo minifies it to the same
public `/assets/css/main.css` URL. Static files live in `static/`; for example,
`static/assets/images/photo.jpg` is served at `/assets/images/photo.jpg`.
Use ordinary Markdown or HTML paths in articles, not Jekyll Liquid expressions.

Full-text search remains at `/search/` and reads `/search.json`. The JSON output
includes only posts. Pagination uses five posts per page and Hugo's `/page/2/`
pattern; the three migrated posts do not require a second page.

Pushing `master` triggers `.github/workflows/pages.yml`, which builds with the
pinned Hugo binary and deploys `public/` using GitHub Pages Actions. A local
build or preview does not commit, push, or deploy. Review the local preview
before publishing. Dependency sources and licenses are in `DEPENDENCIES.md`.
