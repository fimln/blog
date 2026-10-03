---
inclusion: always
---
# Technology and work rules

Jekyll 4.4.1, Ruby 3.3.8, Bundler 4.0.11; locked gems in `Gemfile.lock`.
Markdown/Kramdown, Liquid, Rouge, local Sass/CSS, native JavaScript for search.
no-style-please is a locally adapted fork, not a remote theme or theme gem.
All runtime resources are local. See `DEPENDENCIES.md` for upstream versions.

## Minimal changes

- Read relevant files and Git status first. Preserve unrelated local changes.
- Reuse existing markup/styles and browser APIs. Smallest complete fix wins.
- No unrequested dependency, framework, abstraction, refactor or cleanup.
- Keep `/blog/` links correct with `relative_url`; JSON values use `jsonify`.
- Keep search indexing all published posts; JS loads only on Search and the
  index only after at least two query characters. Render text with `textContent`.
- Do not auto-update upstream files/gems. Preserve pins, licenses and local edits.
- No commit, push, deployment, Pages-setting change or force-push unless requested.
- No browser automation or new test files unless requested. Use focused build,
  syntax/data checks when appropriate; never claim visual checks were performed.
- Do not install tools or create workflows, hooks, specs or plans unless needed
  for the explicit task. Use direct edits rather than an elaborate development workflow.

## Communication

Match the user's language, normally Indonesian. Act within authorized scope.
For routine work, at most one short progress message and a concise final with
what changed, what was checked, and any real limitation. Answer the question
directly. No filler, repeated summaries, unsolicited tutorials or feature tours.
Ask only when missing information materially changes the result or authority.
Explain complex work only when requested; do not hide failures to stay brief.

## Commands

From repository root in a Ruby-enabled terminal (WSL on Windows):

```bash
bundle exec jekyll serve --host 127.0.0.1 --port 4000 --force_polling
JEKYLL_ENV=production bundle exec jekyll build
```

Preview: http://localhost:4000/blog/. Use 4001 if 4000 is occupied; stop with Ctrl+C.
Restart after config changes. Do not run `deploy.sh` as a build/preview command.
PowerShell packaging: `.\package.ps1` (requires WSL Debian and installed gems).
