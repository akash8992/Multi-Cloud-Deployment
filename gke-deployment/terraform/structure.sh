#!/bin/bash

# Define the root directory
ROOT_DIR="gke-deployment"

# Define the directory structure
DIRS=(
    "$ROOT_DIR/terraform"

)

# Define the files to be created
FILES=(
    "$ROOT_DIR/terraform/main.tf"
    "$ROOT_DIR/terraform/variables.tf"
    "$ROOT_DIR/terraform/outputs.tf"
    "$ROOT_DIR/terraform/providers.tf"
    "$ROOT_DIR/terraform/vpc.tf"
    "$ROOT_DIR/terraform/gke.tf"
    "$ROOT_DIR/terraform/firewall.tf"
    "$ROOT_DIR/terraform/iam.tf"
    "$ROOT_DIR/terraform/service_account.tf"
    "$ROOT_DIR/terraform/backend.tf"

)

# Create directories
echo "Creating directories..."
for dir in "${DIRS[@]}"; do
    mkdir -p "$dir"
    echo "Created: $dir"
done

# Create empty files
echo "Creating files..."
for file in "${FILES[@]}"; do
    touch "$file"
    echo "Created: $file"
done

echo "✅ Folder structure successfully created!"

