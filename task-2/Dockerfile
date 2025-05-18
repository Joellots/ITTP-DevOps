FROM nginx:alpine

RUN mkdir -p /etc/nginx/ssl
COPY selfsigned.crt selfsigned.key /etc/nginx/ssl/
COPY nginx.conf /etc/nginx/nginx.conf

COPY ./www/index.html /usr/share/nginx/html/index.html

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]