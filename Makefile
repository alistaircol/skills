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

web_color = \#41403e

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
build: clean dot png svg pdf secondary
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)done!$(RESET)"

clean:
	@find "$(shell pwd)/build" -type f -not -name '.gitkeep' -not -name 'README.md' -delete
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)cleaned build$(RESET)"
	@find "$(shell pwd)/bin" -type f -not -name 'README.md' -delete
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)cleaned bin$(RESET)"

dot:
	@bash build.sh
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) skills $(WHITE)dot$(RESET) file"

png:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/skills.png bin/skills.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/skills-web.png bin/skills.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) skills $(WHITE)png$(RESET) files"

svg:
	@$(docker_run_image_dot) -Tsvg -o build/skills.svg bin/skills.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) skills $(WHITE)svg$(RESET) file"

pdf:
	@$(docker_run_image_dot) -Tps2 -o build/skills.ps bin/skills.dot
	@$(docker_run_image) ps2pdf build/skills.ps build/skills.pdf
	@rm build/skills.ps
	@bash canonicalise-pdf-skills.sh
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) skills $(WHITE)pdf$(RESET) file"

secondary_dot:
	@SKILLS_DIRECTION=TB bash build.sh

secondary: secondary_dot environment devops ssg servers proxies db queues cloud php css js misc concepts

environment:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/environment.png bin/environment.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/environment-web.png bin/environment.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) environment $(WHITE)png$(RESET) files"

devops:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/devops.png bin/devops.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/devops-web.png bin/devops.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) devops $(WHITE)png$(RESET) files"

ssg:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/ssg.png bin/ssg.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/ssg-web.png bin/ssg.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) ssg $(WHITE)png$(RESET) files"

servers:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/servers.png bin/servers.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/servers-web.png bin/servers.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) servers $(WHITE)png$(RESET) files"

proxies:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/proxies.png bin/proxies.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/proxies-web.png bin/proxies.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) proxies $(WHITE)png$(RESET) files"

db:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/db.png bin/db.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/db-web.png bin/db.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) db $(WHITE)png$(RESET) files"

queues:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/queues.png bin/queues.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/queues-web.png bin/queues.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) queues $(WHITE)png$(RESET) files"

cloud:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/cloud.png bin/cloud.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/cloud-web.png bin/cloud.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) cloud $(WHITE)png$(RESET) files"

php:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/php.png bin/php.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/php-web.png bin/php.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) cloud $(WHITE)png$(RESET) files"

css:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/css.png bin/css.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/css-web.png bin/css.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) css $(WHITE)png$(RESET) files"

js:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/js.png bin/js.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/js-web.png bin/js.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) js $(WHITE)png$(RESET) files"

misc:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/misc.png bin/misc.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/misc-web.png bin/misc.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) misc $(WHITE)png$(RESET) files"

concepts:
	@$(docker_run_image_dot) -Tpng -Gbgcolor="transparent" -o build/subgraphs/concepts.png bin/concepts.dot
	@$(docker_run_image_dot) -Tpng -Gbgcolor="$(web_color)" -o build/subgraphs/concepts-web.png bin/concepts.dot
	@echo "$(WHITE)$(shell date +"%d/%m/%Y %H:%M:%S")$(RESET) $(GREEN)built$(RESET) concepts $(WHITE)png$(RESET) files"


version:
	@git --no-pager tag | grep -v "^v" | sort -V
