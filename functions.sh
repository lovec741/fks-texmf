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

#
# Logging functions
# 

_GREEN='\E[32;40m'
_YELLOW='\E[33;40m'
_RED='\E[31;40m'
_BLUE='\E[34;40m'
_NOCOLOR=''

LOG_ERROR=1
LOG_WARN=2
LOG_INFO=3
LOG_VERBOSE=$LOG_INFO

_log_level=$LOG_ERROR


function _log {
	local level=$1
	local color=$2
	local msg=$3

	if [ $level -le $_log_level ] ; then
		echo -e "$color$msg" >&2 ; tput sgr0
	fi
}

function log_init {
	_log_level=$1
}

function err {
	_log $LOG_ERROR $_RED "$1"
}

function warn {
	_log $LOG_WARN $_YELLOW "$1"
}

function info {
	_log $LOG_INFO $_NOCOLOR "$1"
}

function green {
	_log $LOG_INFO $_GREEN "$1"
}

