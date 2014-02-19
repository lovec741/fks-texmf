.PHONY: test release deb-build deb-publish zip-build init test-build

OUT=./out

init:
	git submodule init
	git submodule update
	git submodule foreach 'git checkout dev'

test:
	./run-tests.sh

test-build:
	./run-tests.sh master

release: test
	export MESSAGE=`mktemp` ;\
	echo "Released texmf.fist" >> $$MESSAGE ;\
	echo >> $$MESSAGE ;\
	git submodule foreach 'git pull origin master' ; \
	git submodule foreach '\
		git checkout master && \
		git merge --no-ff dev && \
		git push origin && \
		echo "\t$$name at version `git describe --tags`" >> $$MESSAGE' ;\
	git add -u components ;\
	git commit -F $$MESSAGE ;\
	git push origin master
	git submodule forach 'git checkout dev'

zip-build: test-build
	./build-zip.sh

deb-build: test-build
	rm -f "$(OUT)/*.deb"
	out=$$PWD/$(OUT) ; git submodule foreach 'fks-debbuild.sh -b $$out'

deb-publish: deb-build
	fks-pkgupload.sh $(OUT)/*.deb
