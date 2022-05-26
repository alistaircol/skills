# https://gist.github.com/rsperl/d2dfe88a520968fbc1f49db0a29345b9
# define standard colors
BLACK        := $(shell tput -Txterm setaf 0)
RED          := $(shell tput -Txterm setaf 1)
GREEN        := $(shell tput -Txterm setaf 2)
YELLOW       := $(shell tput -Txterm setaf 3)
LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
PURPLE       := $(shell tput -Txterm setaf 5)
BLUE         := $(shell tput -Txterm setaf 6)
WHITE        := $(shell tput -Txterm setaf 7)
RESET        := $(shell tput -Txterm sgr0)

# name of image we will build and run comamnds in
image_skills = alistaircol/skills

# generic docker run
docker_run = docker run \
	--rm \
	$(shell tty -s && echo "-i" || echo) \
	--volume="$(shell pwd):/app" \
	--workdir="/app" \
	--user="$(shell id -u):$(shell id -g)"

# docker run for our image
docker_run_image = $(docker_run) ${image_skills}

# docker run dot in out image
docker_run_image_dot = $(docker_run_image) dot

.PHONY: help
help:
	@echo "Ally's skills tree"
	@echo ""
	@echo "subcommands:"
	@echo "  $(GREEN)lint$(RESET)   runs $(WHITE)yamllint$(RESET) for workflow files $(LIGHTPURPLE)(local only)$(RESET)"
	@echo "  $(GREEN)image$(RESET)  builds a docker image (basically $(WHITE)dot$(RESET) with custom font)"
	@echo "  $(GREEN)build$(RESET)  builds skills tree assets"

lint:
	@${docker_run} cytopia/yamllint:latest .

image:
	BUILDKIT_PROGRESS=plain docker build --tag=${image_skills} .

.PHONY: build
build: clean dot png svg pdf
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)done!$(RESET)"

clean:
	@find "$(shell pwd)/build" -type f -not -name '.gitkeep' -not -name 'README.md' -delete

dot:
	@bash skills.sh
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) skills $(WHITE)dot$(RESET) file"

png:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/skills.png skills.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="#41403e" -o build/skills-web.png skills.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) skills $(WHITE)png$(RESET) files"

svg:
	@$(docker_run_image_dot) -Tsvg -o build/skills.svg skills.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) skills $(WHITE)svg$(RESET) file"

pdf:
	@$(docker_run_image_dot) -Tps2 -o build/skills.ps skills.dot
	@$(docker_run_image) ps2pdf build/skills.ps build/skills.pdf
	@rm build/skills.ps
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) skills $(WHITE)pdf$(RESET) file"

version:
	@git --no-pager tag | grep -v "^v" | sort -V
