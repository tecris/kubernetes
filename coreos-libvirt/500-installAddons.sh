#!/bin/bash


kubectl create -f addons/kube-system.yaml

# dns addon
cd addons/dns && ./replace.sh && cd ../..
kubectl create -f addons/dns/skydns-rc.yaml
kubectl create -f addons/dns/skydns-svc.yaml
rm addons/dns/skydns-rc.yaml
rm addons/dns/skydns-svc.yaml
