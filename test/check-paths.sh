#!/usr/bin/env bash
set -eo pipefail

FAILED=0
shopt -s globstar

exactly() { # exactly N name search [mode] [filter]
	count="$1"
	name="$2"
	search="$3"
	mode="${4:--E}"
	filter="${5:-**/*.dm}"

	num="$(grep "$mode" "$search" $filter | wc -l || true)"

	if [ $num -eq $count ]; then
		echo "$num $name"
	else
		echo "$(tput setaf 9)$num $name (expecting exactly $count)$(tput sgr0)"
		FAILED=1
	fi
}

# With the potential exception of << if you increase any of these numbers you're probably doing it wrong
exactly 0 "escapes" '\\\\(red|blue|green|black|b|i[^mc])'
exactly 7 "Del()s" '\S\WDel\(' # +1 because it also matches comments, sigh
exactly 2 "/atom text paths" '"/atom'
exactly 2 "/area text paths" '"/area'
exactly 2 "/datum text paths" '"/datum'
exactly 2 "/mob text paths" '"/mob'
exactly 10 "/obj text paths" '"/obj'
exactly 8 "/turf text paths" '"/turf'
#exactly 117 "to_world uses" '\sto_world\(' - commented out because this is just stupid specific to the codebase, uncomment and set value correctly later on if you feel like it
#exactly 60 "to_world_log uses" '\sto_world_log\(' - same as above
exactly 0 "world<< uses" 'world<<|world[[:space:]]<<'
exactly 0 "world.log<< uses" 'world.log<<|world.log[[:space:]]<<'
#exactly 122 "<< uses" '(?<!<)<<(?!<)' -P - bitshifts exist
exactly 0 "incorrect indentations" '^( {4,})' -P
#exactly 3 "update_icon() override" '/update_icon\((.*)\)'  -P - nothing wrong wtih overriding it
exactly 1 "goto use" 'goto '
exactly 1 "NOOP match" 'NOOP'
#exactly 416 "spawn uses" 'spawn\s*\(\s*(-\s*)?\d*\s*\)' -P - oddly specific number
exactly 0 "tag uses" '\stag = ' -P '**/*.dmm'
#exactly 4 ".Replace( matches" '\.Replace(_char)?\(' -P - oddly specific number
#exactly 5 ".Find( matches" '\.Find(_char)?\(' -P - oddly specific number
exactly 0 "anchored = 0/1" 'anchored\s*=\s*\d' -P
exactly 1 "density = 0/1" 'density\s*=\s*\d' -P
exactly 0 "emagged = 0/1" 'emagged\s*=\s*\d' -P
exactly 0 "simulated = 0/1" 'simulated\s*=\s*\d' -P
# With the potential exception of << if you increase any of these numbers you're probably doing it wrong
# - Fuck you, I am going to use as many text2path as I want

broken_files=0
while read -r file; do
	ftype="$(uchardet "$file")"
	case "$ftype" in
		ASCII)
			continue;;
		UTF-8)
			if diff -d "$file" <(<"$file" iconv -c -f utf8 -t iso8859-1 2>/dev/null | tr -d $'\x7F-\x9F' | iconv -c -f iso8859-1 -t utf8 2>/dev/null); then
				continue
			else
				echo "$file contains Unicode characters outside the ISO 8859-1 character set"
				(( broken_files = broken_files + 1 ))
			fi;;
		*)
			if diff -d "$file" <(<"$file" tr -d $'\x7F-\x9F' | iconv -c -f iso8859-1 -t utf8 2>/dev/null | iconv -c -f utf8 -t iso8859-1 2>/dev/null); then
				continue
			else
				echo "$file contains characters outside the ISO 8859-1 character set"
				(( broken_files = broken_files + 1 ))
			fi;;
	esac
done < <(find . -name '*.dm')
echo "$broken_files files with invalid characters"
if (( broken_files > 0 )); then
	FAILED=1
fi

num=`find . -perm /111 -name "*.dm*" | wc -l`
echo "$num executable *.dm? files (expecting exactly 0)"
[ $num -eq 0 ] || FAILED=1

exit $FAILED
