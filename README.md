# Manifests

This repository contains Kubernetes configurations for deployment of all Sympoll's apps and infrastructure. These configurations are tailored for deployment in Minikube.

## Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/docs/start/) installed
- [Kubectl](https://kubernetes.io/docs/tasks/tools/) installed
- [Helm](https://helm.sh/docs/intro/install/) (optional, for managing Ingress controllers)

## Getting Started

### Start Minikube

1. Start Minikube with the desired Kubernetes version:
    ```sh
    minikube start --kubernetes-version=v1.26.0
    ```

2. Enable the Ingress addon:
    ```sh
    minikube addons enable ingress
    ```

3. Start the Minikube tunnel to expose the Ingress service:
    ```sh
    minikube tunnel
    ```

   *Leave this terminal open while using Ingress, as it needs to keep running to maintain the tunnel.*

### Deploy the Application

1. Apply the Kubernetes configurations:
    ```sh
    kubectl apply -f frontend-and-poll-managment/
    ```

2. Verify that all pods are running:
    ```sh
    kubectl get pods
    ```

3. Check the status of the services:
    ```sh
    kubectl get services
    ```

4. Ensure the Ingress resource is created:
    ```sh
    kubectl get ingress
    ```

### Accessing the Application

1. To access the frontend, you can use Minikube’s IP and the service port:
    ```sh
    minikube service frontend --url
    ```

2. Alternatively, if using Ingress, open a browser and navigate to `http://localhost` to see the frontend.

### Useful Commands

- **Get Minikube IP:**
    ```sh
    minikube ip
    ```

- **Check logs of a specific pod:**
    ```sh
    kubectl logs <pod-name>
    ```

- **Execute a command inside a container:**
    ```sh
    kubectl exec -it <pod-name> -- /bin/sh
    ```

- **Delete all resources:**
    ```sh
    kubectl delete -f frontend-and-poll-managment/
    ```

- **Update the deployment:**
    ```sh
    kubectl rollout restart deployment <deployment-name>
    ```

- **View detailed events for debugging:**
    ```sh
    kubectl get events
    ```

### Notes

- Ensure your `ConfigMap` for initializing PostgreSQL is correctly referenced in your PostgreSQL deployment.
- Verify that your Ingress controller is correctly routing traffic to the services.

## Troubleshooting

- **Pods not starting:** Check the logs using `kubectl logs <pod-name>` and `kubectl describe pod <pod-name>` for more details.
- **Service not accessible:** Ensure that the service is correctly configured and that the Ingress controller is properly set up.

Feel free to adjust configurations according to your needs.