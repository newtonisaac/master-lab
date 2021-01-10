# DevOps Master - Thesis Experiemnt #

Requirements
------------
-	[Docker](https://docs.docker.com/engine/install/)
-	[Ansible](https://docs.ansible.com/ansible/latest/installation_guide/)
-	[Terraform](https://www.terraform.io/downloads.html) v0.14.3
-	[kind](https://kind.sigs.k8s.io/) v1.17.4
-   [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) v1.17.4


1. Configuring a docker daemon tcp connection to enable terraform provider 
```
sudo systemctl stop docker
sudo dockerd -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock
```
Obs.: Do not close the terminal and after lab do "sudo systemctl start docker"