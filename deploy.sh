#!/bin/bash
set -e

bundle exec jekyll build

cd _site
git init
git config user.email "Alfi.maulana29@gmail.com"
git config user.name "fimln"
touch .nojekyll
git add .
git commit -m "deploy"
git push --force git@github.com:fimln/blog.git master:gh-pages
cd ..

echo "Deployed to gh-pages."
