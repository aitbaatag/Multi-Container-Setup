FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y vsftpd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY /tools/script.sh ./script.sh
RUN chmod +x script.sh

EXPOSE 21
CMD ["./script.sh"]
