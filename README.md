[Tomcat 8](#tomcat)

[Wildfly & MySQL](#widlfy-and-mysql)

[Kubectl commands](#varia-kubectl-commands)

#### Tomcat

1. Assumptions: 

 - [kubernetes installed](https://github.com/tecris/kubernetes/tree/v1.1.3-2/coreos-libvirt)
 - kubectl configured with kubernetes master
 - docker private [registry](https://github.com/tecris/docker/tree/v3.6.1/registry2) deployed
 - image blue.sky/tomcat:8.0.30 available (on private registry)

1. Deploy Tomcat 8 on kuberntes
 * Create replica controller & service

    ```
    $ kubectl -s 192.168.122.10:8080 create -f demo/tomcat/tomcat8-rc.yaml
    $ kubectl -s 192.168.122.10:8080 create -f demo/tomcat/tomcat8-svc.yaml
    ```
 http://192.168.122.51:30001


#### Widlfy and MySQL

 * Assumptions: 
  
  - [kubernetes installed](https://github.com/tecris/kubernetes/tree/v1.1.3-2/coreos-libvirt)
  - kubectl configured with kubernetes master
  - docker private [registry](https://github.com/tecris/docker/tree/v3.6.1/registry2) deployed
  - TODO: web and db images available on private registry

 * Add DNS to kubernetes

   ```
   # kubectl create -f addons/dns/skydns-rc.yaml
   # kubectl create -f addons/dns/skydns-svc.yaml
   ```
 * Add application

   ```
   # kubectl create -f demo/jee/planets-db-pod.yaml
   # kubectl create -f demo/jee/planets-db-svc.yaml
   # kubectl create -f demo/jee/planets-web-rc-v1.yaml
   # kubectl create -f demo/jee/planets-web-svc.yaml
   ```
   
 * Rolling update
 
   ```
   # kubectl scale --replicas=2 rc planets-web
   - Update pods of planets-web-v1 using new replication controller data in planets-web-rc-v2.yaml.
   # kubectl rolling-update planets-web-v1 -f demo/jee/planets-web-rc-v2.yaml
   ```
   http://192.168.122.51:30002/planet


#### Varia kubectl commands
 
   ```
    $ kubectl describe pod pod_name
    $ kubectl get rc
    $ kubectl describe rc replica_controller_name
    $ kubectl delete pod pod_name
    $ kubectl delete rc tomcat8
    $ kubectl delete svc tomcat8
    $ kubectl scale --replicas=3 rc tomcat8
   ```
