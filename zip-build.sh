#!/bin/bash

OUT=./out
TESTS=./tests
BRANCH=master

. functions.sh

workdir=`mktemp -d`/texmf

export_package $BRANCH "$workdir"

version=`git describe --tags`
cd $workdir/..
zip -r "$OLDPWD/$OUT/texmf_$version.zip" .
rm -rf $workdir
cd -

