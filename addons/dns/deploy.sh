#!/bin/bash

kubectl -s 192.168.122.10:8080 --namespace=kube-system create -f ./skydns-rc.yaml

kubectl -s 192.168.122.10:8080 --namespace=kube-system create -f ./skydns-svc.yaml
