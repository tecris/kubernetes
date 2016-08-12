#!/bin/bash

# https://coreos.com/kubernetes/docs/latest/configure-kubectl.html

KUBERNETES_VERSION=v1.3.4

wget https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin

# configuration
kubectl config set-cluster default-cluster --server=http://192.168.122.10:8080
kubectl config set-context default-system --cluster=default-cluster
kubectl config use-context default-system
