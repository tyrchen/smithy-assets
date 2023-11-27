do_nothing:
	@echo "Nothing to do"

release:
	@git cliff -o CHANGELOG.md
	@git commit -a -m "Update CHANGELOG.md" || true
	@git tag `cat VERSION`
	@git push origin master --tags

.PHONY: release
