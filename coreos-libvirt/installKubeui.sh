#!/bin/bash

KUBERNETES_VERSION=v1.1.7

kubectl create -f addons/kube-system.yaml
kubectl --namespace=kube-system create -f addons/kube-ui/kube-ui-rc.yaml
kubectl --namespace=kube-system create -f addons/kube-ui/kube-ui-svc.yaml
