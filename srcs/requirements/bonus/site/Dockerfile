
FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY /site/. /var/www/html
COPY /conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
