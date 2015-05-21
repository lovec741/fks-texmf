#!/bin/bash

ORIGIN=$1
BRANCH_MASTER=$2
BRANCH_DEV=$3
MSG_FILE=$4

if git diff --quiet $BRANCH_MASTER $BRANCH_DEV ; then
	echo "Nothing to merge."
	exit 0
fi

git checkout $BRANCH_MASTER
git merge --no-ff $BRANCH_DEV
git checkout $BRANCH_DEV
git merge $BRANCH_MASTER


echo "Write tag for $name (leave empty for `git describe --tags`):"
read tagname
if [ "x$tagname" != "x" ] ; then
	git tag $tagname
	git push --tags $ORIGIN $BRANCH_MASTER $BRANCH_DEV
fi

echo "    $name at version `git describe --tags`" >> $MSG_FILE
