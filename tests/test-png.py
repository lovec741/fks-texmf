import sys


if len(sys.argv) != 3:
    print sys.argv
    print "Parameters number" + (len(sys.argv)-1) + "!=2"
    sys.exit(2)

sys.exit(0)
