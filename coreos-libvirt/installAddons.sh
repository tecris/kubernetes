#!/bin/bash


kubectl create -f addons/kube-system.yaml

# ui addon
kubectl --namespace=kube-system create -f addons/kube-ui/kube-ui-rc.yaml
kubectl --namespace=kube-system create -f addons/kube-ui/kube-ui-svc.yaml

# dns addon
cd addons/dns && ./replace.sh && cd ../..
kubectl create -f addons/dns/skydns-rc.yaml
kubectl create -f addons/dns/skydns-svc.yaml
