FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    adminer \
    php \
    php-mysql && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/usr/share/adminer"]
