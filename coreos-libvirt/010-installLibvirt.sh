#!/bin/bash

sudo apt-get install -y dnsmasq ebtables qemu-kvm qemu virt-manager virt-viewer libvirt-bin
sudo usermod -a -G libvirtd $USER
