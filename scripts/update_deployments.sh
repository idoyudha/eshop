#!/bin/bash

# Function to update deployment to use secrets
update_deployment_with_secrets() {
    local deployment_file=$1
    local service_name=$(basename "$deployment_file" | sed 's/-deployment.yaml//')
    
    echo "Updating $deployment_file to use secrets..."
    
    # Create temporary file
    tmp_file=$(mktemp)
    
    # Read deployment file and modify it
    cat "$deployment_file" | \
    # Remove existing env_file section if it exists
    sed '/env_file:/,+1d' | \
    # Add envFrom section to use secrets
    sed '/containers:/a\        envFrom:\n        - secretRef:\n            name: '"$service_name"'-env' \
    > "$tmp_file"
    
    # Replace original file
    mv "$tmp_file" "$deployment_file"
}

# Update all deployment files
for deployment in k8s/*deployment.yaml; do
    update_deployment_with_secrets "$deployment"
done

echo "All deployment files updated to use secrets"