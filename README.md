# Deployment Playground

This repository is designated for playing around with our services and testing their functionality with Kubernetes. It contains Kubernetes manifests for deploying a poll management service, frontend service, and PostgreSQL database.

## Repository Structure

- `backend-deployment.yml`: Deployment manifest for the poll management service.
- `backend-service.yml`: Service manifest for the poll management service.
- `frontend-deployment.yml`: Deployment manifest for the frontend service.
- `frontend-service.yml`: Service manifest for the frontend service.
- `init-configmap.yml`: ConfigMap manifest for initializing the PostgreSQL database.
- `postgres-deployment.yml`: Deployment manifest for the PostgreSQL database.
- `postgres-service.yml`: Service manifest for the PostgreSQL database.
- `.gitignore`: Git ignore file.
- `README.md`: This README file.

## Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/docs/start/) installed
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed
- [Docker](https://docs.docker.com/get-docker/) installed

## Setting Up Minikube

1. **Start Minikube:**

    ```bash
    minikube start
    ```

2. **Enable Ingress (optional, if needed):**

    ```bash
    minikube addons enable ingress
    ```

## Deploying Services

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/your-username/deployment-playground.git
    cd deployment-playground
    ```

2. **Apply All Kubernetes Manifests:**

    ```bash
    kubectl apply -f ./{config-dir}
    ```

    This command applies all YAML files in the current directory.

3. **Verify Deployments:**

    Check if all pods are running correctly:

    ```bash
    kubectl get pods
    ```

    You should see the pods for the `poll-manager`, `frontend`, and `postgres` services running.

4. **Accessing the Services:**

    To access the services, you can use port forwarding or a Minikube service tunnel:

    **Port Forwarding:**

    ```bash
    kubectl port-forward svc/backend 8081:8081
    kubectl port-forward svc/frontend 8080:8080
    kubectl port-forward svc/postgres 5432:5432
    ```

    **Minikube Service Tunnel:**

    ```bash
    minikube service backend
    minikube service frontend
    minikube service postgres
    ```

## Database Initialization

The `init-configmap.yml` ConfigMap contains the SQL script to initialize the PostgreSQL database with the required tables. This ConfigMap is mounted in the `postgres-deployment.yml` deployment to run the script during the database initialization.

## Cleaning Up

To delete all resources created by the manifests:

```bash
kubectl delete -f .
```

## Troubleshooting

- **Ensure Minikube is Running:**

    ```bash
    minikube status
    ```

- **Check Pod Logs for Errors:**

    ```bash
    kubectl logs <pod-name>
    ```

- **Verify Kubernetes Resources:**

    ```bash
    kubectl get all
    ```

- **Common Issues:**

    - **Pods Not Starting:**
        - Check the pod descriptions for events that might indicate issues:
            ```bash
            kubectl describe pod <pod-name>
            ```
        - Ensure the container images are available and accessible. If you're using private repositories, make sure to configure image pull secrets.

    - **Service Not Accessible:**
        - Verify the service details:
            ```bash
            kubectl get svc
            ```
        - Check the service endpoints:
            ```bash
            kubectl describe svc <service-name>
            ```

    - **Database Connection Issues:**
        - Ensure the PostgreSQL service is running and accessible:
            ```bash
            kubectl get pods -l app=postgres
            ```
        - Verify the environment variables for the database connection in the `poll-manager` deployment.

## Updating Services

To update any of the services, you can modify the corresponding YAML files and apply the changes using:

```bash
kubectl apply -f <modified-file>.yml
```

## Additional Commands

- **Scaling Deployments:**

    To scale the `poll-manager` deployment, for example:

    ```bash
    kubectl scale deployment poll-manager --replicas=<number-of-replicas>
    ```

- **Deleting Resources:**

    To delete all resources created by the manifests:

    ```bash
    kubectl delete -f .
    ```

- **Restarting Pods:**

    To restart a specific deployment (e.g., `poll-manager`):

    ```bash
    kubectl rollout restart deployment poll-manager
    ```

- **Watching Pod Status:**

    To actively watch the status of pods:

    ```bash
    kubectl get pods --watch
    ```

    This command will continuously update the pod status in the terminal.

## Useful Links

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl Command Reference](https://kubernetes.io/docs/reference/kubectl/)