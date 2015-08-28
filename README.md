# Kubernetes - basic commands

1. Test installation
 * Check nodes

     ```
     $ kubectl -s 172.17.8.101:8080 get nodes
     ```
 * Check pods
 
     ```
     $ kubectl -s 172.17.8.101:8080 get pods
     ```
1. Run tomcat
 * Create single node cluster
 * Create replica controller

    ```
    $ kubectl -s 172.17.8.101:8080 create -f tomcat8-rc.yaml
    ```
 * Check replica controller created

    ```
    $ kubectl -s 172.17.8.101:8080 get rc tomcat8
    ```
 * Create service
 
    ```
    $ kubectl -s 172.17.8.101:8080 create -f tomcat8-svc.yaml
    ```
 * Check service created:
    - cli: 
    
      ```
      $ kubectl -s 172.17.8.101:8080 get svc tomcat8
      NAME      LABELS         SELECTOR       IP(S)          PORT(S)
      tomcat8   name=tomcat8   name=tomcat8   10.0.0.191     8080/TCP
      ```
    - in browser: ```172.17.8.101:30001```
 * Check pod
 
    ```
    $ kubectl -s 172.17.8.101:8080 get pods
    ```
 * Update/Scale cluster to 3 pods
 
    ```
    $ kubectl -s 172.17.8.101:8080 scale --replicas=3 rc tomcat8
    ```
 * Check number of pods
 
    ```
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
