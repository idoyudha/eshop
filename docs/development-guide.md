# Development Guide
This guide is for developers who want to work on the Eshop project.

## Prerequisites
- [Kubernetes](https://kubernetes.io/)
- [Docker for Desktop](https://www.docker.com/)
- Google Cloud Project with Google Container Registry enabled (for Option 2 - GKE)

## Option 1 - Local Development (Docker Compose)
1. Clone the repository to your local machine using `git clone https://github.com/idoyudha/eshop.git`.
2. Navigate to the repository directory.
3. Run `make clone` to clone all repositories, or manual clone all repos.
4. Run `make build` to build all services.
5. Run `make up` to start all services.

## Option 2 - GKE
1. Clone the repository to your local machine using `git clone https://github.com/idoyudha/eshop.git`.
2. Navigate to the repository directory.
3. Run `make clone` to clone all repositories, or manual clone all repos.
4. Set `.env` files for all services.
5. Run `make kompose` to generate kubernetes yaml files (configmaps, secrets, services, deployments).
6. Run `kubectl apply -f k8s/ -n eshop` to deploy all services to GKE. (Make sure to set the namespace to `eshop`).
See [deployment doc](/docs/deployment.md) for more details of the commands.

