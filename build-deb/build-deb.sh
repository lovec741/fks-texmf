#!/bin/bash

if [ "x$1" == "x" ] ; then
	echo "Usage: $0 <refspec>"
	echo "    Will create DEB package from given revision."
	exit 1
fi

PREFIX="usr/local/share/texmf"
PKG_NAME="fks-tex"
BUILDDIR="."
WORKDIR="/tmp/$PKG_NAME"

function render_template {
	version=`git describe $1 --tags`
	for f in DEBIAN/*.tpl ; do
		r=${f%.tpl}

		sed "s/%version%/$version/" <$f |\
		sed "s#%prefix%#/$PREFIX#" >$r
		[ -x $f ] && chmod 755 $r
	done
}

rm -rf $WORKDIR
mkdir $WORKDIR
mkdir -p "$WORKDIR/$PREFIX"

git archive --prefix="$PREFIX/" "$1" | tar -x -C "$WORKDIR"
render_template $1

cp -r DEBIAN "$WORKDIR"
fakeroot chown -R root:root "$WORKDIR"

dpkg-deb --build "$WORKDIR" "$BUILDDIR"

rm -rf $WORKDIR
