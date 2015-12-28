#/bin/bash

# static ip address for master
# http://serverfault.com/questions/627238/kvm-libvirt-how-to-configure-static-guest-ip-addresses-on-the-virtualisation-ho

virsh net-update default add ip-dhcp-host \
          "<host mac='52:54:00:2c:06:79' \
           name='master' ip='192.168.122.10' />" \
           --live --config
