#!/bin/bash

# Define the list of repositories
REPOS=(
    "git@github.com:idoyudha/eshop-auth.git"
    "git@github.com:idoyudha/eshop-cart.git"
    "git@github.com:idoyudha/eshop-order.git"
    "git@github.com:idoyudha/eshop-payment.git"
    "git@github.com:idoyudha/eshop-product.git"
    "git@github.com:idoyudha/eshop-sales-report.git"
    "git@github.com:idoyudha/eshop-warehouse.git"
    "git@github.com:idoyudha/eshop-fe-customer.git"
    "git@github.com:idoyudha/eshop-fe-admin.git"
    "git@github.com:idoyudha/eshop-shipping-cost.git"
)

# Navigate to the script's parent directory (root/src)
SCRIPT_DIR=$(dirname "$0")
ROOT_DIR=$(cd "$SCRIPT_DIR/.." && pwd)
TARGET_DIR="$ROOT_DIR/src"

# Create the src directory if it does not exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating src directory..."
    mkdir -p "$TARGET_DIR"
fi

# Navigate to src directory
cd "$TARGET_DIR"

# Clone each repository in the list
for REPO in "${REPOS[@]}"; do
    REPO_NAME=$(basename "$REPO" .git)
  
    if [ -d "$REPO_NAME" ]; then
        echo "Repository '$REPO_NAME' already exists. Skipping..."
    else
        echo "Cloning '$REPO'..."
        git clone "$REPO"
    fi
done

echo "All repositories cloned!"