#!/bin/bash

# colors
wipe="\033[1m\033[0m"
green='\E[32;40m'
yellow='\E[33;40m'
red='\E[31;40m'
blue='\E[34;40m'

function usage {
	echo "Usage: $0 <texmf> <testdir> <outdir>"
	exit 0
}

function echoError {
    [ -n "$VERBOSE" ] && echo -e "${red}Test $2 `basename $1` failed ($3)." >&2 ; tput sgr0
}

function echoPass {
    [ -n "$VERBOSE" ] && echo -e "${green}Test $2 `basename $1` passed." >&2 ; tput sgr0
}

function echoSkip {
    [ -n "$VERBOSE" ] && echo -e "${yellow}Test $2 `basename $1` skipped ($3)." >&2 ; tput sgr0
}

if [ "x$3" = "x" ] ; then
	usage
fi

if [ "$1" = "-v" ] ; then
	VERBOSE=1
	verb=-v
	shift
fi

TEXMF="$1"
TESTS="$2"
TESTSSRC="$2/source"
TESTSRES="$2/exp-res"
OUT="$3"

rm -rf "$OUT"
mkdir "$OUT"

export TEXMFHOME="$TEXMF"
export TEXINPUTS="$TESTSSRC:"
[ -n "$VERBOSE" ] && echo "Running tests with TEXMFHOME=\"$TEXMFHOME\"" >&2		

# tests
NUMERR=0
NUMWARN=0
for file in $TESTSSRC/t*.tex ; do
    BUILDOK=0
##########################
# test build             #
##########################
	if xelatex -interaction nonstopmode -output-directory "$OUT" -halt-on-error $file &>/dev/null ; then
		echoPass $file "build"
        BUILDOK=1
	else
		if [ -n "$VERBOSE" ] ; then
			log=`basename $file`
			log=${log%.tex}.log
			echo "=== $log ==="
			tail -n 21 $OUT/$log | head -n 11
			echo "======"
		fi
		echoError $file "build"
        NUMERR=$NUMERR+1
	fi
##########################
# test appearance        #
##########################
# skip if build failed
    if [ "$BUILDOK" -eq 0 ]; then
        echoSkip $file "appearance" "build failed"
        NUMWARN=$NUMWARN+1
        NUMERR=$NUMERR+1
        continue
    fi

# skip if no reference png found
    ls $TESTSRES/`basename $file | sed -e 's/\.tex/*.png/'` >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echoSkip $file "appearance" "no png found"
        NUMWARN=$NUMWARN+1
        continue
    fi

# skip if png sreation fails
    PDFFILE=$OUT/`basename $file | sed -e 's/\.tex/.pdf/'`
    $TESTS/make-result.sh $verb $PDFFILE $OUT/
    if [ $? -ne 0 ]; then
        echoError $file "appearance" "png creation failed"
        NUMERR=$NUMERR+1
        continue
    fi

# test appearance page by page
    APPFAIL=0
    for file in $TESTSRES/`basename $file | sed -e 's/\.tex/*.png/'`; do
        testfile=$OUT/`basename $file`
        testlog=`sed -e 's/png$/log/' <<< $testfile`
        testpngout=`sed -e 's/\.png$/-diff.png/' <<< $testfile`
        python $TESTS/test-png.py $file $testfile $testpngout > $testlog 2>&1
        if [ $? -ne 0 ]; then
            if [ -n "$VERBOSE" ] ; then
                echo "=== $testlog ==="
                cat $testlog
                echo "======"
            fi
            echoError $file "appearance" "page $file"
            NUMERR=$NUMERR+1
            APPFAIL=1
        fi
    done
    if [ $APPFAIL -ne 0 ]; then
        echoError $file "appearance"
    else
        echoPass $file "appearance"
    fi
done

# print summary
NUMERR=$(($NUMERR))
NUMWARN=$(($NUMWARN))

echo ""
if [ "$NUMERR" -ne 0 ] ; then
    [ -n "$VERBOSE" ] && echo -e "${red}Tests failed with $NUMERR errors and $NUMWARN warnings." >&2 ; tput sgr0
	exit 1
else
    if [ "$NUMWARN" -ne 0 ] ; then
        [ -n "$VERBOSE" ] && echo -e "${green}Tests passed ${yellow}with $NUMWARN warnings." >&2 ; tput sgr0
    else
        [ -n "$VERBOSE" ] && echo -e "${green}Tests passed." >&2 ; tput sgr0
    fi
	exit 0
fi
