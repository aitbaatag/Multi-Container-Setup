FROM debain:bookworm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vsftpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY conf/proftpd.conf /etc/proftpd/proftpd.conf
