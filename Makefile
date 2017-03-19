.PHONY: elm
elm: dist/elm.js dist/index.css


dist/elm.js: src/* src/*/* elm-package.json
	elm make src/Main.elm --output dist/elm.js


dist/index.css: src/Styles.elm src/Styles/*
	node_modules/.bin/elm-css --module Styles --output dist/ src/Styles.elm


.PHONY: clean
clean:
	rm -rf tests/elm-stuff/build-artifacts/*/user
	rm -rf elm-stuff/build-artifacts/*/user
	rm -rf dist/*


.PHONY: test
test:
	node_modules/.bin/elm-test


dist/elm.min.js: dist/elm.js
	node_modules/.bin/uglifyjs dist/elm.js -o dist/elm.min.js --compress --mangle


# Make syntax is nearly, but not quite, the same as shell script! :(
#	@	Don't echo the command
# 	$$	Shell script '$', rather than Make '$'
# Each *line* is executed in its own shell => use ';' and '\' to chain commands as one line
# https://www.gnu.org/software/make/manual/html_node/index.html
#
.PHONY: deploy
deploy: clean index.html dist/elm.min.js dist
	@status=$$(git status --porcelain); \
	commit=$$(git log -n 1 --pretty=format:%H); \
	branch=$$(git rev-parse --abbrev-ref HEAD); \
	msg=$$(printf "Deployed from $${branch}\n\nCommit $${commit}"); \
	if [ -n "$${status}" ]; then \
		echo ; \
		echo " ** Working directory is dirty ** " >&2; \
		echo "$${status}"; \
	else \
		rsync -ai --delete dist/ ../eventguide-dist/dist/; \
		cp dist/elm.min.js ../eventguide-dist/dist/elm.js; \
		cp index.html ../eventguide-dist/index.html; \
		cd ../eventguide-dist/; \
		git add . ; \
		git commit -m "$${msg}" ; \
		git push; \
	fi
