FROM debian:12


RUN apt-get  update -y && apt-get upgrade -y


RUN apt-get install -y curl && rm -rf /var/lib/apt-get/lists/*

RUN curl -L https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 -o cadvisor; chmod +x cadvisor

EXPOSE 8080

CMD ["./cadvisor", "--logtostderr", "--port=8080"]
