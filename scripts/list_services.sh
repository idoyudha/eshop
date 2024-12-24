#!/bin/bash

# Get services from docker-compose.yml
get_services() {
    docker compose config --services
}

# Print available services
echo "Available services:"
get_services | while read -r service; do
    echo "  - $service"
done