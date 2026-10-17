# no-style-please

Source: https://github.com/riggraz/no-style-please
Pinned commit: 2f8dba2c23633b21e45dce0fe2e34ec2d79bb1ca
License: MIT, see LICENSE.txt in this directory.

The theme is vendored, not fetched during builds. Its base SCSS and local
overrides were combined into `assets/css/main.css` in their original order.
The inversion-based theme switcher remains removed. The templates were ported
from Liquid to Hugo in `layouts/`, retaining the HTML structure, permanent dark
bluish colors, Fira Sans, responsive post previews, pagination, search, and
article typography. No remote CSS, theme gem, KaTeX, analytics, or theme
JavaScript is loaded.
