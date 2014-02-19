#!/bin/bash

COMPATH=./components
OUT=./out
TESTS=./tests
BRANCH=master
PRIMARY=texmf.base
HASTESTS=1

while [ $# -gt 1 ] ; do
	case "$1" in
	-h|--help)
		echo "Usage: $0 [-d]"
		echo "    -d|--disable-tests"
		exit 0
		;;
	-d|--disable-tests)
		HASTESTS=0
		shift
		;;
	esac
done

workdir=`mktemp -d`/texmf
mkdir $workdir

for dir in $COMPATH/* ; do
	cd $dir;
	git archive "$BRANCH" | tar -x -C "$workdir"
	cd -
done

if [ $HASTESTS -eq 1 ] ; then
	if ./run-tests.sh "$workdir" "$TESTS" "$OUT/tests" ; then
		echo "Tests OK"
	else
		echo "Tests failed."
		exit 1
	fi
fi

version=`git describe --tags`
cd $workdir/..
zip -r "$OLDPWD/$OUT/texmf_$version.zip" .
rm -rf $workdir
cd -

