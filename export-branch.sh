#!/bin/bash


if [ "$1" = "-h" -o "x$2" = "x" ] ; then
	echo "Usage: $0 <brach> <outdir>"
	echo
	exit 1
fi

. functions.sh


# Ensure idempotence
rm -rf "$2"
mkdir -p "$2"

export_package "$1" "$2"

