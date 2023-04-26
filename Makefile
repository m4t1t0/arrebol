COLOR_RESET = \033[0m
COLOR_INFO = \033[32m
COLOR_COMMENT = \033[33m

UID := $(shell id -u)
GID := $(shell id -g)

ifndef DISABLE_INTERACTIVE
	INTERACTIVE_FLAG =
else
	INTERACTIVE_FLAG = -T
endif

PROJECT_NAME = $(shell basename $(CURDIR) | tr A-Z a-z)
DOCKER_COMPOSE = docker-compose -p ${PROJECT_NAME}
EXEC_APP = $(DOCKER_COMPOSE) run ${INTERACTIVE_FLAG} --rm app sh -c

XDEBUG_OFF = XDEBUG_MODE=off
XDEBUG_COVERAGE = XDEBUG_MODE=coverage

.DEFAULT_GOAL := help

##@ Helpers

.PHONY: help
help: ## Display help
	@awk 'BEGIN {FS = ":.*##"; printf "\n\033[1;34m${PROJECT_NAME}\033[0m\nPersonal project to practice DDD + CQRS + Event Sourcing\n \nUsage:\n  make \033[1;34m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[1;34m%-30s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Main commands

.PHONY: start
start: ## Start this project
	$(DOCKER_COMPOSE) up -d --remove-orphans

.PHONY: restart
restart: ## Restart this project
	$(DOCKER_COMPOSE) restart

.PHONY: stop
stop: ## Stop this project
	$(DOCKER_COMPOSE) stop

.PHONY: bash
bash: ## Takes you inside the app container
	$(DOCKER_COMPOSE) exec app sh