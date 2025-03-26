#!/bin/bash

# Navigate to the frontend directory
cd "$(dirname "$0")"

# Install the OpenAPI Generator CLI if not already installed
npm install @openapitools/openapi-generator-cli

# Generate the API client
npx openapi-generator-cli generate \
  -i ../backend/docs/swagger.json \
  -g typescript-axios \
  -o src/api \
  --additional-properties=supportsES6=true,npmName=marketplace-api-client,npmVersion=1.0.0

echo "API client generated successfully!"