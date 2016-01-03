### [Tomcat 8](#tomcat)
### [Wildfly & MySQL](#widlfy-and-mysql)

#### Tomcat

1. Assumptions: 

 - kubeclt configured with kubernets master
 - docker private [registry](https://github.com/tecris/docker/tree/v3.6.1/registry2) deployed
 - image blue.sky/tomcat:8.0.30 available

1. Deploy Tomcat 8 on kuberntes
 * Create replica controller & service

    ```
    $ kubectl -s 192.168.122.10:8080 create -f demo/tomcat/tomcat8-rc.yaml
    $ kubectl -s 192.168.122.10:8080 create -f demo/tomcat/tomcat8-svc.yaml
    ```
 http://192.168.122.51:30001

1. Varia kubectl commands
 
    ```
    $ kubectl -s 192.168.122.10:8080 describe pod pod_name
    $ kubectl -s 192.168.122.10:8080 get rc
    $ kubectl -s 192.168.122.10:8080 describe rc replica_controller_name
    $ kubectl -s 192.168.122.10:8080 delete pod pod_name
    $ kubectl -s 192.168.122.10:8080 delete rc tomcat8
    $ kubectl -s 192.168.122.10:8080 delete svc tomcat8
    $ kubectl -s 192.168.122.10:8080 scale --replicas=3 rc tomcat8
    ```


### Widlfy and MySQL

 * Add DNS to kubernetes

   ```
   # kubectl create -f addons/dns/skydns-rc.yaml
   # kubectl create -f addons/dns/skydns-svc.yaml
   ```
 * Add application

   ```
   # kubectl create -f demo/jee/planets-db-pod.yaml
   # kubectl create -f demo/jee/planets-db-svc.yaml
   # kubectl create -f demo/jee/planets-web-rc.yaml
   # kubectl create -f demo/jee/planets-web-svc.yaml
   ```
   
   http://192.168.122.51:30002/planet
