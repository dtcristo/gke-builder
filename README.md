# gke-builder
Google Container Engine (GKE) image builder. A Debian based image for building and deploying Docker images from a CI environmnet (such as CircleCI). Based off [google/cloud-sdk:slim](https://hub.docker.com/r/google/cloud-sdk/).

Contains the following command-line tools:
  * [gcloud](https://cloud.google.com/sdk/gcloud/)
  * [docker](https://docs.docker.com/engine/reference/commandline/cli/)
  * [docker-compose](https://docs.docker.com/compose/reference/overview/)
  * [kubectl](https://kubernetes.io/docs/user-guide/kubectl-overview/)
  * [kompose](http://kompose.io/)
