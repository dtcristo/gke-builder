# Based of slim Debian image
FROM google/cloud-sdk:slim

RUN apt-get update \
  && apt-get install -y kubectl software-properties-common \
  && apt-get upgrade -y \
  && curl -sSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
  && apt-get update \
  && apt-get install -y docker-ce \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && curl -sSL https://github.com/docker/compose/releases/download/1.19.0/docker-compose-Linux-x86_64 -o docker-compose \
  && chmod +x docker-compose \
  && mv docker-compose /usr/local/bin/docker-compose \
  && curl -sSL https://github.com/kubernetes/kompose/releases/download/v1.10.0/kompose-linux-amd64 -o kompose \
  && chmod +x kompose \
  && mv kompose /usr/local/bin/kompose \
  && curl -sSL https://github.com/kedgeproject/kedge/releases/download/v0.10.0/kedge-linux-amd64 -o kedge \
  && chmod +x kedge \
  && mv kedge /usr/local/bin/kedge
