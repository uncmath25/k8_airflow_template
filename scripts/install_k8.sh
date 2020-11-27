#!/bin/bash
set -e

echo "Installing kubectl..."
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl \
 && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
 && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list \
 && sudo apt-get update \
 && sudo apt-get install -y kubectl

echo "Installing minikube..."
wget https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb \
 && sudo dpkg -i minikube_latest_amd64.deb \
 && rm minikube_latest_amd64.deb

echo "Ensuring that kubectl and minikube are installed..."
kubectl version
minikube version
