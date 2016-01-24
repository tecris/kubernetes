
VERSION=v1.1.4

wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-controller-manager &
wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-apiserver &
wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-scheduler &
wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kube-proxy &
wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kubelet &
wget https://storage.googleapis.com/kubernetes-release/release/$VERSION/bin/linux/amd64/kubectl &
