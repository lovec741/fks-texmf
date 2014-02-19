#!/bin/bash

COMPATH=./components
BRANCH=master
PRIMARY=texmf.base

git submodule init
git submodule update

message=`mktemp`
echo "Released texmf.dist" >> $message
echo >> $message

for dir in $COMPATH/* ; do
	cd $dir;
	git fetch origin
	git reset origin/$BRANCH
	echo "\t$dir at version `git describe --tags`" >>$message
	cd -
done

cd $COMPATH/$PRIMARY
version=`git describe --tags`
cd -

git add components
git commit -F $message
git tag $version-$BRANCH

