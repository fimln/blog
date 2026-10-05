# Requirements Document

## Introduction

The blog is a Jekyll 4.4.1 site deployed to https://fimln.github.io/blog/
(baseurl `/blog`) by `.github/workflows/pages.yml`.

This feature is limited to redundant CSS cleanup, disabling the CSS source map,
excluding two supporting documents from publication, and removing redundant or
unused direct gem declarations for the existing WSL/Linux build environment.
The rendered UI, features, URLs and metadata stay equivalent.

Keep jekyll-seo-tag 2.9.0, jekyll-sitemap 1.4.0 and jekyll-paginate 1.1.0 as gems.
Replacing or vendoring plugins, refactoring templates or search, and broadly
pruning configuration are outside this feature. These requirements supersede
the previous plugin-replacement scope; regenerate the design before implementation.

## Glossary

- **Site_Build**: A production `bundle exec jekyll build` using the locked gems in WSL Debian, with an external destination and disk cache disabled.
- **Reference_Output**: Output built from a pre-feature source snapshot before implementation. Record its commit and relevant working-tree differences so unrelated edits are not attributed to this feature.
- **Candidate_Output**: Output built after implementation under the same environment and configuration, except for authorized changes.
- **Allowed_Difference**: An output difference explicitly permitted by these requirements.
- **Gem_Manifest**: `Gemfile` and `Gemfile.lock`.
- **Theme_Baseline**: `_sass/no-style-please.scss`.
- **Custom_Stylesheet**: `assets/css/main.scss`.
- **Compiled_Stylesheet**: `assets/css/main.css` in the build output.
- **Page_Kind**: Home, paginated home, post with cover image, post without cover image, post with `lang` front matter, About, Search and 404.
- **Publication_Documents**: `assets/fonts/README.md` and `assets/fonts/SOURCE.txt`.
- **User_Deleted_Icons**: The nine previously deleted tracked files under `assets/icons/`, unrelated to this feature.
- **Protected_Files**: `README.local.md`, `deploy.ps1`, `deploy.sh`, `.claude/`, `_site/`, `dist/`, `.jekyll-cache/` and the User_Deleted_Icons paths.

## Requirements

### Requirement 1: Preserve the existing plugins and behavior

**User Story:** As the blog owner, I want to retain the existing plugins, so that cleanup does not introduce custom implementations to maintain.

#### Acceptance Criteria

1. THE Gem_Manifest SHALL retain `jekyll ~> 4.4.1`, `jekyll-seo-tag = 2.9.0`, `jekyll-sitemap = 1.4.0` and `jekyll-paginate = 1.1.0` as direct dependencies.
2. THE `_config.yml` plugin list SHALL remain unchanged, with all three plugins enabled.
3. THE feature SHALL retain `{% seo %}` in `_includes/head.html` and the existing plugin-generated SEO metadata, sitemap, robots file and pagination behavior.
4. THE feature SHALL add no local plugin replacement, including an SEO include, sitemap or robots template, pagination generator or vendored plugin copy.
5. THE feature SHALL leave layouts, includes, `assets/js/search.js`, `search.html` and `search.json` unchanged.

### Requirement 2: Remove redundant gem declarations

**User Story:** As the blog owner, I want the manifest to describe the dependencies needed by the existing WSL/Linux workflow without redundant declarations.

#### Acceptance Criteria

1. THE Gem_Manifest SHALL remove the direct `webrick` declaration while retaining its locked runtime dependency through Jekyll.
2. THE Gem_Manifest SHALL remove the Windows-only direct declarations for `tzinfo`, `tzinfo-data` and `wdm`, which are unused by the supported WSL Debian and Ubuntu CI workflows. Native Windows Ruby support is outside this feature.
3. THE Gem_Manifest SHALL retain every resolved gem version, checksum and platform, including all three plugins; only the redundant direct dependency entries SHALL be removed from the lockfile.
4. THE feature SHALL preserve Ruby 3.3.8, Jekyll 4.4.1 and `BUNDLED WITH 4.0.11` without dependency upgrades.
5. WHEN the cleaned manifest is checked in WSL Debian with `BUNDLE_FROZEN=true`, THE installed bundle SHALL satisfy the manifest without modifying `Gemfile.lock`, and THE Site_Build SHALL succeed.
6. THE documentation SHALL describe this as manifest cleanup, without claiming that removing the direct `webrick` declaration removes the installed gem or reduces browser payload.

### Requirement 3: Clean redundant CSS and disable source maps

**User Story:** As the blog owner, I want less redundant CSS and a smaller published artifact while keeping the existing appearance.

#### Acceptance Criteria

