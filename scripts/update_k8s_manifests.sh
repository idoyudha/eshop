#!/bin/bash

# Check if PROJECT_ID argument is provided
if [ -z "$1" ]; then
    echo "Error: PROJECT_ID is required"
    echo "Usage: $0 <PROJECT_ID>"
    exit 1
fi

PROJECT_ID=$1

# List of services to update
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

# Update only specific deployment files
for service in "${services[@]}"; do
    file="k8s/${service}-deployment.yaml"
    # update image
    if [ -f "$file" ]; then
        echo "Updating $file..."
        sed -i "s|image: .*|image: gcr.io/${PROJECT_ID}/${service}:latest|" "$file"
    else
        echo "Warning: $file not found"
    fi
done

echo "All deployment files updated to use GCR images from project: $PROJECT_ID"