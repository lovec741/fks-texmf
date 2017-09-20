.PHONY: test test-results 

mkfile_path:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

TESTS=./tests
TESTS_RES=$(TESTS)/exp-res
TESTS_SRC=$(TESTS)/source
TESTS_OUT=out/tests
TEXMF_TMP=out/texmf.tmp
TEXMF_STAMP=out/texmf.stamp

#
# Test working copy version
#
test:
	./export-wc.sh $(TEXMF_TMP)
	./run-tests.sh $(TEXMF_TMP)

#
# Recreate tests expected results with current working copy
#
test_files:=$(addprefix $(TESTS_OUT)/,$(notdir \
	$(patsubst %.tex,%.pdf,$(wildcard $(TESTS_SRC)/t*.tex))))

test-results: $(test_files)
	# TODO this recipe should be called regardless prerequsities success
	rm $(TEXMF_STAMP)


$(TEXMF_STAMP):
	./export-wc.sh $(TEXMF_TMP)
	touch $@

# PNG files are created as side-effect of this rule
$(TESTS_OUT)/%.pdf: $(TESTS_SRC)/%.tex $(TEXMF_STAMP)
	@rm -f $(TESTS_RES)/$**.png
	$(TESTS)/make-result.sh $(TEXMF_TMP) $< $(TESTS_RES)


