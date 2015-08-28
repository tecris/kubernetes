# Kubernetes - basic commands

1. Test kubernetes installation
 * Check nodes

     ```
     $ kubectl -s 172.17.8.101:8080 get nodes
     ```
 * Check pods
 
     ```
     $ kubectl -s 172.17.8.101:8080 get pods
     ```
1. Deploy tomcat8 on kuberntes
 * Create replica controller

    ```
    $ kubectl -s 172.17.8.101:8080 create -f tomcat8-rc.yaml
    # check replica controller created
    $ kubectl -s 172.17.8.101:8080 get rc tomcat8
    ```
 * Create service
 
    ```
    $ kubectl -s 172.17.8.101:8080 create -f tomcat8-svc.yaml
    # check service created
    $ kubectl -s 172.17.8.101:8080 get svc tomcat8
    ```
 * Check pod
 
    ```
    $ kubectl -s 172.17.8.101:8080 get pods
    ```
 * Tomcat home page: ```172.17.8.101:30001```
 * Update/Scale cluster to 3 pods
 
    ```
    $ kubectl -s 172.17.8.101:8080 scale --replicas=3 rc tomcat8
    # check number of pods
    $ kubectl -s 172.17.8.101:8080 get pods
    ```
1. Various commands
  * Delete a pod
 
    ```
    $ kubectl -s 172.17.8.101:8080 delete pod tomcat8-e7hxk
    ```
  * Delete tomcat8 replica controller
 
    ```
    $ kubectl -s 172.17.8.101:8080 delete rc tomcat8
    ```
  * Delete tomcat8 service
 
    ```
    $ kubectl -s 172.17.8.101:8080 delete services tomcat8
    ```
  * Show all replica controllers
 
    ```
    $ kubectl -s 172.17.8.101:8080 get rc 
    ```
