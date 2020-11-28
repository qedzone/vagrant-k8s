#!/usr/bin/env bash
# Install registry-cred operator for dockerhub registry secrets

if [ "$DOCKER_USER" == "" ]; then 
    read -p "Enter your dockerhub username:" DOCKER_USER
fi 

if [ "$DOCKER_PW" == "" ]; then 
    read -p "Enter your dockerhub password:" DOCKER_PW
fi 

kubectl create secret docker-registry docker-registry-registrycreds \
  --namespace kube-system \
  --docker-username=$DOCKER_USER \
  --docker-password=$DOCKER_PW \
  --dry-run=client \
  -o yaml | kubectl apply -f -

kubectl apply -f /src/manifests/registry-creds/manifest.yaml
kubectl apply -f /src/manifests/registry-creds/cluster-pull-secret.yaml