#!/bin/bash

# Check if PROJECT_ID argument is provided
if [ -z "$1" ]; then
    echo "Error: PROJECT_ID is required"
    echo "Usage: $0 <PROJECT_ID>"
    exit 1
fi

PROJECT_ID=$1

# Update deployment files to use GCR images
for file in k8s/*deployment.yaml; do
    echo "Updating $file..."
    # Get the service name from the filename (e.g., eshop-auth from eshop-auth-deployment.yaml)
    service_name=$(basename "$file" | sed 's/-deployment.yaml//')
    
    # Use sed to update the image reference
    # This replaces any image: line with the GCR path
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS requires an empty string after -i
        sed -i '' "s|image: .*|image: gcr.io/${PROJECT_ID}/${service_name}:v1|" "$file"
    else
        # Linux version
        sed -i "s|image: .*|image: gcr.io/${PROJECT_ID}/${service_name}:v1|" "$file"
    fi
done

echo "All deployment files updated to use GCR images from project: $PROJECT_ID"