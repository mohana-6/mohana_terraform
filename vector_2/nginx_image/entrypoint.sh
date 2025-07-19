#!/bin/sh
 
set -e
 
# Ensure the environment variable is set
if [ -z "$NGINX_CONFIG_BUCKET_URL" ]; then
  echo "Error: NGINX_CONFIG_BUCKET_URL is not set"
  exit 1
fi
 
# Copy file from S3 to destination
echo "Fetching default.conf from $NGINX_CONFIG_BUCKET_URL..."
aws s3 cp "$NGINX_CONFIG_BUCKET_URL" /etc/nginx/conf.d/default.conf
 
# Run the nginx application
echo "Starting NGINX..."
exec nginx -g "daemon off;"