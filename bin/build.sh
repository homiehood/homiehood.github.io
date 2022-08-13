#!/bin/sh
set -eu

mkdir -p _site

# build index
# ===========

lowdown -s -Thtml -o _site/index.html

# build each page
# ===============


# upload
# ======

if [ "${PUBLISH:-0}" = "1" ]
then
  git init
  git config user.email "${ACTOR}@users.noreply.github.com"
  git config user.name "${ACTOR}"
  git add -A
  git commit -m "deploy ${GITHUB_SHA}"
  git push -f "https://${ACTOR}:${TOKEN}@github.com/${REPO}.git" main:${BRANCH}
fi
