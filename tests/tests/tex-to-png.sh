#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

. $SCRIPTPATH/../functions.sh

function usage {
	echo "Usage: $0 <tex file> <PNG dir>"
	exit 1
}

if [ "x$2" = "x" ] ; then
	usage
fi

if [ "$1" = "-v" ] ; then
	VERBOSE=1
	log_init $LOG_VERBOSE
	shift
else
	log_init $LOG_ERROR
fi

PDFFILE="$1"
PNGDIR="$2"

PNGFILE=`basename ${PDFFILE%.pdf}.png`
LOG=${PDFFILE%.pdf}-pdfppm.log

CMD="pdftoppm -r 500 -png -freetype yes -thinlinemode none -aa yes -aaVector yes $PDFFILE $PNGDIR/$PNGFILE"

$CMD > $LOG; ec=$?


if [ $ec -ne 0 ]; then
	if [ -n "$VERBOSE" ]; then
		echo "=== $CMD > $LOG  ==="
		cat $LOG
		echo "======"
	fi
	err "Conversion $PDFFILE to $PNGFILE failed $ec."
else
	info "Created $PNGFILE from $PDFFILE."
fi

exit $ec

