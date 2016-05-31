.PHONY: test release deb-build deb-publish zip-build init test-master update

mkfile_path:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
OUT:=$(mkfile_path)out
BRANCH_DIST_MASTER=master
BRANCH_MASTER=master
BRANCH_DEV=dev
ORIGIN=origin
merge:=$(mkfile_path)merge-component.sh

TESTS=./tests
TESTS_RES=$(TESTS)/exp-res
TESTS_SRC=$(TESTS)/source
TESTS_OUT=out/tests
TEXMF_TMP=out/texmf.tmp
TEXMF_STAMP=out/texmf.stamp


#
# Initialize components after clone
#
init:
	git submodule init
	git submodule update
	git submodule foreach 'git checkout $(BRANCH_MASTER)'
	git submodule foreach 'git checkout $(BRANCH_DEV)'

#
# Synchronize components with upstream
#
update:
	git submodule foreach 'git checkout $(BRANCH_MASTER) && git pull $(ORIGIN) $(BRANCH_MASTER)'
	git submodule foreach 'git checkout $(BRANCH_DEV) && git pull $(ORIGIN) $(BRANCH_DEV)'

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

#
# Test working copy version
#
test:
	./export-wc.sh $(TEXMF_TMP)
	./run-tests.sh $(TEXMF_TMP)

#
# Test production branch (of each component)
#
test-master: 
	./export-branch.sh $(BRANCH_MASTER) $(TEXMF_TMP)
	./run-tests.sh $(TEXMF_TMP)

#
# Test development branch (of each component)
#
test-dev: 
	./export-branch.sh $(BRANCH_DEV) $(TEXMF_TMP)
	./run-tests.sh $(TEXMF_TMP)

#
# 1) Merge development branch into production branch in each component
# 2) Creates new commit in the 'dist' repository with updated submodules to new
#    production branches in components
#
release: test-dev
	export MESSAGE=`mktemp` ;\
	echo "Released texmf.dist" >> $$MESSAGE ;\
	echo >> $$MESSAGE ;\
	git submodule foreach 'git pull $(ORIGIN) $(BRANCH_MASTER)' ; \
	git submodule foreach 'export name; \
		$(merge) $(ORIGIN) $(BRANCH_MASTER) $(BRANCH_DEV) $$MESSAGE' ;\
	git submodule foreach 'git push $(ORIGIN) $(BRANCH_MASTER) $(BRANCH_DEV)' ; \
	git add -u components ;\
	git commit -F $$MESSAGE ;\
	git push $(ORIGIN) $(BRANCH_DIST_MASTER)
	git submodule foreach 'git checkout $(BRANCH_DEV)'

#
# Creates ZIP archive with all components in their production branches
#
zip-build: test-master
	./zip-build.sh $(ORIGIN)/$(BRANCH_MASTER)

#
# Creates DEB package for each component (their production branch)
#
deb-build: test-master
	rm -f $(OUT)/*.deb
	git submodule foreach 'fks-debbuild.sh -g $$PWD -b $(OUT) -r $(BRANCH_MASTER)'

#
# Publish all created DEB packages to the repository
#
deb-publish: deb-build
	fks-pkg-upload.sh $(OUT)/*.deb
