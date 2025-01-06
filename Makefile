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

kompose: ### convert docker-compose.prod.yml to kubernetes yaml and update the images
	@kompose convert -f docker-compose.prod.yml --controller deployment --out k8s
	@bash scripts/update_k8s_manifests.sh eshop-444706
.PHONY: kompose

create-secrets: ### create kubernetes secrets from env files
	@bash scripts/create_secrets.sh
.PHONY: create-secrets

tag: ### tag docker images with GCR prefix
	@bash scripts/tag_images.sh $(filter-out $@,$(MAKECMDGOALS))
.PHONY: tag

push: ### push docker images to GCR
	@bash scripts/push_images.sh $(filter-out $@,$(MAKECMDGOALS))
.PHONY: push

# tag-push: ### tag and push docker images to GCR
# 	@bash scripts/tag_images.sh $(filter-out $@,$(MAKECMDGOALS))
# 	@bash scripts/push_images.sh $(filter-out $@,$(MAKECMDGOALS))
# .PHONY: tag-push

deploy: ### deploy all services to kubernetes
	@bash scripts/deploy.sh
.PHONY: deploy

k8s-status: ### Check Kubernetes deployment status
	kubectl get pods,svc,configmap -n eshop
.PHONY: k8s-status

k8s-logs: ### Get logs for a specific pod
	@kubectl logs -f -n eshop $(filter-out $@,$(MAKECMDGOALS))
.PHONY: k8s-logs

k8s-delete: ### Delete all resources from namespace
	kubectl delete -f k8s/ -n eshop
.PHONY: k8s-delete

auth-gcloud: ### Authorize gcloud
	gcloud auth configure-docker
.PHONY: auth-gcloud

gcloud-token: ### Get gcloud token
	gcloud auth print-access-token
.PHONY: gcloud-token