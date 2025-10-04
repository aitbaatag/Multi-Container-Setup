
FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install Portainer
RUN mkdir -p /var/lib/portainer

# Latest version 2.30.0 as per Portainer documentation
ENV PORTAINER_VERSION=2.30.0
RUN wget https://github.com/portainer/portainer/releases/download/${PORTAINER_VERSION}/portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz \
    && tar -xzf portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz -C /usr/local \
    && rm portainer-${PORTAINER_VERSION}-linux-amd64.tar.gz

WORKDIR /usr/local/portainer

# Expose the Portainer web interface port
EXPOSE 9443

# Start Portainer with the data directory and force Docker socket connection
CMD ["/usr/local/portainer/portainer", "--data", "/var/lib/portainer"]
