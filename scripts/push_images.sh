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

# push each service
for service in "${services[@]}"; do
    echo "Pushing $service..."
    docker push "gcr.io/${PROJECT_ID}/${service}:v1"
done

echo "All images pushed successfully!"