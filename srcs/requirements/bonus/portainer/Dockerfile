
FROM debian:bookworm

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create data directory
RUN mkdir -p /var/lib/portainer

# Download and extract Portainer binary
RUN wget -O /usr/local/portainer/portainer-2.33.1-linux-amd64.tar.gz \
    https://github.com/portainer/portainer/releases/download/2.33.1/portainer-2.33.1-linux-amd64.tar.gz \
    && tar -xzf /usr/local/portainer/portainer-2.33.1-linux-amd64.tar.gz -C /usr/local/portainer/ \
    && rm /usr/local/portainer/portainer-2.33.1-linux-amd64.tar.gz \
    && chmod +x /usr/local/portainer/portainer

# Expose Portainer web interface port
EXPOSE 9000

# Run Portainer
CMD ["/usr/local/portainer/portainer", "--data", "/var/lib/portainer"]
