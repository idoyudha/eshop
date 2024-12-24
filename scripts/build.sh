#!/bin/bash

# Get the service name from argument
SERVICE=$1

# Check if service name is provided
if [ -z "$SERVICE" ]; then
    echo "Error: Please provide a service name"
    echo "Usage: make build service_name"
    echo ""
    bash scripts/list_services.sh
    exit 1
fi

# Check if service exists
if docker compose config --services | grep -q "^$SERVICE\$"; then
    echo "Building service: $SERVICE"
    docker compose build "$SERVICE"
else
    echo "Error: Service '$SERVICE' not found"
    echo ""
    bash scripts/list_services.sh
    exit 1
fi