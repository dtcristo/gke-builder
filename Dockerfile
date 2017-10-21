# Based of slim Debian image
FROM google/cloud-sdk:slim

# Update sources
RUN apt-get update

# Install new packages
RUN apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

# Add gpg key and sources for Docker CE
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

# Update sources
RUN apt-get update

# Do Docker CE install
RUN apt-get install -y docker-ce

# Clean up after apt
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install requried gcloud components
RUN gcloud components install \
  docker-credential-gcr \
  kubectl
