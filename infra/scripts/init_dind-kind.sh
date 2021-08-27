#!/bin/bash

kind_id=$1
alias dexec='docker exec ${kind_id} /bin/bash -c'
#istioctl="/istio-1.9.5/bin/istioctl"
knative_version="v0.25.0"

# init cluster
dexec "kind delete cluster"
dexec "kind create cluster --config ./kind-config.yaml"
dexec "kubectl cluster-info --context kind-kind"

echo Configuring knative...

sleep 60s  # waiting k6s init 

# install knative
dexec "kubectl apply -f https://github.com/knative/serving/releases/download/$knative_version/serving-crds.yaml"
dexec "kubectl apply -f https://github.com/knative/serving/releases/download/$knative_version/serving-core.yaml"

# instaling kourier
dexec "kubectl apply --filename ./k8s_configs/kourier_0-25-0.yaml"
dexec "kubectl patch configmap/config-network --namespace knative-serving --type merge --patch '{\"data\":{\"ingress.class\":\"kourier.ingress.networking.knative.dev\"}}'"
# config ingress dns to nip.io
dexec "kubectl patch configmap -n knative-serving config-domain -p '{\"data\": {\"127.0.0.1.nip.io\": \"\" }}'"

sleep 30s  # waiting componets init 

dexec "kubectl --namespace kourier-system get service kourier"
dexec "kubectl get pods -n knative-serving"


# ------  Install Hello World Container ------------------------------------------------------------------------------------

sleep 5s  # waiting componets init 

# Deploy hello world
dexec "kubectl apply -f /k8s_configs/hello-world-knative.yaml"

# Deploy benckmark containers
dexec "kubectl apply -f /k8s_configs/benchmark-services-knative.yaml"

#sleep 30s

# kubectl get knative svc
#dexec "kubectl get ksvc"

# ------  Install monitoring: EFK + Prometeus ------------------------------------------------------------------------------------

# monitoring_version="v0.18.3"
# dexec "kubectl apply --filename https://github.com/knative/serving/releases/download/$monitoring_version/monitoring.yaml"

# dexec "kubectl label nodes --all beta.kubernetes.io/fluentd-ds-ready='true'"

# dexec "kubectl get pods --namespace knative-monitoring --watch"
# dexec "kubectl get daemonset fluentd-ds --namespace knative-monitoring --watch"

# Deploy hello world
# dexec "kubectl apply -f /k8s_configs/hello-world-knative.yaml"

# kubectl get knative svc
# dexec "kubectl get ksvc"
