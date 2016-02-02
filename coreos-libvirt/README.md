## Kubernetes on CoreOS
This guide aims to provide full step-by-step instructions how to get from a raw ubuntu installation to a running kubernetes cluster.
<hr/>
[**Prerequisites**](#prerequisites)
 - [**Ubuntu**](#ubuntu-bare-necessities)
 - [**Libvirt**](#libvirt)
 - [**CoreOS**](#coreos)

[**Kubernetes**](#kubernetes)
<hr/>
### Overview
 - Guest OS: CoreOS
 - Virtualization: libvirt
 - Host OS: Ubuntu
 
| *Technology*  | *Version* |
| ------------- | ------------- |
| Kubernetes | v1.1.7|
| CoreOS | 935.0.0 - alpha channel|
| Ubuntu | 14.04|

### Prerequisites
#### Ubuntu bare necessities
 - 2 physical machines with Ubuntu
    * machine A - 192.168.1.72
    * machine B - 192.168.1.73

#### libvirt
 - Install
   * `$ ./010-installLibvirt.sh`
   *  logout & login
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
 - Configure for static ip address

    ` ./050-staticIpAddress.sh`
 - 192.168.1.72 should have libvirt subnet - 192.168.122.*
 - 192.168.1.73 should have libvirt subnet - 192.168.123.*

 - Add routes in the physical network (this is required as no other hosts know about the subnet created by virtual switch)
  * add routes that subnet 192.168.123 can reach 192.168.122 and vice-versa.

    ```
     $ sudo route add -net 192.168.122.0 netmask 255.255.255.0 gw 192.168.1.72
     $ sudo route add -net 192.168.123.0 netmask 255.255.255.0 gw 192.168.1.73
    ```
  * add routes that both subnet 192.168.12[2,3] can reach outside. Find gateway for machine A/B and add routes.
    - Example for 192.168.122

     ```
     Destination Network Address: 192.168.122.0
     Subnet Mask: 255.255.255.0
     Default Gateway: 192.168.1.68 (libvirt host)
     ```

#### CoreOS
 - Cloud config configuration adapted from [kubernets](https://github.com/kubernetes/kubernetes/tree/v1.1.7/docs/getting-started-guides/coreos/cloud-configs)
 - [Cluster architecture](https://coreos.com/os/docs/latest/cluster-architectures.html#easy-development/testing-cluster)


### Kubernetes
    
 - [Install and configure kubectl][1]
   *  `$ ./200-installKubectl.sh`
 - Start master on 192.168.1.72

    ```
    $ sudo mkdir -p /var/lib/libvirt/images/coreos && sudo cp deploy_master_coreos_libvirt.sh master.yaml  /var/lib/libvirt/images/coreos
    $ cd /var/lib/libvirt/images/coreos
    $ sudo ./deploy_master_coreos_libvirt.sh
    ```
 - Addons ([Kube-ui](https://github.com/kubernetes/kubernetes/tree/v1.1.7/cluster/addons/kube-ui) & [DNS](https://github.com/kubernetes/kubernetes/tree/v1.1.7/cluster/addons/dns))

    ```$ ./500-installAddons.sh```
    
 - Start 3 nodes on 192.168.1.72

    ```
    $ sudo cp deploy_nodes_coreos_libvirt.sh node.yaml  /var/lib/libvirt/images/coreos
    $ cd /var/lib/libvirt/images/coreos
    $ sudo ./deploy_nodes_coreos_libvirt.sh a 3 kube_master_ip registry_mirror_ip
    $ sudo ./deploy_nodes_coreos_libvirt.sh a 2 192.168.122.10 172.17.0.1
    ```
 - Start 3 nodes on 192.168.1.73

    ```
    $ sudo mkdir -p /var/lib/libvirt/images/coreos && sudo cp deploy_nodes_coreos_libvirt.sh node.yaml  /var/lib/libvirt/images/coreos
    $ cd /var/lib/libvirt/images/coreos
    $ sudo ./deploy_nodes_coreos_libvirt.sh b 3 kube_master_ip registry_mirror_ip
    ```

 - Test kubernetes installation
  * UI: http://192.168.122.10:8080/ui
  * CLI:
 
     ```
     $ kubectl get pods
     $ kubectl get nodes
     ```


References

[CoreOS with libvirt](https://coreos.com/os/docs/latest/booting-with-libvirt.html)

[Route example](http://www.thegeekstuff.com/2012/04/route-examples/)

[1]:https://coreos.com/kubernetes/docs/latest/configure-kubectl.html
