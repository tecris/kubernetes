# Tomcat 8 on Kubernetes

1. Assumptions: 

 - kubernetes master ip: 192.168.123.38
 - docker registry running & image docker.nuc:5000/tomcat8 available

1. Deploy Tomcat 8 on kuberntes
 * Create replica controller

    ```
    $ kubectl -s 192.168.123.38:8080 create -f tomcat8-rc.yaml
    # check replica controller created
    $ kubectl -s 192.168.123.38:8080 get rc tomcat8
    ```
 * Create service
 
    ```
    $ kubectl -s 192.168.123.38:8080 create -f tomcat8-svc.yaml
    # check service created
    $ kubectl -s 192.168.123.38:8080 get svc tomcat8
    ```
 * Check pod
 
    ```
    $ kubectl -s 192.168.123.38:8080 get pods
    ```
 * Tomcat home page: ```192.168.123.38:30001```
 * Scale cluster to 3 pods
 
    ```
    $ kubectl -s 192.168.123.38:8080 scale --replicas=3 rc tomcat8
    # check number of pods
    $ kubectl -s 192.168.123.38:8080 get pods
    ```
1. Various commands
  * Delete a pod
 
    ```
    $ kubectl -s 192.168.123.38:8080 delete pod tomcat8-e7hxk
    ```
  * Delete tomcat8 replica controller
 
    ```
    $ kubectl -s 192.168.123.38:8080 delete rc tomcat8
    ```
  * Delete tomcat8 service
 
    ```
    $ kubectl -s 192.168.123.38:8080 delete services tomcat8
    ```
  * Show all replica controllers
 
    ```
    $ kubectl -s 192.168.123.38:8080 get rc 
    ```
