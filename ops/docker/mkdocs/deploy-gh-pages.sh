#!/bin/bash
set -e

# Ensure services are running
echo "Ensuring services are running..."
docker compose up -d plantuml mkdocs

# Build the MkDocs site
echo "Building MkDocs site..."
docker compose exec mkdocs mkdocs build

# Create a temporary directory for the build
TEMP_DIR=$(mktemp -d)

# Copy the built site from the container to the host
echo "Copying site files from container..."
docker compose cp mkdocs:/docs/site/. $TEMP_DIR/

# Switch to gh-pages branch or create it if it doesn't exist
echo "Deploying to GitHub Pages..."
git checkout gh-pages 2>/dev/null || git checkout -b gh-pages

# Remove existing files
rm -rf *

# Copy the built site
cp -r $TEMP_DIR/* .

# Add and commit changes
git add .
git commit -m "Update GitHub Pages site"

# Push to GitHub
git push origin gh-pages

# Clean up
rm -rf $TEMP_DIR
git checkout main

echo "GitHub Pages site deployed successfully!"
