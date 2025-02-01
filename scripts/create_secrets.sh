#!/bin/bash

# Function to convert .env file to kubectl secret command
create_secret_from_env() {
    local service_name=$1
    local env_file=$2
    local namespace=$3

    if [ ! -f "$env_file" ]; then
        echo "Warning: $env_file not found, skipping..."
        return
    }

    # Create a generic secret from env file
    echo "Creating secret for $service_name from $env_file"
    kubectl create secret generic "$service_name-env" \
        --from-env-file="$env_file" \
        --namespace="$namespace" \
        --dry-run=client -o yaml | kubectl apply -f -
}

# Main execution
NAMESPACE="eshop"

# List of services and their corresponding .env files
declare -A SERVICE_ENV_FILES=(
    ["eshop-auth"]="./src/eshop-auth/.env"
    ["eshop-cart"]="./src/eshop-cart/.env"
    ["eshop-order"]="./src/eshop-order/.env"
    ["eshop-payment"]="./src/eshop-payment/.env"
    ["eshop-product"]="./src/eshop-product/.env"
    ["eshop-sales-report"]="./src/eshop-sales-report/.env"
    ["eshop-warehouse"]="./src/eshop-warehouse/.env"
    ["eshop-fe-customer"]="./src/eshop-fe-customer/.env.local"
    ["eshop-fe-admin"]="./src/eshop-fe-admin/.env.local"
)

# Create namespace if it doesn't exist
if ! kubectl get namespace "$NAMESPACE" &> /dev/null; then
    kubectl create namespace "$NAMESPACE"
fi

# Create secrets for each service
for service in "${!SERVICE_ENV_FILES[@]}"; do
    create_secret_from_env "$service" "${SERVICE_ENV_FILES[$service]}" "$NAMESPACE"
done

echo "All secrets created successfully in namespace: $NAMESPACE"