.PHONY clean test compress deploy

dist/js/elm.js: src/* src/*/* elm-package.json
	echo -e "Building Elm app into dist/\n\n"
	rm -rf dist/js/elm.*
	elm make src/Main.elm --output dist/js/elm.js

dist/css/*: assets/css/*
	echo -e "Copying CSS to dist/\n\n"
	rsync -ai --delete assets/css/ dist/css/

clean:
	echo -e "Deleting Elm build artifacts\n\n"
	rm -rf tests/elm-stuff/build-artifacts/*/user
	rm -rf elm-stuff/build-artifacts/*/user

test: clean
	echo -e "Running Elm tests...\n\n"
	elm test

compress:
	echo -e "Compressing JavaScript...\n\n"	
	closure-compiler --compilation_level ADVANCED_OPTIMIZATIONS --language_in ECMASCRIPT5 --js dist/js/elm.js > dist/js/elm.min.js
	mv dist/js/elm.min.js dist/js/elm.js

deploy: dist/js/elm.js compress
	echo -e "Deploying to GitHub Pages...\n\n"
	rsync -ai --delete dist/ ../eventguide-dist/dist/
	cp index.html ../eventguide-dist/
	cd ../eventguide-dist/
	git add .
	git commit -m ""