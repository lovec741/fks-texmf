#!/bin/bash

COMP_DIR=./components

if [ "$1" = "-h" -o "x$1" = "x" ] ; then
	echo "Usage: $0 <output-dir>"
	echo
	exit 1
fi

OUT="$1"

# Ensure idempotence
rm -rf "$OUT"
mkdir -p "$OUT"

for d in $COMP_DIR/* ; do
	cp -r -T $d "$OUT"
done

