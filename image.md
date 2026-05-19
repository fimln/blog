# How to change the sidebar background image

## Changing the global image (all pages)

1. Find a photo you like on [unsplash.com](https://unsplash.com) and download it.
2. Drop the file into `assets/images/`, e.g. `assets/images/cover.jpg`.
3. Open `_config.yml` and update this line:

```yaml
accent_image: /assets/images/your-filename.jpg
```

Rebuild the site. Every page uses this image as the sidebar background.

## Overriding the image on a specific page

Add `accent_image` to the page's front matter. It overrides the global setting for that page only.

```yaml
---
layout: post
title: My Post
accent_image: /assets/images/other-image.jpg
---
```

To remove the image on a specific page and use a plain color instead:

```yaml
accent_image:
  background: '#FAF9F5'
  overlay: false
```

## Reverting to a plain color globally

Replace the `accent_image` line in `_config.yml` with:

```yaml
accent_image:
  background: '#FAF9F5'
  overlay: false
```

Swap `#FAF9F5` for any hex color you want.
