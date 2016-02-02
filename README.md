## Kubernetes on [CoreOS](https://coreos.com)

[**Full Step by Step Guide**](#full-step-by-step-guide)

[**Tomcat 8 Demo**](#tomcat)

[**Kubectl commands**](#varia-kubectl-commands)

### **Full Step by Step Guide**



#### **Tomcat**

1. Assumptions: 

 - [kubernetes installed](https://github.com/tecris/kubernetes/tree/v1.1.3-2/coreos-libvirt)
 - kubectl configured with kubernetes master

1. Deploy [Tomcat 8](https://hub.docker.com/_/tomcat) on kuberntes
 * Create replica controller & service

    ```
    $ kubectl create -f demo/tomcat8-rc.yaml
    $ kubectl create -f demo/tomcat8-svc.yaml
    ```
 http://192.168.122.51:30001


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
