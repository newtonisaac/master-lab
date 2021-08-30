# DevOps Master - Thesis Experiemnt #

Requirements
------------
-	[Docker](https://docs.docker.com/engine/install/)
-	[Terraform](https://www.terraform.io/downloads.html) v0.14.3

1. Run terraform init and apply 
```
terraform init
terraform apply
```

2. Enter in kind containel to control k8s
```
docker exec -it $(docker ps -aq -f name=dind-kind) bash
```

3. Hello world
```
open http://hello.default.127.0.0.1.nip.io/
```

Benchmarking
------------

For build images and push to docker.hub/gcp/aws

```
docker login # username: engisaacnewton - password: ...

cd benchmark

yarn bp:csharp
yarn bp:go
yarn bp:java
yarn bp:node
yarn bp:php
yarn bp:python

# run to test 
yarn r:csharp
yarn r:go
yarn r:java
yarn r:node
yarn r:php
yarn r:python

# push to google
yarn bp:csharp:gcp
yarn bp:go:gcp
yarn bp:java:gcp
yarn bp:node:gcp
yarn bp:php:gcp
yarn bp:python:gcp


```


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



GCP
------------

1. Config

```
gcloud auth login
gcloud config set project PROJECT_ID
```
