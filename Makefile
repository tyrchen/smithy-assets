update_submodules:
	@git submodule update --init
	@git submodule update --recursive --remote

build:
	@cd rust && ./gradlew publishToMavenLocal
	@cd python/codegen && ./gradlew publishToMavenLocal
	@cd swift && ./gradlew publishToMavenLocal
	@cd typescript && ./gradlew publishToMavenLocal

release:
	@git cliff -o CHANGELOG.md
	@git commit -a -m "Update CHANGELOG.md" || true
	@git tag `cat VERSION`
	@git push origin master --tags

.PHONY: release build update_submodules
