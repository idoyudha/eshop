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
.PHONY: stop

restart: ### restart all services
	docker compose restart
.PHONY: restart

clone: ### clone repository
	bash scripts/clone_repos.sh
.PHONY: clone

build: ### build service
	@bash scripts/build.sh $(filter-out $@,$(MAKECMDGOALS))

logs: ### show logs
	@bash scripts/logs.sh $(filter-out $@,$(MAKECMDGOALS))

topic0: ### show list of topic kafka0
	docker exec kafka0 kafka-topics --list --bootstrap-server localhost:9092

topic1: ### show list of topic kafka1
	docker exec kafka1 kafka-topics --list --bootstrap-server localhost:9092

build-prod: ### build all services for production
	docker compose -f docker-compose.prod.yml build

kompose: ### convert docker-compose.prod.yml to kubernetes yaml
	kompose convert -f docker-compose.prod.yml --controller deployment --out k8s
.PHONY: kompose

tag: ### tag docker images with GCR prefix
	@bash scripts/tag_images.sh $(filter-out $@,$(MAKECMDGOALS))
.PHONY: tag

push: ### push docker images to GCR
	@bash scripts/push_images.sh $(filter-out $@,$(MAKECMDGOALS))
.PHONY: push

tag-push: ### tag and push docker images to GCR
	@bash scripts/tag_images.sh $(filter-out $@,$(MAKECMDGOALS))
	@bash scripts/push_images.sh $(filter-out $@,$(MAKECMDGOALS))
.PHONY: tag-push