#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

. $SCRIPTPATH/functions.sh

#
# Parse arguments
#

if [ "$1" = "-v" ] ; then
	log_init $LOG_VERBOSE
	verb=-v
	VERBOSE=1
	shift
else
	log_init $LOG_ERROR
fi

TEXMF="$1"
TESTS="$2"
TESTSSRC="$2/source"
TESTSRES="$2/exp-res"
OUT="$3"
PNGDIFF=$SCRIPTPATH/diff-png.py

#
# Definitions
#
RC_PASS=0
RC_FAILEDBUILD=1
RC_FAILEDAPPEAR=2
RC_NOPDF=2

function usage {
	echo "Usage: $0 [-v] <texmf> <testdir> <outdir>"
	exit 0
}

function test_pass {
	local name=$1
	local phase=$2
	[ -n "$3" ] && local reason=" ($3)" || local reason=""
	green "Test $name/$phase passed$reason."
}

function test_fail {
	local name=$1
	local phase=$2
	[ -n "$3" ] && local reason=" ($3)" || local reason=""
	err "Test $name/$phase failed$reason."
}

function test_skip {
	local name=$1
	local phase=$2
	[ -n "$3" ] && local reason=" ($3)" || local reason=""
	warn "Test $name/$phase skipped$reason."
}

function single_test {
	local file=$1
	local bfile=`basename $file`
	local exp_res
	local has_fail
	local pdf_file

	if test_xelatex "$TEXMF" "$file" "$OUT" ; then
		test_pass $file "build"
	else
		if [ -n "$VERBOSE" ] ; then
			log=`basename $file`
			log=${log%.tex}.log
			echo "=== $log ==="
			tail -n 21 $OUT/$log | head -n 11
			echo "======"
		fi
		test_fail $file "build"
		return $RC_FAILEDBUILD
	fi

	pdf_file=$OUT/${bfile%.tex}.pdf
	if ! [ -f "$pdf_file" ] ; then
		return $RC_NOPDF
	fi

	if ! pdf_to_png $pdf_file $OUT ; then
		test_fail $file "appearance" "PNG creation failed"
		return $RC_FAILEDBUILD
	fi

	# test appearance page by page
	has_fail=0
	for exp_res in $TESTSRES/${bfile%.tex}*.png ; do
		act_res=$OUT/`basename $exp_res`
		app_log=${act_res%.png}.log
		app_diff=${act_res%.png}-diff.png

		$PNGDIFF $exp_res $act_res $app_diff &>$app_log
		if [ $? -ne 0 ]; then
			if [ -n "$VERBOSE" ] ; then
				echo "=== $app_log ==="
				cat $app_log
				echo "======"
			fi
			test_fail $file "appearance" "page $bfile"
			has_fail=1
		fi
	done
	if [ $has_fail -ne 0 ]; then
		test_fail $file "appearance"
		return $RC_FAILEDAPPEAR
	else
		test_pass $file "appearance"
		return $RC_OK
	fi
}

if [ "x$3" = "x" ] ; then
	usage
fi


rm -rf "$OUT"
mkdir "$OUT"

# tests
NUMALL=0
NUMERR=0
NUMWARN=0
for file in $TESTSSRC/t*.tex ; do
	NUMALL=$NUMALL+1
	single_test $file
	case $? in
		$RC_FAILEDBUILD|$RC_FAILEDAPPEAR)
			NUMERR=$NUMERR+1
			;;
		$RC_NOPDF)
			NUMWARN=$NUMWARN+1
			;;

	esac
done

# print summary
NUMALL=$(($NUMALL))
NUMERR=$(($NUMERR))
NUMWARN=$(($NUMWARN))

echo ""
if [ "$NUMERR" -ne 0 ] ; then
	[ -n "$VERBOSE" ] && echo -e "${_RED}Tests: $NUMALL, failed $NUMERR, warnings: $NUMWARN." >&2 ; tput sgr0
	exit 1
else
	if [ "$NUMWARN" -ne 0 ] ; then
		[ -n "$VERBOSE" ] && echo -e "${_GREEN}Tests: $NUMALL, ${_YELLOW}warnings $NUMWARN." >&2 ; tput sgr0
	else
		[ -n "$VERBOSE" ] && echo -e "${_GREEN}$NUMALL tests passed." >&2 ; tput sgr0
	fi
	exit 0
fi
