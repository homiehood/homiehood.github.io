#!/bin/sh
set -eu

WWW="docs"
SRC="src"

mkdir -p "$WWW"

write()
{
	title="$(lowdown -X Title $1 2>/dev/null || true)"
	desc="$(lowdown -X Description $1 2>/dev/null || true)"
	cat > "$2" <<-EOF
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="utf8" />
	<title>${title:-Homiehood Wiki}</title>
	<style>
	article {
		font-family: sans-serif;
		margin: auto;
		max-width: 80ch;
	}
	table {
		margin: auto;
	}
	table
	{ border: 1px inset black }
	table tr,
	table td,
	table th
	{ border: 1px inset black; padding: 1ch; }
	
	</style>
	</head>
	<body>
	<article>
	<h1 style="text-align: center">${title:-Homiehood Wiki}</h1>
	<p style="text-align: center; font-weight: bold">${desc:-""}</p>
	${3:-$(lowdown -Thtml $1)}
	</article>
	</body>
	</html>
	EOF
}

# build index
# ===========

write "${SRC}/index.md" "${WWW}/index.html" "$(
	cat "${SRC}/index.md" | while read -r line
	do
		case "$line" in
		'{{INDEX}}')
			printf '| Title | Description |\n'
			printf '| ----- | ----------- |\n'
			find src -type f | while read -r i
			do
				title="$(lowdown -X Title $i 2>/dev/null || true)"
				desc="$(lowdown -X Description $i 2>/dev/null || true)"
				n="${i}"
				n="${n##${SRC}/}"
				n="${n%.md}.html"
				o="${WWW}/${n}"
				printf '| [%s](%s) | %s |\n' \
					"${title}" "${n}" "${desc}"
			done
			;;
		*) printf '%s\n' "$line" ;;
		esac
	done | lowdown -Thtml
)"

# build each page
# ===============

find src -type f | while read -r i
do
	n="${i}"
	n="${n##${SRC}/}"
	n="${n%.md}.html"
	o="${WWW}/${n}"
	write "${i}" "${o}"
done
