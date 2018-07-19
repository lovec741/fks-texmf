# fks-texmf

TeX macros for physics (contest) typesetting.

* TODO installation (Linux distros, windows)
* TODO maintenance (tests, branching, packaging)


## Packaging

Packages for Linux distributions are built in [Open Build Service](http://build.opensuse.org/).
All data are stored in the main Git repository and build service package
contains just a `_service` file that references the Git repository and
transformations to comply with OBS package format.

To rebuild packages with a fresh pull from the repo call

    osc service remoterun

### Debian

  * Beware that Build-Depends is duplicated both in `*.dsc` and
    `debian.control` file (does not need frequent changes though).

## Tests

  * `tests/source` any `t*.tex` files are compiled with the macros.
  * `tests/exp-res` here you should put PNG files with expected test results
    (matching respective source filename).
    * Simply call `make test-results` to refresh the PNG patterns.

### Metadata

The test files can arbitrary key=value metadata comments
```
	%META_TEST foo=bar
```

Following keys are supported:

  * `META_TEST ignore=1` test is run but results are ignored
  * `META_TEST nopdf=1` test is supposed to produce no PDF output
  * `META_TEST roi=<l>x<t>,<w>x<h>` left and top coordinate, width and height
    size (all relative [0,1]) of region of interest that is compared against
    the pattern

### Why are my tests failing in Travis?

If you run tests locally, you can read the log and a message will tell you
which diff PNG image you should look at to figure out the cause of a failing
test.

Alas, Travis doesn't allow easy saving of test artifacts besides text log.
Let's exploit that!

```
cd $DIR_WHERE_I_WANT_TEST_RESULTS
wget $URL_OF_FULL_TRAVIS_LOG -O log.txt
sed -n '/echo "MARK/,/echo "MARK/p' log.txt | tail -n +4 | sed '/ /d' | base64 -d -i | tar xj
```

Voilà, there are the diff PNGs in your local directory.

### Generating new test patterns with Travis

If you want to store not only diff PNG files, but all PNG files in Travis
logfile, change value of `SHOW_ALL_PNG` to `true` in `.travis.yml` file.
This feature is useful i.e. if you want to generate new test patterns and your
local tests are failing (see above). Don't forget to change the value of
`SHOW_ALL_PNG` back to `false` to reduce log size.
