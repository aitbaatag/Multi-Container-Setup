FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl iputils-ping && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# generate self-signed certificate
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout etc/ssl/private/nginx.key \
    -out etc/ssl/certs/nginx.crt \
    -subj "/C=MA/ST=BEG/L=1337/O=42/CN=kait-baa.42.fr"


COPY /conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
