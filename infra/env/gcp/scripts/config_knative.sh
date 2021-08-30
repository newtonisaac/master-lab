#!/bin/bash

echo Configuring knative...

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cat $SCRIPTPATH/../kubeconfig

project=$1
region=$2
cluster_name=$3
zone=$4

gcloud container clusters get-credentials $cluster_name --region $region --project $project

path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# install knative
kubectl apply -f $path/knative/serving-crds.yaml 
kubectl apply -f $path/knative/serving-core.yaml 
kubectl apply -f $path/knative/kourier.yaml 
kubectl patch configmap/config-network --namespace knative-serving --type merge --patch "{\"data\":{\"ingress.class\":\"kourier.ingress.networking.knative.dev\"}}" 

echo Looking fro internal node ip of zone $zone
internal_node_ip=$(kubectl get nodes -o=json | jq -r ".items[] | select(.spec.providerID | contains (\"$zone\")) | .status.addresses[]  | select(.type == \"InternalIP\")  | .address")
# config ingress dns to nip.io

echo Internal node ip of zone $zone = $internal_node_ip
kubectl patch configmap -n knative-serving config-domain -p "{\"data\": {\"$internal_node_ip.nip.io\": \"\" }}" 

kubectl --namespace kourier-system get service kourier 
kubectl get pods -n knative-serving 

