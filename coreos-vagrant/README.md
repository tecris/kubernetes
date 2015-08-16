# Kubernetes cluster on Vagrant

Based on  [Kubernetes coreos vagrant cluster][1]


1. Prerequisites
 * Vagrant (tested with v1.7.2)
 * Virtual Box (tested with v4.3.26)
 * Download coreos vagrant box and add to vagrant
 ```
 $ wget -c http://alpha.release.core-os.net/amd64-usr/717.0.0/coreos_production_vagrant.box
 $ vagrant box add coreos-717.0.0 coreos_production_vagrant.box
 ```
 * Download kubernetes binaries
  ```
  $ wget -c https://storage.googleapis.com/kubernetes-release/release/v0.19.0/bin/linux/amd64/kube-apiserver
  $ wget -c https://storage.googleapis.com/kubernetes-release/release/v0.19.3/bin/linux/amd64/kube-controller-manager
  $ wget -c https://storage.googleapis.com/kubernetes-release/release/v0.19.3/bin/linux/amd64/kube-scheduler
  $ wget -c https://storage.googleapis.com/kubernetes-release/release/v0.19.3/bin/linux/amd64/kube-proxy
  $ wget -c https://storage.googleapis.com/kubernetes-release/release/v0.19.3/bin/linux/amd64/kubelet
  $ wget -c https://storage.googleapis.com/kubernetes-release/release/v0.19.3/bin/linux/amd64/kubectl
  ```
1. Start
 * ```$ NUM_INSTANCES=2 vagrant up```
2. Test installation
 * Check nodes
 ```
     $ kubectl -s 172.17.8.101:8080 get nodes
     NAME           LABELS                                STATUS
     172.17.8.102   kubernetes.io/hostname=172.17.8.102   Ready
     172.17.8.103   kubernetes.io/hostname=172.17.8.103   Ready
 ```
 * Check pods
 ```
     $ kubectl -s 172.17.8.101:8080 get pods
     NAME             READY     REASON    RESTARTS   AGE
     kube-dns-6o5cn   3/3       Running   0          50m
 ```
3. Run tomcat
 * Create single node cluster
 * Create replica controller
 ```
    $ kubectl -s 172.17.8.101:8080 create -f tomcat7-controller.json
 ```
 * Check replica controller created
 ```
   $ kubectl -s 172.17.8.101:8080 get rc tomcat7
     CONTROLLER   CONTAINER(S)   IMAGE(S)                    SELECTOR       REPLICAS
     tomcat7      tomcat7        healthlink.docker/tomcat7   name=tomcat7   1
 ```
 * Create service
 ```
    $ kubectl -s 172.17.8.101:8080 create -f tomcat7-service.yaml
 ```
 * Check service created:
    - cli: 
    ```
     $ kubectl -s 172.17.8.101:8080 get services tomcat7
       NAME      LABELS         SELECTOR       IP(S)          PORT(S)
      tomcat7   name=tomcat7   name=tomcat7   10.0.0.191     8080/TCP
    ```
    - in browser: ```10.0.0.191:8080```
 * Check pod
 ```
    $ kubectl -s 172.17.8.101:8080 get pods
 ```
 * Update cluster to 3 pods
 ```
    $ kubectl -s 172.17.8.101:8080 scale --replicas=3 rc tomcat7
 ```
 * Check number of pods
 ```
    $ kubectl -s 172.17.8.101:8080 get pods
 ```
4. Simple commands
  * Delete a pod
 ```
    $ kubectl -s 172.17.8.101:8080 delete pod tomcat7-e7hxk
 ```
  * Delete tomcat7 replica controller
 ```
    $ kubectl -s 172.17.8.101:8080 delete rc tomcat7
 ```
  * Delete tomcat7 service
 ```
    $ kubectl -s 172.17.8.101:8080 delete services tomcat7
 ```
  * Show all replica controllers
 ```
    $ kubectl -s 172.17.8.101:8080 get rc 
 ```

[1]:https://github.com/pires/kubernetes-vagrant-coreos-cluster
