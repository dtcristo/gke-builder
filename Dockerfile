# Based of slim Debian image
FROM google/cloud-sdk:slim

# Update sources
RUN apt-get update

# Install kubectl
RUN apt-get install -y kubectl

# Upgrade existing packages
RUN apt-get upgrade -y

# Clean up after apt
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install docker-compose
RUN curl -sSL https://github.com/docker/compose/releases/download/1.19.0/docker-compose-Linux-x86_64 -o docker-compose \
  && chmod +x docker-compose \
  && mv docker-compose /usr/local/bin/docker-compose

# Install kompose
RUN curl -sSL https://github.com/kubernetes/kompose/releases/download/v1.10.0/kompose-linux-amd64 -o kompose \
  && chmod +x kompose \
  && mv kompose /usr/local/bin/kompose

# Install kedge
RUN curl -sSL https://github.com/kedgeproject/kedge/releases/download/v0.10.0/kedge-linux-amd64 -o kedge \
  && chmod +x kedge \
  && mv kedge /usr/local/bin/kedge
