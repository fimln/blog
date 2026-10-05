# Implementation Plan: minimal-dependencies-cleanup

## Overview

Capture a HEAD reference build first, then make the small edits from the design (gem manifest, `_config.yml`, two stylesheets, one sentence in `UPSTREAM.md`), then verify with a candidate build, a disposable comparison script outside the repository and focused reviews. All agent-run builds run in WSL Debian with `JEKYLL_ENV=production`, `BUNDLE_FROZEN=true`, an external destination under `/tmp/mdc/` and `--disable-disk-cache`.

Constraints for every task: no PBT framework, no new test files in the repository, no new dependencies, no `bundle lock`/`bundle install`, no commit, push or deploy. Protected_Files (`README.local.md`, `deploy.ps1`, `deploy.sh`, `.claude/`, `_site/`, `dist/`, `.jekyll-cache/`, the deleted `assets/icons/` files) stay untouched. Layouts, includes, search files, `pages.yml`, `package.ps1`, `.ruby-version` and `.kiro/steering/` are not edited.

## Tasks

- [x] 1. Capture the reference build before any edit
  - [x] 1.1 Build the HEAD reference into `/tmp/mdc`
    - Record `git rev-parse HEAD`, `git status --short` and `git diff --stat` (expect HEAD `e72e13b`, nine unstaged `assets/icons/` deletions, modified `.kiro/steering/*.md`, untracked `.kiro/specs/`)
    - `git archive HEAD | tar -x -C /tmp/mdc/src-ref`, then in it run the production build with `-d /tmp/mdc/out-ref --disable-disk-cache`, logging to `/tmp/mdc/ref.log`
    - If the reference build fails, stop and report
    - _Requirements: 4.5, 5.1, 6.4_

- [x] 2. Clean the gem manifest
  - [x] 2.1 Edit `Gemfile`
    - Remove the `group :development` block with `webrick` and the `# Windows helpers` block (`tzinfo`, `tzinfo-data`, `wdm`); trim surrounding blank lines so the file ends with the plugin group `end` plus a newline
    - Keep `source`, `gem "jekyll", "~> 4.4.1"` and the `:jekyll_plugins` group unchanged
    - _Requirements: 1.1, 2.1, 2.2, 2.4_
  - [x] 2.2 Hand-edit `Gemfile.lock`
    - Remove exactly the four `DEPENDENCIES` lines: `tzinfo (>= 1, < 3)`, `tzinfo-data`, `wdm (~> 0.1)`, `webrick (~> 1.8)`
    - Leave `GEM`/`specs` (including `webrick (1.9.2)`), `PLATFORMS`, `CHECKSUMS` and `BUNDLED WITH 4.0.11` byte-identical
    - _Requirements: 2.1, 2.2, 2.3, 2.4_
  - [x] 2.3 Run the frozen manifest check (Property 2)
    - `sha256sum Gemfile.lock > /tmp/mdc/lock.before`, `BUNDLE_FROZEN=true bundle check`, `BUNDLE_FROZEN=true bundle exec jekyll --version`, `sha256sum -c /tmp/mdc/lock.before`
    - `git diff -U0 -- Gemfile.lock` shows only the four removed lines and no added lines
    - On mismatch, stop, restore the hand-edited lockfile and report; do not let Bundler re-resolve
    - **Property 2: Lockfile change is removal-only**
    - _Requirements: 2.3, 2.4, 2.5_

- [x] 3. Update `_config.yml`
  - [x] 3.1 Disable source maps and exclude the two font documents
    - Add `sourcemap: never` under `sass` (keep `style: compressed`)
    - Append `assets/fonts/README.md` and `assets/fonts/SOURCE.txt` after the last `exclude` entry (`README.md`)
    - Leave `plugins`, `keep_files`, pagination, permalink and every other key and exclude entry unchanged; add no `assets/icons/` entry
    - _Requirements: 1.2, 3.4, 4.1, 4.3, 4.4, 6.5_

- [x] 4. Remove redundant CSS
  - [x] 4.1 Edit `_sass/no-style-please.scss` per the design table
    - Remove only the listed declarations (`html, body` background and its comment, `html` scroll-behavior, `body` color/font-family/font-size/line-height, `.post-meta`, first `hr` margin, `*:target`, `.w` max-width/padding, second `hr` `&:before`/`&:after`, `code` color/background, `div.highlighter-rouge code` display/white-space/padding, `blockquote` font-style/border); drop rules that become empty
    - Keep every declaration marked kept or uncertain in the design, the file name and the remaining upstream rules
    - _Requirements: 3.1, 3.2, 3.5, 3.6, 3.7_
  - [x] 4.2 Edit `assets/css/main.scss`
    - Remove only `hr::before, hr::after { content: none; }`; leave palette variables, `@font-face` blocks and the 480/700/767px media queries untouched
    - _Requirements: 3.2, 3.5, 3.6_

