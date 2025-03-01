#!/bin/bash

# check if PROJECT_ID argument is provided
if [ -z "$1" ]; then
    echo "Error: PROJECT_ID is required"
    echo "Usage: $0 <PROJECT_ID>"
    exit 1
fi

PROJECT_ID=$1

services=(
    "eshop-eshop-auth"
    "eshop-eshop-cart"
    "eshop-eshop-order"
    "eshop-eshop-payment"
    "eshop-eshop-product"
    "eshop-eshop-sales-report"
    "eshop-eshop-warehouse"
    "eshop-eshop-fe-customer"
    "eshop-eshop-fe-admin"
)

# tag each service
for service in "${services[@]}"; do
    echo "Tagging $service..."
    docker tag "$service" "gcr.io/${PROJECT_ID}/${service}:v1"
done

echo "All images tagged successfully!"