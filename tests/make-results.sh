#!/bin/bash

# colors
wipe="\033[1m\033[0m"
green='\E[32;40m'
yellow='\E[33;40m'
red='\E[31;40m'
blue='\E[34;40m'

function usage {
	echo "Usage: $0 <pdfdir> <pngdir>"
	exit 0
}

if [ "x$2" = "x" ] ; then
	usage
fi

if [ "$1" = "-v" ] ; then
	VERBOSE=1 
    verb=-v
	shift
fi

PDFDIR="$1"
PNGDIR="$2"

[ -n "$VERBOSE" ] && echo "Creating expected results from $PDFDIR to $PNGDIR." >&2

rm -f $PNGDIR/*
NUMERR=0
for file in $PDFDIR/*.pdf; do
    tests/make-result.sh $verb $file $PNGDIR
    if [ $? -ne 0 ]; then
        NUMERR=$NUMERR+1
    fi
done


NUMERR=$(($NUMERR))
if [ $NUMERR -ne 0 ]; then
    [ -n "$VERBOSE" ] && echo -e "${red}Creation failed with $NUMERR errors." >&2 ; tput sgr0
else
    [ -n "$VERBOSE" ] && echo -e "${green}Creation passed." >&2 ; tput sgr0
fi

exit $NUMERR


