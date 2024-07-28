@echo off
setlocal

echo Applying ConfigMap...
kubectl apply -f init-configmap.yml

echo Applying Backend Deployment...
kubectl apply -f backend-deployment.yml
echo Applying Backend Service...
kubectl apply -f backend-service.yml

echo Applying Frontend Deployment...
kubectl apply -f frontend-deployment.yml
echo Applying Frontend Service...
kubectl apply -f frontend-service.yml

echo Applying Postgres Deployment...
kubectl apply -f postgres-deployment.yml
echo Applying Postgres Service...
kubectl apply -f postgres-service.yml

echo Waiting for all pods to be in Running state...
:wait_pods
for /f "tokens=*" %%i in ('kubectl get pods --no-headers ^| findstr /v "Running"') do (
    echo Waiting for pods to be ready...
    timeout /t 5 >nul
    goto wait_pods
)

echo Port forwarding frontend service...
start "" cmd /c "kubectl port-forward svc/frontend 8080:8080"

echo Deployment and port forwarding complete.
endlocal