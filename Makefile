dist/js/elm.js: src/* src/*/* elm-package.json
	elm make src/Main.elm --output dist/js/elm.js


dist/css: assets/css/*
	rsync -ai --delete assets/css/ dist/css/


.PHONY: clean
clean:
	rm -rf tests/elm-stuff/build-artifacts/*/user
	rm -rf elm-stuff/build-artifacts/*/user


.PHONY: test
test:
	node_modules/.bin/elm-test


.PHONY: compress
compress:
	node_modules/.bin/uglifyjs dist/js/elm.js -o dist/js/elm.min.js --compress --mangle


.PHONY: deploy
deploy: clean dist/js/elm.js compress dist/css
	message="Deployed from Makefile\n\n$(git status -sb)\n\n$(git show -q)"
	rsync -ai --delete dist/css/ ../eventguide-dist/dist/css/
	cp dist/js/elm.min.js ../eventguide-dist/dist/js/elm.js
	cp index.html ../eventguide-dist/
	cd ../eventguide-dist/
	git add .
	echo "$message" | git commit --file /dev/stdin
	git push
