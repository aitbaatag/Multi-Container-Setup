
FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    adminer \
    php \
    php-mysql && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3000

CMD ["php", "-S", "0.0.0.0:3000", "-t", "/usr/share/adminer/"]
