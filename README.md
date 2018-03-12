# gke-builder
Google Kubernetes Engine (GKE) image builder. A Debian based image for building and deploying Docker images from a CI environmnet (such as CircleCI). Based off [google/cloud-sdk:slim](https://hub.docker.com/r/google/cloud-sdk/).

Contains the following command-line tools:
  * [gcloud](https://cloud.google.com/sdk/gcloud/)
  * [docker](https://docs.docker.com/engine/reference/commandline/cli/)
  * [docker-compose](https://docs.docker.com/compose/reference/overview/)
  * [kubectl](https://kubernetes.io/docs/user-guide/kubectl-overview/)
  * [kompose](http://kompose.io/)
  * [kedge](http://kedgeproject.org/)

## Usage
gke-builder has been tested with CircleCI 2.0. The following CircleCI configuration shows building a Docker image and pushing it to the Google Container Registry.

This example assumes you have setup the following environment variables:
  * `GOOGLE_AUTH` - GCP service account JSON key
  * `GOOGLE_PROJECT_ID` - the ID of your GCP project
  * `GOOGLE_COMPUTE_ZONE` - which compute zone to use by default, e.g. us-central1-a
  * `GOOGLE_CLUSTER_NAME` - the cluster to which deployments will occur
  * `GOOGLE_GCR_HOST` - GCR hostname, e.g. us.gcr.io

For more configuration details read the following resources:
  * [CircleCI - Running Docker Commands](https://circleci.com/docs/2.0/building-docker-images/)
  * [CircleCI - Using Google Container Engine](https://circleci.com/docs/2.0/google-container-engine/)
  * [Gooogle Cloud Platform - Getting Started with Authentication](https://cloud.google.com/docs/authentication/getting-started)

Example `.circleci/config.yaml` config:
```yaml
version: 2
jobs:
  build:
    docker:
      - image: dtcristo/gke-builder:latest

    working_directory: ~/repo

    steps:
      - checkout
      - setup_remote_docker

      - run:
          name: Authenticate with Google Cloud
          command: |
            echo ${GOOGLE_AUTH} > ${HOME}/gcp-key.json
            gcloud auth activate-service-account --key-file ${HOME}/gcp-key.json
            gcloud --quiet config set project ${GOOGLE_PROJECT_ID}
            gcloud --quiet config set compute/zone ${GOOGLE_COMPUTE_ZONE}
            gcloud --quiet container clusters get-credentials ${GOOGLE_CLUSTER_NAME}

      - run:
          name: Pull latest image
          command: |
            IMAGE=${GOOGLE_GCR_HOST}/${GOOGLE_PROJECT_ID}/${CIRCLE_PROJECT_REPONAME}
            gcloud docker -- pull ${IMAGE}:latest

      - run:
          name: Build image
          command: |
            IMAGE=${GOOGLE_GCR_HOST}/${GOOGLE_PROJECT_ID}/${CIRCLE_PROJECT_REPONAME}
            TAG=$CIRCLE_BUILD_NUM
            docker build \
              --cache-from=${IMAGE}:latest \
              -t ${IMAGE}:${TAG} \
              -t ${IMAGE}:latest \
              .

      - run:
          name: Push image
          command: |
            IMAGE=${GOOGLE_GCR_HOST}/${GOOGLE_PROJECT_ID}/${CIRCLE_PROJECT_REPONAME}
            gcloud docker -- push ${IMAGE}
```
