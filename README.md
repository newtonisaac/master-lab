# DevOps Master - Thesis Experiemnt #

Requirements
------------
-	[Docker](https://docs.docker.com/engine/install/)
-	[Terraform](https://www.terraform.io/downloads.html) v0.14.3

1. Configuring a docker daemon tcp connection to enable terraform provider 
```
sudo systemctl stop docker
sudo dockerd -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock
```
Obs.: Do not close the terminal and after lab do "sudo systemctl start docker"

2. Run terraform init and apply 
```
terraform init
terraform apply
```