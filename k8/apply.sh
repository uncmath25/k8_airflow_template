#!/bin/bash
set -e

K8_TEMPLATES_DIR="k8"
REDIS_TEMPLATES_DIR="redis"
POSTGRES_TEMPLATES_DIR="postgres"
AIRFLOW_TEMPLATES_DIR=airflow

echo "Building redis..."
kubectl apply -f ${K8_TEMPLATES_DIR}/${REDIS_TEMPLATES_DIR}/deployment.yaml
kubectl apply -f ${K8_TEMPLATES_DIR}/${REDIS_TEMPLATES_DIR}/service.yaml

echo "Building postgres..."
kubectl apply -f ${K8_TEMPLATES_DIR}/${POSTGRES_TEMPLATES_DIR}/config.yaml
kubectl apply -f ${K8_TEMPLATES_DIR}/${POSTGRES_TEMPLATES_DIR}/persistent_volume.yaml
kubectl apply -f ${K8_TEMPLATES_DIR}/${POSTGRES_TEMPLATES_DIR}/persistent_volume_claim.yaml
kubectl apply -f ${K8_TEMPLATES_DIR}/${POSTGRES_TEMPLATES_DIR}/stateful_set.yaml
kubectl apply -f ${K8_TEMPLATES_DIR}/${POSTGRES_TEMPLATES_DIR}/service.yaml

echo "Building airflow..."
kubectl apply -f ${K8_TEMPLATES_DIR}/${AIRFLOW_TEMPLATES_DIR}/config.yaml
kubectl apply -f ${K8_TEMPLATES_DIR}/${AIRFLOW_TEMPLATES_DIR}/scheduler/deployment.yaml
kubectl apply -f ${K8_TEMPLATES_DIR}/${AIRFLOW_TEMPLATES_DIR}/scheduler/service.yaml
kubectl apply -f ${K8_TEMPLATES_DIR}/${AIRFLOW_TEMPLATES_DIR}/worker/deployment.yaml
