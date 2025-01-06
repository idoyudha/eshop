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
    "eshop-auth"
    "eshop-cart"
    "eshop-fe-admin"
    "eshop-fe-customer"
    "eshop-order"
    "eshop-payment"
    "eshop-product"
    "eshop-warehouse"
)

# Update only specific deployment files
for service in "${services[@]}"; do
    file="k8s/${service}-deployment.yaml"
    if [ -f "$file" ]; then
        echo "Updating $file..."
        # Use sed to update the image reference with double eshop- prefix
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS requires an empty string after -i
            sed -i '' "s|image: .*|image: gcr.io/${PROJECT_ID}/eshop-${service}:latest|" "$file"
        else
            # Linux version
            sed -i "s|image: .*|image: gcr.io/${PROJECT_ID}/eshop-${service}:latest|" "$file"
        fi
    else
        echo "Warning: $file not found"
    fi
done

echo "All deployment files updated to use GCR images from project: $PROJECT_ID"