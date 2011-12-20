#!/bin/bash

#
# Use this script for deploying this texmf structure to your local texmf
# location.
#

TEXMF="$HOME/texmf/" # change this to your user texmf dir
LATEX="tex/latex/fykosx" # path to store fykosx macros
GEOMETRY="tex/latex/geometry" # path to store fykosx macros
MPOST="metapost/fykos" # path to metapost macros

if [ -d "$TEXMF$LATEX" -a "$1" != "-f" ] ; then
	echo "Macros 'fykosx' already installed. Use -f to reinstall."
	exit 1
fi

# preapre directories
rm -rf "$TEXMF$LATEX"
rm -rf "$TEXMF$MPOST"
rm -rf "$TEXMF$GEOMETRY"

# copy files
cp -r "./$LATEX" "$TEXMF$LATEX"
cp -r "./$MPOST" "$TEXMF$MPOST"
cp -r "./$GEOMETRY" "$TEXMF$GEOMETRY"

# update kpathsearch
mktexlsr ${TEXMF:0:-1}
