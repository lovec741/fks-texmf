#!/bin/bash

# colors
wipe="\033[1m\033[0m"
green='\E[32;40m'
yellow='\E[33;40m'
red='\E[31;40m'
blue='\E[34;40m'

function usage {
	echo "Usage: $0 <pdffile> <pngdir>"
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

PDFFILE="$1"
PNGDIR="$2"

PNGFILE=`basename $PDFFILE | sed -e 's/\.pdf$//'`
GSLOG=`sed -e 's/\.pdf$/-gs.log/' <<< $PDFFILE`
PDFPPMLOG=`sed -e 's/\.pdf$/-pdfppm.log/' <<< $PDFFILE`

#convert -density 1000 $PDFFILE $PNGDIR/$PNGFILE; ec=$?
#GSCMD="gs -o $PNGDIR/$PNGFILE -sDEVICE=png16m -dAlignToPixels=0 -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -r500 $PDFFILE"
#GSCMD="gs -o $PNGDIR/$PNGFILE -sDEVICE=png16m -dGridFitTT=2 -dAlignToPixels=0 -dTextAlphaBits=4 -dGraphicsAlphaBits=4 -r500 $PDFFILE"
PDFPPMCMD="pdftoppm -r 500 -png -freetype yes -thinlinemode none -aa yes -aaVector yes $PDFFILE $PNGDIR/$PNGFILE"

#$GSCMD >$GSLOG; ec=$?
$PDFPPMCMD > $PDFPPMLOG; ec=$?


if [ $ec -ne 0 ]; then
    if [ -n "$VERBOSE" ]; then
        echo "=== $GSCMD > $GSLOG  ==="
        cat $GSLOG
        echo "======"
        echo -e "${red}Conversion $PDFFILE to $PNGFILE failed $ec." >&2 ; tput sgr0
    fi
else
    [ -n "$VERBOSE" ] && echo -e "${green}Created $PNGFILE from $PDFFILE." >&2 ; tput sgr0
fi

exit $ec

