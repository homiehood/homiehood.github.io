#!/bin/sh
set -eu

mkdir -p _site

lowdown -s -Thtml -o _site/index.html
