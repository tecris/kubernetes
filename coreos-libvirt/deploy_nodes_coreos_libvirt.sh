#!/bin/bash -e

# https://coreos.com/os/docs/latest/booting-with-libvirt.html
# wget https://raw.githubusercontent.com/coreos/docs/master/os/deploy_coreos_libvirt.sh

usage() {
        echo "Usage: node_identifier number_of_coreos_nodes master_ip_address docker_registry_mirror_ip_address"
}

if [ "$1" == "" ]; then
        echo "Node identifier not specified"
        usage
        exit 1
fi

if [ "$2" == "" ]; then
        echo "Cluster size is empty"
        usage
        exit 1
fi

if ! [[ $2 =~ ^[0-9]+$ ]]; then
        echo "'$2' is not a number"
        usage
        exit 1
fi

if [ "$3" == "" ]; then
        echo "Master ip address not specified"
        usage
        exit 1
fi

if [ "$4" == "" ]; then
        echo "Private registry ip address not specified"
        usage
        exit 1
fi

LIBVIRT_PATH=/var/lib/libvirt/images/coreos
USER_DATA_TEMPLATE=$LIBVIRT_PATH/node.yaml
RAM=1024
CPUs=1

if [ ! -d $LIBVIRT_PATH ]; then
        mkdir -p $LIBVIRT_PATH || (echo "Can not create $LIBVIRT_PATH directory" && exit 1)
fi

if [ ! -f $USER_DATA_TEMPLATE ]; then
        echo "$USER_DATA_TEMPLATE template doesn't exist"
        exit 1
fi


for SEQ in $(seq 1 $2); do
        COREOS_HOSTNAME="node-$1$SEQ"

        if [ ! -d $LIBVIRT_PATH/$COREOS_HOSTNAME/openstack/latest ]; then
                mkdir -p $LIBVIRT_PATH/$COREOS_HOSTNAME/openstack/latest || (echo "Can not create $LIBVIRT_PATH/$COREOS_HOSTNAME/openstack/latest directory" && exit 1)
        fi

        if [ ! -f $LIBVIRT_PATH/coreos_production_qemu_image.img ]; then
                wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > $LIBVIRT_PATH/coreos_production_qemu_image.img
        fi

        if [ ! -f $LIBVIRT_PATH/$COREOS_HOSTNAME.qcow2 ]; then
                qemu-img create -f qcow2 -b $LIBVIRT_PATH/coreos_production_qemu_image.img $LIBVIRT_PATH/$COREOS_HOSTNAME.qcow2
        fi

        sed "s/<master-private-ip>/$3/g;s/registry_mirror/$4/g;s/DNS_DOMAIN/cluster.local/g;s/DNS_SERVER_IP/10.100.89.100/g;s/PUBLIC_KEY/$(sed 's:/:\\/:g' /home/$SUDO_USER/.ssh/id_rsa.pub)/" $USER_DATA_TEMPLATE > $LIBVIRT_PATH/$COREOS_HOSTNAME/openstack/latest/user_data

        virt-install --connect qemu:///system --import --name $COREOS_HOSTNAME --ram $RAM --vcpus $CPUs --os-type=linux --os-variant=virtio26 --disk path=$LIBVIRT_PATH/$COREOS_HOSTNAME.qcow2,format=qcow2,bus=virtio --filesystem $LIBVIRT_PATH/$COREOS_HOSTNAME/,config-2,type=mount,mode=squash --vnc --noautoconsole --network network=default,model=virtio,mac=52:54:00:2c:05:0$SEQ
done
