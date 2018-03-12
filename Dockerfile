FROM google/cloud-sdk:alpine

RUN apk add --no-cache docker \
  && gcloud components install kubectl \
  && curl -sSL https://github.com/docker/compose/releases/download/1.19.0/docker-compose-Linux-x86_64 -o docker-compose \
  && chmod +x docker-compose \
  && mv docker-compose /usr/local/bin/docker-compose \
  && curl -sSL https://github.com/kubernetes/kompose/releases/download/v1.10.0/kompose-linux-amd64 -o kompose \
  && chmod +x kompose \
  && mv kompose /usr/local/bin/kompose \
  && curl -sSL https://github.com/kedgeproject/kedge/releases/download/v0.10.0/kedge-linux-amd64 -o kedge \
  && chmod +x kedge \
  && mv kedge /usr/local/bin/kedge
