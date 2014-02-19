#!/bin/bash

OUT=./out
TESTS=./tests
BRANCH=dev
HASTESTS=1

if [ "$1" = "-h" ] ; then
	echo "Usage: $0 [<brach>]"
	echo "    branch     [$BRANCH]"
elif [ "x$1" != "x" ] ; then
	BRANCH=$1
fi

. functions.sh


workdir=`mktemp -d`/texmf

export_package $BRANCH "$workdir"

if "$TESTS/run.sh" -v "$workdir" "$TESTS" "$OUT/tests" ; then
	echo "Tests on $branch OK"
else
	echo "Tests on $branch failed."
	exit 1
fi

rm -rf "$workdir"