1. THE feature SHALL remove only CSS declarations proven redundant in the current cascade, considering selector, property, source order, specificity, importance, shorthand interactions and media context. Uncertain declarations SHALL remain.
2. THE feature MAY remove the baseline `hr:before` and `hr:after` content declarations together with the corresponding `hr::before, hr::after { content: none; }` neutralizer, provided no pseudo-element content is introduced and appearance stays equivalent.
3. THE Compiled_Stylesheet SHALL be smaller in bytes than the Reference_Output stylesheet, with before and after sizes reported.
4. THE production build SHALL emit neither `assets/css/main.css.map` nor a `sourceMappingURL` comment in the Compiled_Stylesheet.
5. THE stylesheets SHALL preserve the dark bluish palette (`#0d1320`, `#090e17`, `#dce4f5`, `#a2aec4`, `#7ba5ff`, `#252c38`), local Fira Sans fonts, `font-display: swap`, and the 480px, 700px and 767px breakpoints.
6. THE feature SHALL preserve responsive layouts, focus and skip-link styling, image presentation, code blocks, tables, blockquotes and horizontal rules.
7. THE Theme_Baseline SHALL retain its no-style-please attribution, and existing license files SHALL remain unchanged.
8. THE verification SHALL review removed or changed compiled declarations and report stylesheet sizes. THE blog owner SHALL confirm visual equivalence for applicable Page_Kinds manually; until then, visual equivalence SHALL be reported as unverified.

### Requirement 4: Exclude supporting documents from publication

**User Story:** As the blog owner, I want supporting font documentation kept in the repository without publishing it as site content.

#### Acceptance Criteria

1. THE `_config.yml` exclude list SHALL exclude the two Publication_Documents, while their source files remain unchanged in the repository.
2. THE published output SHALL retain `assets/fonts/Fira-LICENSE.txt`, `assets/images/md-test/Devicon-LICENSE.txt` and `assets/images/md-test/GitHub-Readme-Stats-LICENSE.txt` unchanged.
3. THE feature SHALL leave other exclude entries unchanged and SHALL NOT perform a general unreferenced-file cleanup. An optional verification script under Requirement 5 MAY receive its own exclusion.
4. THE feature SHALL leave the User_Deleted_Icons deleted, unstaged and unrestored, and SHALL add no exclusion for `assets/icons/`.
5. WHEN the reference snapshot includes the User_Deleted_Icons, THE comparison SHALL identify their absence as a pre-existing user change, not a saving produced by this feature.

### Requirement 5: Focused verification and output equivalence

**User Story:** As the blog owner, I want verification proportional to this cleanup, so that regressions are caught without building a new testing system.

#### Acceptance Criteria

1. THE Reference_Output SHALL be captured before implementation and compared with the Candidate_Output after implementation.
2. THE Site_Build SHALL succeed without new errors or warnings relative to the reference build.
3. THE comparison SHALL report added, removed and changed output files. THE only Allowed_Differences SHALL be changed Compiled_Stylesheet bytes, removal of its source map, and exclusion of the Publication_Documents. Pre-existing icon deletions SHALL be accounted for separately under Requirement 4.
4. THE HTML output, including SEO metadata, SHALL remain identical; `sitemap.xml` and `robots.txt` SHALL remain identical, and `search.json` SHALL remain equal as parsed JSON.
5. THE verification SHALL use the production build, output comparison, manifest check and focused CSS review. It SHALL NOT require a new property-based testing framework, fake DOM, exhaustive plugin compatibility suite or new testing dependency.
6. IF a reusable verification script is needed, it SHALL be minimal, retained in version control and excluded from publication; disposable fixtures and build output MAY live outside the repository. Such a script is optional, not a required deliverable.
7. THE report SHALL distinguish completed automated checks from manual or deferred checks. It SHALL NOT claim measured page-load or installation-speed improvements without measurements.

### Requirement 6: Preserve deployment and scope

**User Story:** As the blog owner, I want this cleanup to preserve the working blog and unrelated local changes.

#### Acceptance Criteria

1. THE feature SHALL leave `.github/workflows/pages.yml`, `package.ps1` and `.ruby-version` unchanged.
2. THE existing Ubuntu 24.04 CI build with `BUNDLE_FROZEN=true` SHALL remain compatible with the cleaned manifest. Actual CI verification SHALL be reported as pending until an authorized workflow run completes.
3. THE existing local preview and packaging commands SHALL remain supported. Runs that write Protected_Files SHALL remain manual owner checks, reported as unverified until performed.
4. THE agent-run builds SHALL use external destinations and disabled disk cache, leaving Protected_Files and unrelated working-tree changes untouched.
5. THE feature SHALL preserve all article content, front matter, metadata, `/blog` URL handling, permalinks, `paginate: 5`, `paginate_path: /page:num/`, accessibility attributes, navigation and footer attribution.
6. THE feature SHALL add no dependency, external runtime resource, RSS feed, analytics, comments, widget, backend or branding change.
7. THE feature SHALL make only necessary documentation corrections in `DEPENDENCIES.md`, `README.md` or `vendor/no-style-please/UPSTREAM.md` to describe manifest cleanup and actual stylesheet adaptations. Documentation SHALL continue to list the three retained plugins and SHALL NOT describe the project as Jekyll-only.
8. THE feature SHALL leave `.kiro/steering/` unchanged; its existing plugin list remains valid.
9. THE feature SHALL NOT commit, push or deploy without separate authorization.
