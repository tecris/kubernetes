#!/bin/bash -e

# https://coreos.com/os/docs/latest/booting-with-libvirt.html
# https://github.com/coreos/docs/blob/master/os/deploy_coreos_libvirt.sh
# wget https://raw.githubusercontent.com/coreos/docs/master/os/deploy_coreos_libvirt.sh


LIBVIRT_PATH=/var/lib/libvirt/images/coreos
USER_DATA_TEMPLATE=$LIBVIRT_PATH/master.yaml
ETCD_DISCOVERY=$(curl -s "https://discovery.etcd.io/new?size=$1")
RAM=1024
CPUs=1

if [ ! -d $LIBVIRT_PATH ]; then
        mkdir -p $LIBVIRT_PATH || (echo "Can not create $LIBVIRT_PATH directory" && exit 1)
fi

if [ ! -f $USER_DATA_TEMPLATE ]; then
        echo "$USER_DATA_TEMPLATE template doesn't exist"
        exit 1
fi

COREOS_HOSTNAME="master"
COREOS_HOSTIP="192.168.122.10"


if [ ! -d $LIBVIRT_PATH/$COREOS_HOSTNAME/openstack/latest ]; then
        mkdir -p $LIBVIRT_PATH/$COREOS_HOSTNAME/openstack/latest || (echo "Can not create $LIBVIRT_PATH/$COREOS_HOSTNAME/openstack/latest directory" && exit 1)
fi

if [ ! -f $LIBVIRT_PATH/coreos_production_qemu_image.img ]; then
        wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > $LIBVIRT_PATH/coreos_production_qemu_image.img
fi

if [ ! -f $LIBVIRT_PATH/$COREOS_HOSTNAME.qcow2 ]; then
        qemu-img create -f qcow2 -b $LIBVIRT_PATH/coreos_production_qemu_image.img $LIBVIRT_PATH/$COREOS_HOSTNAME.qcow2
fi

sed "s/\$private_ipv4/$COREOS_HOSTIP/g;s/PUBLIC_KEY/$(sed 's:/:\\/:g' /home/$SUDO_USER/.ssh/id_rsa.pub)/" $LIBVIRT_PATH/master.yaml > $LIBVIRT_PATH/$COREOS_HOSTNAME/openstack/latest/user_data

virt-install --connect qemu:///system --import --name $COREOS_HOSTNAME --ram $RAM --vcpus $CPUs --os-type=linux --os-variant=virtio26 --disk path=$LIBVIRT_PATH/$COREOS_HOSTNAME.qcow2,format=qcow2,bus=virtio --filesystem $LIBVIRT_PATH/$COREOS_HOSTNAME/,config-2,type=mount,mode=squash --vnc --noautoconsole --network network=default,model=virtio,mac=52:54:00:2c:06:79
