# k8s_captsone_project
This project demonstrating kubernetes application deployment, configuration management, persistent storage, access control, autoscaling, release management, monitoring, and network security using minikube and helm.

**Project Overview**

This project deploys an NGINX web application on a kubernetes cluster using helm. It demonstrates core Kubernetes concepts and practical cluster administration through deployment, service exposure, configuration management, health checks, scaling, security, and troubleshooting. Also this application serves a simple html page displaying:

**Welcome to Capstone!**

**Technology Stack**
- Kubernetes
- Minikube
- Helm
- Docker
- NGINX
- kubectl
- ConfigMaps and Secrets
- PersistentVolumeClaims (PVC)
- Role-Based Access Control (RBAC)
- Horizontal Pod Autoscaler (HPA)
- NetworkPolicy

## Project Structure

```text
k8s_captsone_project/
├── base/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       └── configmap.yaml
├── security/
│   ├── hpa.yaml
│   ├── networkpolicy.yaml
│   └── rbac.yaml
├── storage/
│   ├── pvc-test-pod.yaml
│   └── training-pvc.yaml
├── index.html
└── README.md
```

## File Structure and Description

| File or folder | Purpose |
|---|---|
| `base/` | Helm chart for deploying the application |
| `base/Chart.yaml` | Helm chart metadata |
| `base/values.yaml` | Default Helm configuration values |
| `base/templates/` | Kubernetes resource templates |
| `security/hpa.yaml` | Horizontal Pod Autoscaler configuration |
| `security/networkpolicy.yaml` | Network traffic restrictions |
| `security/rbac.yaml` | ServiceAccount, Role, and RoleBinding configuration |
| `storage/training-pvc.yaml` | PersistentVolumeClaim configuration |
| `storage/pvc-test-pod.yaml` | Pod used to test persistent storage |
| `index.html` | HTML page served by NGINX |
| `README.md` | Project overview, setup instructions, and documentation |

## Prerequisites

**Install the following tools on your Linux machine or EC2 Ubuntu instance:**
- Docker
- Minikube
- kubectl
- Helm 3

**Verify the installation:**
docker --version
kubectl version --client
minikube version
helm version

# Deployment Guide

**1. Start the Kubernetes cluster**

minikube start
kubectl get nodes
kubectl cluster-info

Confirm that the Minikube node is in the Ready state.

**2. Navigate to the project directory**

cd ~/hari-k8s

Update the path if your project is stored in a different directory.

**3. Deploy the application using Helm**

Install the chart:

helm install rel1 ./base

If the release already exists, inspect it first:

helm list -A
helm status rel1

**4. Verify Kubernetes resources**

kubectl get all -n training-project
kubectl get pods -n training-project
kubectl get svc -n training-project

The expected application Deployment is training-app, and the Service is training-service.

**5. Access the application**

Start port forwarding:

kubectl port-forward svc/training-service 30001:80 \
  -n training-project --address=0.0.0.0

Keep the command running while accessing the application.

Open:

**http://15.20716.67:30001**

Replace <EC2-PUBLIC-IP> with your EC2 instance's public IP address.

For EC2 access, allow TCP port 30001 only from trusted IP addresses in the instance's security group.

# Kubernetes Features

**1. Application Deployment**

Deploys an NGINX application using a Kubernetes Deployment.

Configures two application replicas.

Uses Helm to package and manage Kubernetes resources.

Defines CPU and memory requests and limits.

**2. Service Exposure**

Exposes the application through a Kubernetes Service.

Uses port forwarding to access the web application externally.

**3. Configuration Management**

Uses the training-config ConfigMap for environment configuration.

Uses the training-html ConfigMap to provide index.html.

Uses the training-secret Secret for the DEMO_TOKEN environment variable.

**4. Persistent Storage**

Creates a PersistentVolumeClaim named training-data.

Verifies PVC binding and persistent storage behavior using a test Pod.

**5. Role-Based Access Control**

Configures a ServiceAccount, Role, and RoleBinding.

Verifies allowed Pod-listing operations.

Verifies that unauthorized Pod-deletion operations are denied.

**6. Health Checks and Resource Management**

Configures startup, readiness, and liveness probes to check application health.

Defines CPU and memory resource requests and limits for the NGINX container.

**7. Horizontal Pod Autoscaling**

Configures an HPA named training-hpa with:

Minimum replicas: 2

Maximum replicas: 5

Target CPU utilization: 60%

Check autoscaling status:

kubectl get hpa -n training-project
kubectl describe hpa training-hpa -n training-project
kubectl top pods -n training-project

The metrics-server must be available for resource metrics.

**8. Helm Release Management**

Uses Helm to manage release history and rollback operations.

helm list -A
helm history rel1
helm status rel1

To roll back to a specific revision:

helm rollback rel1 <REVISION>

Replace <REVISION> with the revision you want to restore.

**9. Observability and Troubleshooting**

Useful commands for inspecting application health, logs, events, and resource usage:

kubectl get pods -n training-project
kubectl describe pods -n training-project
kubectl get events -n training-project \
  --sort-by=.metadata.creationTimestamp
kubectl logs deployment/training-app -n training-project
kubectl top pods -n training-project
kubectl top nodes

**10. Network Security**

Creates a NetworkPolicy named training-ingress to allow ingress TCP traffic on port 80 from Pods in the same namespace to the selected application Pods.

Inspect the policy:

kubectl get networkpolicy -n training-project
kubectl describe networkpolicy training-ingress \
  -n training-project

NetworkPolicy enforcement depends on the cluster's networking implementation and should be verified with traffic tests.






