#/bin/bash

# static ip address for master
# http://serverfault.com/questions/627238/kvm-libvirt-how-to-configure-static-guest-ip-addresses-on-the-virtualisation-ho
# http://wiki.libvirt.org/page/Networking#virsh_net-update

virsh net-update default add ip-dhcp-host \
          "<host mac='52:54:00:2c:06:79' \
           name='master' ip='192.168.122.10' />" \
           --live --config

virsh net-update default add ip-dhcp-host \
          "<host mac='52:54:00:2c:05:01' \
           name='node-01' ip='192.168.122.51' />" \
           --live --config

virsh net-update default add ip-dhcp-host \
          "<host mac='52:54:00:2c:05:02' \
           name='node-02' ip='192.168.122.52' />" \
           --live --config

virsh net-destroy default
virsh net-start default
