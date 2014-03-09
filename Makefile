.PHONY: test release deb-build deb-publish zip-build init test-build

OUT=./out
BRANCH_DIST_MASTER=master
BRANCH_MASTER=dev-master
BRANCH_DEV=dev-dev

init:
	git submodule init
	git submodule update
	git submodule foreach 'git checkout $(BRANCH_DEV)'

test:
	./run-tests.sh $(BRANCH_DEV)

test-build:
	./run-tests.sh $(BRANCH_MASTER)

release: test
	export MESSAGE=`mktemp` ;\
	echo "Released texmf.dist" >> $$MESSAGE ;\
	echo >> $$MESSAGE ;\
	git submodule foreach 'git pull origin $(BRANCH_MASTER)' ; \
	git submodule foreach '\
		git checkout $(BRANCH_MASTER) && \
		git merge --no-ff $(BRANCH_DEV) && \
		git push origin $(BRANCH_MASTER) && \
		echo "\t$$name at version `git describe --tags`" >> $$MESSAGE' ;\
	git add -u components ;\
	git commit -F $$MESSAGE ;\
	git push origin $(BRANCH_DIST_MASTER)
	git submodule foreach 'git checkout $(BRANCH_DEV)'

zip-build: test-build
	./zip-build.sh $(BRANCH_MASTER)

deb-build: test-build
	rm -f "$(OUT)/*.deb"
	out=$$PWD/$(OUT) ; git submodule foreach 'fks-debbuild.sh -b $$out'

deb-publish: deb-build
	fks-pkgupload.sh $(OUT)/*.deb
