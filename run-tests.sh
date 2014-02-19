#!/bin/bash


function usage {
	echo "Usage: $0 <texmf> <testdir> <outdir>"
	exit 0
}

if [ "x$3" = "x" ] ; then
	usage
fi

TEXMF="$1"
TESTS="$2"
OUT="$3"

rm -rf "$OUT"
mkdir "$OUT"

export TEXINPUTS="$TESTS:$TEXMF:"

for file in "$TESTS/t"* ; do
	if xelatex -interaction nonstopmode -output-directory "$OUT" -halt-on-error $file &>/dev/null ; then
		true # OK
	else
		echo "Test `basename $file` failed." >&2
		exit 1
	fi

done

exit 0
