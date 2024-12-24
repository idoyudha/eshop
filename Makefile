.PHONY: help

help: ## Display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

up: ### up all services
	docker compose up -d
.PHONY: up

down: ### down all services
	docker compose down
.PHONY: down

stop: ### stop all services
	docker compose stop
.PHONY: down

restart: ### restart all services
	docker compose restart
.PHONY: down

clone: ### clone repository
	bash scripts/clone_repos.sh

build: ### build service
	@bash scripts/build.sh $(filter-out $@,$(MAKECMDGOALS))

logs: ### show logs
	@bash scripts/logs.sh $(filter-out $@,$(MAKECMDGOALS))
.PHONY: clone