#!/bin/sh
set -eu

WWW="doc"
SRC="src"

mkdir -p "$WWW"

# build index
# ===========

lowdown -s -Thtml "${SRC}/index.md" -o "${WWW}/index.html"

# build each page
# ===============
