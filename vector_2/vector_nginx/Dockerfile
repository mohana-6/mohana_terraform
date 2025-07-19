FROM timberio/vector:0.39.0-alpine

# Install additional packages including NGINX
RUN apk add --no-cache \
    nginx \
    aws-cli \
    groff \
    less \
    curl \
    bash \
    ca-certificates \
    unzip \
  && curl -sSL -o /usr/local/bin/grpcurl.tar.gz \
       https://github.com/fullstorydev/grpcurl/releases/download/v1.9.3/grpcurl_1.9.3_linux_x86_64.tar.gz \
  && tar -xzf /usr/local/bin/grpcurl.tar.gz -C /usr/local/bin \
  && chmod +x /usr/local/bin/grpcurl \
  && rm /usr/local/bin/grpcurl.tar.gz

# Optional: verify installation
RUN grpcurl --version

# Copy NGINX config to its default location
COPY nginx.conf /etc/nginx/nginx.conf

# Copy and set permissions on entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Optional: expose NGINX port (Vector runs on 8686 internally)
EXPOSE 8787

# Entrypoint will start both services
ENTRYPOINT ["/entrypoint.sh"]