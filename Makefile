lint:
	@task lint

image:
	@task build_dot_image

.PHONY: build
build:
	@task

version:
	@git --no-pager tag | grep -v "^v" | sort -V
