#!/bin/bash
set -e

AIRFLOW_IMAGE_NAME="uncmath25/k8-airflow-template"

eval $(minikube docker-env)

docker pull redis:3.2.7
docker pull postgres:9.6
docker build -t ${AIRFLOW_IMAGE_NAME} .

eval $(minikube docker-env -u)
