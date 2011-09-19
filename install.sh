#!/bin/bash

TEXMF="$HOME/texmf/" # change this to your user texmf dir
LATEX="tex/latex/fykosx"

if [ -d "$TEXMF$LATEX" -a "$1" != "-f" ] ; then
	echo "Macros 'fykosx' already installed. Use -f to reinstall."
	exit 1
fi

# preapre directories
rm -rf "$TEXMF$LATEX"

# copy files
cp -r "./$LATEX" "$TEXMF$LATEX"

# update kpathsearch
mktexlsr
