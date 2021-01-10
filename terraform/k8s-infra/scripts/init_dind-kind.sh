#!/bin/bash

kind_id=$1
alias dexec='docker exec ${kind_id} /bin/bash -c'
istioctl="/istio-1.8.1/bin/istioctl"

# init cluster
dexec "kind delete cluster"
dexec "kind create cluster --config ./kind-config.yaml"
dexec "kubectl cluster-info --context kind-kind"

echo Configuring knative...
# install istio using operator
dexec "$istioctl install -f /k8s_configs/istio-operator.yaml -y"

# install knative
dexec "kubectl create namespace knative-serving"
dexec "kubectl apply --filename https://github.com/knative/serving/releases/download/v0.19.0/serving-crds.yaml"
dexec "kubectl apply --filename https://github.com/knative/serving/releases/download/v0.19.0/serving-core.yaml"
dexec "kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.19.0/release.yaml"

# dexec "kubectl --namespace istio-system get service istio-ingressgateway"

# config ingress dns to nip.io
dexec "kubectl patch configmap -n knative-serving config-domain -p '{\"data\": {\"127.0.0.1.nip.io\": \"\" }}'"

# enable istio sidecar injection for the default namespace and deploy Knative "hello world" service in it
dexec "kubectl label namespace default istio-injection=enabled"

# Deploy hello world
dexec "kubectl apply -f /k8s_configs/hello-world-knative.yaml"

# kubectl get knative svc
dexec "kubectl get ksvc"