- [x] 5. Update theme provenance
  - [x] 5.1 Edit `vendor/no-style-please/UPSTREAM.md`
    - Extend the line 8 sentence ("with the inversion-based theme switcher removed") to also state that declarations overridden by `assets/css/main.scss` were removed; no other doc edits, `LICENSE.txt` unchanged
    - _Requirements: 3.7, 6.7_

- [x] 6. Checkpoint
  - Ensure all edits match the design, ask the user if questions arise.

- [x] 7. Verify the candidate build
  - [x] 7.1 Build the candidate from the repository
    - Same production build as 1.1 with `-d /tmp/mdc/out-cand --disable-disk-cache`, logging to `/tmp/mdc/cand.log`
    - _Requirements: 2.5, 5.2, 6.4_
  - [x] 7.2 Write and run `/tmp/mdc/compare.rb` (Properties 1 and 3)
    - Ruby stdlib only, outside the repository: SHA-256 per file, `search.json` compared as parsed JSON, list added/removed/changed paths
    - Classify differences as Allowed (changed `assets/css/main.css`, removed `main.css.map`, `assets/fonts/README.md`, `assets/fonts/SOURCE.txt`), Pre-existing (9 removed `assets/icons/*`) or Unexpected (anything else, exit non-zero)
    - Check candidate `main.css` keeps the palette, `Fira Sans`, `font-display:swap`, the three WOFF2 files and the 480/700/767px max-width media queries, has no `sourceMappingURL` and no `hr` pseudo-element selector, and is smaller in bytes; print both sizes
    - On an Unexpected difference, revert the causing CSS or config change, rebuild and rerun
    - **Property 1: Output equivalence modulo allowed differences**
    - **Property 3: Compiled stylesheet is smaller and keeps required tokens**
    - _Requirements: 1.3, 3.3, 3.4, 3.5, 4.1, 4.2, 4.5, 5.3, 5.4, 5.5_
  - [x] 7.3 Diff the build logs
    - Diff `ref.log` and `cand.log` after dropping `done in`, `Source:` and `Destination:` lines; investigate any new error or warning
    - _Requirements: 5.2_
  - [x] 7.4 Focused CSS review
    - Split both `main.css` files on `}` and `diff`; confirm every removed declaration is in the design table and nothing else changed; record byte sizes and the `main.css.map` removal
    - _Requirements: 3.1, 3.3, 3.6, 3.8_
  - [x] 7.5 Scope check
    - `git status --short` and `git diff --stat` show changes only in `Gemfile`, `Gemfile.lock`, `_config.yml`, the two stylesheets and `UPSTREAM.md`, beyond the pre-existing state recorded in 1.1
    - Icons still deleted and unstaged; Protected_Files untouched; no `_plugins/`, SEO include, sitemap/robots template or vendored plugin copy added
    - _Requirements: 1.4, 1.5, 4.4, 6.1, 6.4, 6.6, 6.8, 6.9_
  - [x] 7.6 Clean up `/tmp/mdc/`
    - Remove the reference source, both outputs, logs, `lock.before` and `compare.rb` after results are recorded
    - _Requirements: 5.6_

- [x] 8. Final report
  - [x] 8.1 Report results in the user's language
    - What changed, completed automated checks (reference/candidate builds, manifest check, comparison, log diff, CSS review with before/after sizes, scope check)
    - List as unverified: visual equivalence across Page_Kinds at desktop and below 768px, Ubuntu 24.04 CI run with `BUNDLE_FROZEN=true`, `bundle exec jekyll serve`, `.\package.ps1`
    - No claims of page-load or install-time improvements; no commit, push or deploy
    - _Requirements: 2.6, 3.8, 5.7, 6.2, 6.3, 6.9_

## Notes

- Verification sub-tasks are not optional: the design's Testing Strategy makes them the required check, done once against real builds without a PBT library.
- Properties 1 to 3 from the design are checked by tasks 2.3 and 7.2.
- Any Bundler mismatch or Unexpected output difference stops the flow per the design's Error Handling.

## Task Dependency Graph

```json
{
  "waves": [
    { "id": 0, "tasks": ["1.1"] },
    { "id": 1, "tasks": ["2.1", "2.2", "3.1", "4.1", "4.2", "5.1"] },
    { "id": 2, "tasks": ["2.3"] },
    { "id": 3, "tasks": ["7.1"] },
    { "id": 4, "tasks": ["7.2", "7.3", "7.4", "7.5"] },
    { "id": 5, "tasks": ["7.6"] },
    { "id": 6, "tasks": ["8.1"] }
  ]
}
```
