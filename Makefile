.PHONY: test release deb-build deb-publish zip-build init test-build update

mkfile_path:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
OUT:=$(mkfile_path)out
BRANCH_DIST_MASTER=master
BRANCH_MASTER=master
BRANCH_DEV=dev
ORIGIN=origin
merge:=$(mkfile_path)merge-component.sh

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
# Run tests on develepment branch (of each component)
#
test:
	./run-tests.sh $(BRANCH_DEV)

#
# Run tests on production branch (of each component)
#
test-build: 
	./run-tests.sh $(BRANCH_MASTER)

#
# 1) Merge development branch into production branch in each component
# 2) Creates new commit in the 'dist' repository with updated submodules to new
#    production branches in components
#
release: test
	export MESSAGE=`mktemp` ;\
	echo "Released texmf.dist" >> $$MESSAGE ;\
	echo >> $$MESSAGE ;\
	git submodule foreach 'git pull $(ORIGIN) $(BRANCH_MASTER)' ; \
	git submodule foreach '$(merge) $(ORIGIN) $(BRANCH_MASTER) $(BRANCH_DEV) $$MESSAGE' ;\
	git add -u components ;\
	git commit -F $$MESSAGE ;\
	git push $(ORIGIN) $(BRANCH_DIST_MASTER)
	git submodule foreach 'git checkout $(BRANCH_DEV)'

#
# Creates ZIP archive with all components in their production branches
#
zip-build: test-build
	./zip-build.sh $(BRANCH_MASTER)

#
# Creates DEB package for each component (their production branch)
#
deb-build: test-build
	rm -f "$(OUT)/*.deb"
	export out=$$PWD/$(OUT) ; git submodule foreach 'fks-debbuild.sh -g $$PWD -b $$out -r $(BRANCH_MASTER)'

#
# Publish all created DEB packages to the repository
#
deb-publish: deb-build
	fks-pkg-upload.sh $(OUT)/*.deb
