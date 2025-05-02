FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    wget \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html

# Install WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress /var/www/html

#  gave www-data access to the wordpress folder
# not use root user because it is not secure
RUN chown -R www-data:www-data /var/www/html

# Stores PHP-FPM’s PID and (optionally) socket
RUN mkdir -p /run/php

# Configure PHP-FPM
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000
CMD ["php-fpm7.4", "-F"]
