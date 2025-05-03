FROM debian:bullseye-slim

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf etc/mysql/mariadb.conf.d/
COPY conf/init.sql /etc/mysql/
RUN mkdir -p /var/run/mysqld # create the directory for the socket
EXPOSE 3306
CMD ["mysqld"]
