# Simple NGINX image serving your HTML page
FROM nginx:alpine

# Copy your site files into NGINX default web directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
