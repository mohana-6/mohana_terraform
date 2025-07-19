FROM nginx:alpine
RUN apk add --no-cache \
    aws-cli \
    groff \
    less
    
# Set entrypoint script
#COPY entrypoint.sh /entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]
ENTRYPOINT ["nginx", "-g", "daemon off;"]