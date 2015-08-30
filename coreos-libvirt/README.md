## Kubernetes on CoreOS (virtualized on Ubuntu with libvirt)

 - Kubernetes cluster installed on CoreOS cluster
 - Kubernetes cluster: 1 master, multiple nodes
 - CoreOS cluster running with libvirt on Ubuntu 14.04
 - Ubuntu 14.04 installed on 2 physical machines
   - Kubernetes: v1.0.3
   - CoreOS: alpha 789.0.0
   - Ubuntu: 14.04

1. Ubuntu
 - 2 physical machines with Ubuntu 14.04
    * machine A - 192.168.1.72
    * machine B - 192.168.1.73
1. libvirt
 - Install

    ```
     $ sudo apt-get install dnsmasq ebtables qemu-kvm qemu virt-manager virt-viewer libvirt-bin
     $ sudo usermod -a -G libvirtd $USER`
    ```
 - Verify installation
   * `$ virsh list --all`
 - Modify subnet on 192.168.1.73, change to 192.168.123.*
   * `$ virsh net-edit default`
 - Change forward mode from nat(default mode) to route on both machines

    ```
      $ virsh net-edit default
      ...
      <forward mode='nat'/>
      becomes
      <forward mode='route'/>
    ```
 - Restart libvirt network

    ```
    $ virsh net-destroy default
    $ virsh net-start default
    ```
 - 192.168.1.72 should have libvirt subnet - 192.168.122.*
 - 192.168.1.73 should have libvirt subnet - 192.168.123.*

1. Add routes in the physical network (this is required as no other hosts know about the subnet created by virtual switch)
 - add routes that subnet 192.168.123 can reach 192.168.122 and vice-versa.

    ```
     $ sudo route add -net 192.168.122.0 netmask 255.255.255.0 gw 192.168.1.72
     $ sudo route add -net 192.168.123.0 netmask 255.255.255.0 gw 192.168.1.73
    ```
 - add routes that both subnet 192.168.12[2,3] can reach outside. Find gateway for machine A/B and add routes (good luck).

1. CoreOS
 - Download image

    ```
    $ mkdir -p /var/lib/libvirt/images/coreos
    $ cd /var/lib/libvirt/images/coreos
    $ wget http://alpha.release.core-os.net/amd64-usr/774.0.0/coreos_production_qemu_image.img.bz2
    $ bzip2 -d coreos_production_qemu_image.img.bz2
    ```
1. Kubernetes
 - Start master on 192.168.1.73

    ```
    $ cp deploy_master_coreos_libvirt.sh master_user_data  /var/lib/libvirt/images/coreos
    $ cd /var/lib/libvirt/images/coreos
    $ sudo ./deploy_master_coreos_libvirt.sh repo_server_ip
    # get kubernetes master ip address
    $ cat /var/lib/libvirt/dnsmasq/default.leases
    1440809945 52:54:00:d3:0f:b6 192.168.123.38 master ff:a5:fb:b3:45:00:02:00:00:ab:11:24:84:b6:7f:06:83:17:b9
    ```
 - [Kube-ui](https://github.com/kubernetes/kubernetes/tree/v1.0.3/cluster/addons/kube-ui)

    ```
    $ kubectl -s 192.168.123.38:8080 --namespace=kube-system create -f kube-ui/kube-ui-rc.yaml
    $ kubectl -s 192.168.123.38:8080 --namespace=kube-system create -f kube-ui/kube-ui-svc.yaml
    ```
 - Start 3 nodes on 192.168.1.73

    ```
    $ cp deploy_nodes_coreos_libvirt.sh node_user_data  /var/lib/libvirt/images/coreos
    $ cd /var/lib/libvirt/images/coreos
    $ sed -i -e 's/master_ip/192.168.123.38/g' node_user_data
    $ sudo ./deploy_nodes_coreos_libvirt.sh a 3 kube_master_ip repo_server_ip local_registry_op
    ```
 - Start 3 nodes on 192.168.1.72

    ```
    $ cp deploy_nodes_coreos_libvirt.sh node_user_data  /var/lib/libvirt/images/coreos
    $ cd /var/lib/libvirt/images/coreos
    $ sed -i -e 's/master_ip/192.168.123.38/g' node_user_data
    $ sudo ./deploy_nodes_coreos_libvirt.sh b 3 kube_master_ip repo_server_ip local_registry_op
    ```
 
1. Test kubernetes installation
 * UI: http://192.168.123.38:8080/ui
 
     ```
     $ kubectl -s 192.168.123.38:8080 get pods
     ```
 * Check nodes

     ```
     $ kubectl -s 192.168.123.38:8080 get nodes
     ```
 * Check pods
 
     ```
     $ kubectl -s 192.168.123.38:8080 get pods
     ```


References

[CoreOS with libvirt](https://coreos.com/os/docs/latest/booting-with-libvirt.html)

[Route example](http://www.thegeekstuff.com/2012/04/route-examples/)
