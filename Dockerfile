# Based of slim Debian image
FROM google/cloud-sdk:slim

# Update sources
RUN apt-get update

# Install new packages
RUN apt-get install -y \
  gnupg2 \
  software-properties-common \
  kubectl

# Add gpg key and sources for Docker CE
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

# Update sources and do Docker CE install
RUN apt-get update && apt-get install -y docker-ce

# Upgrade existing packages
RUN apt-get upgrade -y

# Clean up after apt
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
