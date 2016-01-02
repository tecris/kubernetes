#!/bin/bash


export DNS_REPLICAS=1;
export DNS_DOMAIN=cluster.local;
export DNS_SERVER_IP=10.100.89.100;
export KUBE_SERVER=192.168.122.10;

sed -e "s/{{ pillar\['dns_replicas'\] }}/$DNS_REPLICAS/g;s/{{ pillar\['dns_domain'\] }}/$DNS_DOMAIN/g;s/{kube_server_url}/$KUBE_SERVER/g;" skydns-rc.yaml.in > ./skydns-rc.yaml

sed -e "s/{{ pillar\['dns_server'\] }}/$DNS_SERVER_IP/g" skydns-svc.yaml.in > ./skydns-svc.yaml

