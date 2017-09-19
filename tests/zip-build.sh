#!/bin/bash

OUT=./out
BRANCH=master

if [ "x$1" != "x" ] ; then
	BRANCH=$1
fi

. functions.sh

workdir=`mktemp -d`/texmf

export_package $BRANCH "$workdir"

version=`git describe --tags`
cd $workdir/..
zip -r "$OLDPWD/$OUT/texmf_$version.zip" .
rm -rf $workdir
cd -

