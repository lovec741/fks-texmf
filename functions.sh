#!/bin/bash

COMPATH=./components

# params: branch workdir
function export_package {
	workdir="$2"
	branch="$1"
	[ -d "$workdir" ] || mkdir "$workdir"
	for dir in $COMPATH/* ; do
		export GIT_DIR="$dir/.git";
		git archive "$branch" | tar -x -C "$workdir"
		unset GIT_DIR
	done
}


