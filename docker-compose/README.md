# Kubernetes on docker (single node)

Based on  [Getting started][1] & [Kubernetes with docker][2]

1. Prerequisites
 * Nothing running on port 8080
 * Docker
 * Docker-compose
 * [Kubectl binary][3] (see [Releases][4])
  ```
   $ wget http://storage.googleapis.com/kubernetes-release/release/v0.18.2/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl
  $ chmod +x /usr/local/bin/kubectl
  $ kubectl version
  ```
  
1. Start
 * ```$ ./start.sh```
2. Test installation
 * Check nodes
 ```
     $ kubectl get nodes
     NAME        LABELS    STATUS
     127.0.0.1   <none>    Ready
 ```
[1]:https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/getting-started-guides/docker.md
[2]:http://sebgoa.blogspot.co.nz/2015/04/1-command-to-kubernetes-with-docker.html
[3]:http://storage.googleapis.com/kubernetes-release/release/v0.18.2/bin/linux/amd64/kubectl
[4]:https://github.com/GoogleCloudPlatform/kubernetes/releases
