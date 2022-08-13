#!/bin/sh
set -eu

mkdir -p www

# build index
# ===========

lowdown -s -Thtml -o www/index.html

# build each page
# ===============


# upload
# ======

git status
echo "${PUBLISH:-0}"
find . -a

if [ "${PUBLISH:-0}" = "1" ]
then
  git config user.email "${ACTOR}@users.noreply.github.com"
  git config user.name "${ACTOR}"
  git add www
  git commit -m "deploy ${GITHUB_SHA}"
  git push -f "https://${ACTOR}:${TOKEN}@github.com/${REPO}.git" main:${BRANCH}
fi
