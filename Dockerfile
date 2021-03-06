FROM google/cloud-sdk:alpine

RUN apk add --no-cache docker \
  && gcloud components install kubectl \
  && curl -sSL https://github.com/docker/compose/releases/download/1.21.0/docker-compose-Linux-x86_64 -o docker-compose \
  && chmod +x docker-compose \
  && mv docker-compose /usr/local/bin/docker-compose \
  && curl -sSL https://github.com/kubernetes/kompose/releases/download/v1.11.0/kompose-linux-amd64 -o kompose \
  && chmod +x kompose \
  && mv kompose /usr/local/bin/kompose \
  && curl -sSL https://github.com/kedgeproject/kedge/releases/download/v0.11.0/kedge-linux-amd64 -o kedge \
  && chmod +x kedge \
  && mv kedge /usr/local/bin/kedge \
  && curl -sSL https://storage.googleapis.com/kubernetes-helm/helm-v2.8.2-linux-amd64.tar.gz -o helm.tar.gz \
  && tar -zxf helm.tar.gz \
  && mv linux-amd64/helm /usr/local/bin/helm \
  && rm -rf helm.tar.gz linux-amd64
