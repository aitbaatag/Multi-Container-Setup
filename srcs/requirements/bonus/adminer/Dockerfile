
FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    php \
    php-mysql \
    wget \
    && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3000

# Download adminer
RUN mkdir -p /usr/share/adminer
RUN wget "https://www.adminer.org/latest.php" -O /usr/share/adminer/adminer.php
RUN chown www-data:www-data /usr/share/adminer/adminer.php
RUN chmod 755 /usr/share/adminer

CMD ["php", "-S", "0.0.0.0:3000", "-t", "/usr/share/adminer", "/usr/share/adminer/adminer.php"]
