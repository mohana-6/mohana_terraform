
FROM timberio/vector:0.39.0-alpine

# Install additional packages including NGINX
RUN apk add --no-cache \
    nginx \
    aws-cli \
    groff \
    less \
    curl

# Copy NGINX config to its default location
COPY nginx.conf /etc/nginx/nginx.conf

# Copy and set permissions on entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Optional: expose NGINX port (Vector runs on 8686 internally)
EXPOSE 8080

# Entrypoint will start both services
ENTRYPOINT ["/entrypoint.sh"]
