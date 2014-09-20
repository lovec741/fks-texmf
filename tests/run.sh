#!/bin/bash

function usage {
	echo "Usage: $0 <texmf> <testdir> <outdir>"
	exit 0
}

if [ "x$3" = "x" ] ; then
	usage
fi

if [ "$1" = "-v" ] ; then
	VERBOSE=1
	shift
fi

TEXMF="$1"
TESTS="$2"
OUT="$3"

# colors
wipe="\033[1m\033[0m"
green='\E[32;40m'
red='\E[31;40m'
blue='\E[34;40m'

rm -rf "$OUT"
mkdir "$OUT"

export TEXMFHOME="$TEXMF"
export TEXINPUTS="$TESTS:"
[ -n "$VERBOSE" ] && echo "Running tests with TEXMFHOME=\"$TEXMFHOME\"" >&2		

for file in "$TESTS/t"* ; do
	if xelatex -interaction nonstopmode -output-directory "$OUT" -halt-on-error $file &>/dev/null ; then
		[ -n "$VERBOSE" ] && echo -e "${green}Test `basename $file` passed." >&2 ; tput sgr0		
	else
		if [ -n "$VERBOSE" ] ; then
			log=`basename $file`
			log=${log%.tex}.log
			echo "=== $log ==="
			tail -n 21 $OUT/$log | head -n 11
			echo "======"
		fi
		echo -e "${red}Test `basename $file` failed." >&2 ; tput sgr0
		HASFAIL=1
	fi

done

if [ -n "$HASFAIL" ] ; then
	exit 1
else
	exit 0
fi
