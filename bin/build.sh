#!/bin/sh
set -eu

WWW="doc"

rm -rf www
mkdir -p "$WWW"

# build index
# ===========

lowdown -s -Thtml -o "${WWW}/index.html"

# build each page
# ===============
