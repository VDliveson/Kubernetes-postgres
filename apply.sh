#!/bin/bash

# Check if the namespace argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

NAMESPACE=$1

#Create the kubeflow pipeline namespace

# env/platform-agnostic-pns hasn't been publically released, so you will install it from master
export PIPELINE_VERSION=2.0.5
kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
kubectl wait --for condition=established --timeout=60s crd/applications.app.k8s.io
kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/env/platform-agnostic-pns?ref=$PIPELINE_VERSION"


# Apply Kubernetes manifests with the specified namespace
kubectl apply -f configmap/postgres-configmap.yaml --namespace=$NAMESPACE
kubectl apply -f secret/postgres-secret.yaml --namespace=$NAMESPACE
kubectl apply -f volume/psql-pv.yaml --namespace=$NAMESPACE
kubectl apply -f volume-claim/psql-claim.yaml --namespace=$NAMESPACE
kubectl apply -f deployment/ps-deployment.yaml --namespace=$NAMESPACE
kubectl apply -f deployment/gorm-test-job.yaml --namespace=$NAMESPACE
kubectl apply -f service/ps-service.yaml --namespace=$NAMESPACE

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

kubectl apply -f dashboard/dashboard-adminuser.yaml && kubectl apply -f dashboard/cluster-role-binding.yaml

kubectl -n kubernetes-dashboard create token admin-user > token.txt