#!/bin/sh

set -e

# Ensure the environment variable is set

if [ -z "$VECTOR_CONFIG_BUCKET_URL" ]; then

  echo "Error: VECTOR_CONFIG_BUCKET_URL is not set"

  exit 1

fi

# Copy file from S3 to destination

echo "Fetching vector.yaml from $VECTOR_CONFIG_BUCKET_URL..."

aws s3 cp "$VECTOR_CONFIG_BUCKET_URL" /etc/vector/vector.yaml

# Run the vector  application

vector --config /etc/vector/vector.yaml &

sleep 2

# Start NGINX in the foreground (this keeps the container running)
echo "Starting NGINX..."
nginx -g "daemon off;"