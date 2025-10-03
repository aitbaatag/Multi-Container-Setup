
FROM debian:bookworm


# Install dependencies
RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Portainer version
ENV PORTAINER_VERSION=2.28.3

# Download Portainer binary
RUN curl -L https://github.com/portainer/portainer/releases/download/${PORTAINER_VERSION}/portainer-${PORTAINER_VERSION}-linux-amd64 \
    -o /usr/local/bin/portainer && \
    chmod +x /usr/local/bin/portainer

# Expose Portainer UI port
EXPOSE 9000

# Run Portainer
CMD ["/usr/local/bin/portainer"]
