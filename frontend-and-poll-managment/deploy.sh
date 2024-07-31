#!/bin/bash

# Apply the ConfigMap
echo "Applying ConfigMap..."
kubectl apply -f init-configmap.yml

# Apply API Gateway Deployment and Service
echo "Applying API gateway Deployment..."
kubectl apply -f api-gateway-deployment.yml
echo "Applying API gateway Service..."
kubectl apply -f api-gateway-service.yml

# Apply Poll Manager Deployment and Service
echo "Applying Poll Manager Deployment..."
kubectl apply -f poll-manager-deployment.yml
echo "Applying Poll Manager Service..."
kubectl apply -f poll-manager-service.yml

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

# Apply console deployment
echo Applying Console Deployment...
kubectl apply -f console-deployment.yml

# Wait for all pods to be in Running state
echo "Waiting for all pods to be in Running state..."
while [[ $(kubectl get pods --no-headers | grep -v Running | wc -l) -ne 0 ]]; do
    echo "Waiting for pods to be ready..."
    sleep 5
done

# Port forward the frontend service
echo "Port forwarding frontend service..."
kubectl port-forward svc/frontend 8080:80
# kubectl port-forward svc/api-gateway 8081:8081

echo "Deployment and port forwarding complete."