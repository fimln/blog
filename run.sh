#!/usr/bin/env bash
set -euo pipefail

IMG="${IMG:-jekyll/jekyll:latest}"
PORT="${PORT:-4000}"
LIVE="${LIVE:-35729}"
BUNDLE_VOL="${BUNDLE_VOL:-blog_bundle_cache}"

# Ensure Docker is installed
if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is not installed. On Arch: sudo pacman -Syu --needed docker docker-compose && sudo systemctl enable --now docker"
  exit 1
fi

# Ensure Docker daemon is running
if ! docker info >/dev/null 2>&1; then
  echo "Docker daemon is not running. Start it: sudo systemctl start docker"
  exit 1
fi

# Pull image if missing
if ! docker image inspect "$IMG" >/dev/null 2>&1; then
  echo "Pulling $IMG ..."
  docker pull "$IMG"
fi

# Run Jekyll inside container using Bundler (honors Gemfile with github-pages)
exec docker run --rm -it \
  -v "$PWD":/srv/jekyll \
  -v "$BUNDLE_VOL":/usr/local/bundle \
  -p "${PORT}:${PORT}" \
  -p "${LIVE}:${LIVE}" \
  "$IMG" bash -lc "
    bundle config set path 'vendor/bundle' &&
    bundle install &&
    bundle exec jekyll serve --host 0.0.0.0 -P ${PORT} --livereload --livereload-port ${LIVE} --force_polling
  "