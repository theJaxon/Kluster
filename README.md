# Kluster

![Vagrant](https://img.shields.io/badge/-Vagrant-1563FF?style=for-the-badge&logo=Vagrant&logoColor=white)
![K8s](https://img.shields.io/badge/-kubeadm-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-container%20runtime-2496ED?style=for-the-badge&logo=Docker)

![Ansible](https://img.shields.io/badge/Configured%20using-ansible-EE0000?style=for-the-badge&logo=ansible)
![Ingress](https://img.shields.io/badge/nginx-ingress%20controller-269539?style=for-the-badge&logo=Nginx)

![Locl-path-provisioner](https://img.shields.io/badge/Dynamic%20provisioning-local%20path%20provisioner-0075A8?style=for-the-badge&logo=Rancher)

Yet another k8s cluster using kubeadm

---

### About the project:

- This project deploys a kubernetes cluster using [Kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/) on top of Vagrant, all configuration is taken care of using Ansible
- Dynamic storage provisioning is done using **[local-path-provisioner](https://github.com/rancher/local-path-provisioner)** from Rancher
- LoadBalancer implementation is provided using **[MetalLB](https://metallb.universe.tf/)**
- For ingress, **[nginx-ingress-controller](https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal)** is used
- [Weave net CNI](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/#-installation) is used to provide [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Metrics server](https://github.com/kubernetes-sigs/metrics-server) for collecting resource metrics

---

### Cluster details:
- The cluster is configured as one master and 2 worker nodes as follows:

| Machine Name 	|     Address    	|         FQDN        	|
|:------------:	|:--------------:	|:-------------------:	|
|    master    	| 192.168.100.10 	|  master.example.com 	|
|    worker1   	| 192.168.100.11 	| worker1.example.com 	|
|    worker2   	| 192.168.100.12 	| worker2.example.com 	|

---
---

#### Making local-path the default storage class:
```bash
# 1- Enable DefaultStorageClass Admission controller 
vi /etc/kubernetes/manifests/kube-apiserver.yaml
- --enable-admission-plugins=NodeRestriction,DefaultStorageClass

#2- Patch the storage class created by local-path-provisioner
k patch sc local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```