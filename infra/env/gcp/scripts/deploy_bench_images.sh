#!/bin/bash

echo Deploying services to knative...

path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Deploy benckmark containers
kubectl apply -f $path/knative/benchmark-services-knative.yaml


# kubectl get knative svc
kubectl get ksvc
