#!/bin/bash

echo Deploying services to knative...

# Deploy benckmark containers
kubectl apply -f ./knative/benchmark-services-knative.yaml


# kubectl get knative svc
kubectl get ksvc
