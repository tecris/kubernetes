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
    $ kubectl -s 172.17.8.101:8080 create -f tomcat7-controller.json
    ```
 * Check replica controller created

    ```
    $ kubectl -s 172.17.8.101:8080 get rc tomcat7
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
 * Update/Scale cluster to 3 pods
 
    ```
    $ kubectl -s 172.17.8.101:8080 scale --replicas=3 rc tomcat7
    ```
 * Check number of pods
 
    ```
    $ kubectl -s 172.17.8.101:8080 get pods
    ```
1. Various commands
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
