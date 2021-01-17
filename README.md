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

3. Enter in kind containel to control k8s
```
docker exec -it $(docker ps -aq -f name=dind-kind) bash
```

4. Hello world
```
open http://hello.default.127.0.0.1.nip.io/
```

Benchmarking
------------

1. Up data collector 
```
cd benchmark
docker-compose up -d influxdb grafana
```

2. Run test
```
docker-compose run k6 run scripts/ewoks.js
```


```
python3 -m pip install influxdb
```