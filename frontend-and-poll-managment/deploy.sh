#!/bin/bash

# Apply the ConfigMap
echo "Applying ConfigMap..."
kubectl apply -f init-configmap.yml

# Apply Backend Deployment and Service
echo "Applying Backend Deployment..."
kubectl apply -f backend-deployment.yml
echo "Applying Backend Service..."
kubectl apply -f backend-service.yml

# Apply Frontend Deployment and Service
echo "Applying Frontend Deployment..."
kubectl apply -f frontend-deployment.yml
echo "Applying Frontend Service..."
kubectl apply -f frontend-service.yml

# Apply Postgres Deployment and Service
echo "Applying Postgres Deployment..."
kubectl apply -f postgres-deployment.yml
echo "Applying Postgres Service..."
kubectl apply -f postgres-service.yml

# Wait for all pods to be in Running state
echo "Waiting for all pods to be in Running state..."
while [[ $(kubectl get pods --no-headers | grep -v Running | wc -l) -ne 0 ]]; do
    echo "Waiting for pods to be ready..."
    sleep 5
done

# Port forward the frontend service
echo "Port forwarding frontend service..."
kubectl port-forward svc/frontend 8080:8080

echo "Deployment and port forwarding complete."