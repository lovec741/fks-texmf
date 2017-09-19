#!/bin/bash

OUT=./out
TESTS=./tests

if [ "$1" = "-h" -o "x$1" = "x" ] ; then
	echo "Usage: $0 <texmf>"
	exit 1
fi

TEXMF="$1"

. functions.sh


if "$TESTS/run.sh" -v "$TEXMF" "$TESTS" "$OUT/tests" ; then
	echo "Tests on $TEXMF OK"
else
	echo "Tests on $TEXMF failed."
	exit 1
fi


