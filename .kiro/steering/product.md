---
inclusion: always
---
# Product and scope

Personal Jekyll blog, a GitHub Pages project site at https://fimln.github.io/blog/.

## Scope

- Do only what the user asked, with the smallest complete change.
- These steering files describe what already exists and must be kept. They are
  not a backlog. Do not implement, extend or "improve" anything listed here
  unless asked.
- No unrequested features, pages, UI copy, settings, dependencies, refactors,
  cleanups, tests or documentation.
- No specs, plans, workflows, hooks, MCP servers or extra tooling unless the
  task explicitly needs them. Edit files directly.
- Ask first only when a request is ambiguous in a way that changes the result,
  or conflicts with these rules.
- Reply in the user's language (usually Indonesian). Final report: what
  changed, what was checked, real limitations.

## Keep as is

- Articles, permalinks, attribution, licenses and accessibility.
- Permanent dark bluish palette and local Fira Sans. No theme toggle.
- Home lists posts directly: no hero, intro or large heading.
- About: no large heading; content and social links unchanged.
- Post lists: cards from 768px up; below 768px no card background, border or
  padding, entries separated by a thin line and spacing.
- Footer centered: "Made with love and coffee by Alfi", links to Jekyll and theme.
- `/search/`: only input, Search button and results. No visible title, label,
  placeholder, instructions or result count. Input keeps a nonvisual label.
  Results reuse post list styles.

## Never add

RSS, analytics, comments, live widgets, external runtime assets, a backend or
new branding.
