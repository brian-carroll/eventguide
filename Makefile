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


dist/js/elm.min.js: dist/js/elm.js
	node_modules/.bin/uglifyjs dist/js/elm.js -o dist/js/elm.min.js --compress --mangle


.PHONY: deploy
deploy: clean index.html dist/js/elm.min.js dist/css
	@status=$$(git status --porcelain); \
	commit=$$(git log -n 1 --pretty=format:%H); \
	branch=$$(git rev-parse --abbrev-ref HEAD); \
	msg=$$(printf "Deployed from $${branch}\n\nCommit $${commit}"); \
	if [ -n "$${status}" ]; then \
		echo ; \
		echo " ** Working directory is dirty ** " >&2; \
		echo "$${status}"; \
	else \
		rsync -ai --delete dist/css/ ../eventguide-dist/dist/css/; \
		cp dist/js/elm.min.js ../eventguide-dist/dist/js/elm.js; \
		cp index.html ../eventguide-dist/index.html; \
		cd ../eventguide-dist/; \
		git add . ; \
		git commit -m "$${msg}" ; \
		git push; \
	fi
