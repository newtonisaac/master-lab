#!/bin/bash

echo Configuring knative...

# install knative
kubectl apply -f ./knative/serving-crds.yaml
kubectl apply -f ./knative/serving-core.yaml
kubectl apply -f ./knative/kourier.yaml
kubectl patch configmap/config-network --namespace knative-serving --type merge --patch '{\"data\":{\"ingress.class\":\"kourier.ingress.networking.knative.dev\"}}'

# config ingress dns to nip.io
kubectl patch configmap -n knative-serving config-domain -p '{\"data\": {\"127.0.0.1.nip.io\": \"\" }}'

kubectl --namespace kourier-system get service kourier
kubectl get pods -n knative-serving

