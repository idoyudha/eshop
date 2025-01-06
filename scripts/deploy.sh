#!/bin/bash

# Check if namespace exists, if not create it
if ! kubectl get namespace eshop &> /dev/null; then
    echo "Creating namespace: eshop"
    kubectl create namespace eshop
fi

# Create secrets first
echo "Creating secrets..."
make create-secrets

# Deploy PersistentVolumeClaims
echo "Deploying PersistentVolumeClaims..."
for pvc in k8s/*persistentvolumeclaim.yaml; do
    echo "Applying $pvc"
    kubectl apply -f "$pvc" -n eshop
done

# Deploy resources
echo "Deploying ConfigMaps..."
for configmap in k8s/*configmap.yaml; do
    echo "Applying $configmap"
    kubectl apply -f "$configmap" -n eshop
done

# Wait for ConfigMaps to be ready
sleep 2

echo "Deploying Services..."
for service in k8s/*service.yaml; do
    echo "Applying $service"
    kubectl apply -f "$service" -n eshop
done

echo "Deploying Deployments..."
for deployment in k8s/*deployment.yaml; do
    echo "Applying $deployment"
    kubectl apply -f "$deployment" -n eshop
done

echo "Checking deployment status..."
kubectl get pods -n eshop