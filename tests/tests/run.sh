#!/bin/bash

pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null

. $SCRIPTPATH/../functions.sh

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

if [ "x$3" = "x" ] ; then
	usage
fi

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

rm -rf "$OUT"
mkdir "$OUT"

# tests
NUMALL=0
NUMERR=0
NUMWARN=0
for file in $TESTSSRC/t*.tex ; do
	NUMALL=$NUMALL+1
	BUILDOK=0
	bfile=`basename $file`
##########################
# test build			 #
##########################
	if test_xelatex "$TEXMF" "$file" "$OUT" ; then
		test_pass $file "build"
		BUILDOK=1
	else
		if [ -n "$VERBOSE" ] ; then
			log=`basename $file`
			log=${log%.tex}.log
			echo "=== $log ==="
			tail -n 21 $OUT/$log | head -n 11
			echo "======"
		fi
		test_fail $file "build"
		NUMERR=$NUMERR+1
	fi
##########################
# test appearance		#
##########################
# skip if build failed
	if [ "$BUILDOK" -eq 0 ]; then
		test_skip $file "appearance" "build failed"
		NUMWARN=$NUMWARN+1
		continue
	fi

# skip if no reference png found
	ls $TESTSRES/`basename $file | sed -e 's/\.tex/*.png/'` >/dev/null 2>&1
	if [ $? -ne 0 ]; then
		test_skip $file "appearance" "no PNG found"
		NUMWARN=$NUMWARN+1
		continue
	fi

	if ! pdf_to_png $OUT/${bfile%.tex}.pdf $OUT ; then
		test_fail $file "appearance" "PNG creation failed"
		NUMERR=$NUMERR+1
		continue
	fi

# test appearance page by page
	APPFAIL=0
	for file in $TESTSRES/`basename $file | sed -e 's/\.tex/*.png/'`; do
		testfile=$OUT/`basename $file`
		testlog=`sed -e 's/png$/log/' <<< $testfile`
		testpngout=`sed -e 's/\.png$/-diff.png/' <<< $testfile`
		(diff $file $testfile > /dev/null && 
			echo "diff OK" > $testlog ) || 
			python $TESTS/diff-png.py $file $testfile $testpngout > $testlog 2>&1
		if [ $? -ne 0 ]; then
			if [ -n "$VERBOSE" ] ; then
				echo "=== $testlog ==="
				cat $testlog
				echo "======"
			fi
			test_fail $file "appearance" "page $bfile"
			NUMERR=$NUMERR+1
			APPFAIL=1
		fi
	done
	if [ $APPFAIL -ne 0 ]; then
		test_fail $file "appearance"
	else
		test_pass $file "appearance"
	fi
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
