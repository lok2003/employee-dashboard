# Employee Dashboard

A beginner-friendly Employee Dashboard project using React.js for the frontend, FastAPI/Python for the backend, Terraform for AWS and Azure infrastructure, Docker images, and Helm/Kubernetes deployment.

## Project Flow

```text
Browser
   |
   v
NGINX Ingress
   |
   +---- /       ---> React Frontend
   |
   +---- /api    ---> FastAPI Backend
                         |
                         v
                      SQLite
```

Application flow:

```text
http://example.com
      |
      v
Employee Login
      |
      | POST /api/auth/login
      v
FastAPI
      |
      v
Dashboard
      |
      | GET /api/dashboard
      v
Employee Dashboard
```

## Technologies

### Frontend
- React.js
- Vite
- JavaScript
- NGINX
- npm

### Backend
- Python 3.12
- FastAPI
- Uvicorn
- SQLite
- Pydantic

### DevOps
- Docker
- Docker Hub
- GitHub Actions
- Kubernetes
- Helm
- NGINX Ingress

### Infrastructure
- Terraform
- AWS
- Amazon EKS
- Azure
- Azure AKS

## Folder Structure

```text
employee-dashboard/
│
├── .github/
│   └── workflows/
│       └── ci-pipeline.yaml
│
├── backend/
│   ├── app/
│   │   ├── __init__.py
│   │   ├── main.py
│   │   ├── pyproject.toml
│   │   └── employee_dashboard.db
│   ├── Dockerfile
│   └── requirements.txt
│
├── src/
│   ├── Dockerfile
│   └── React source files
│
├── dist/
├── package.json
├── package-lock.json
├── index.html
│
├── terraform/
│   └── AWS infrastructure
│
├── terraform_Azure/
│   └── Azure infrastructure
│
├── employee-dashboard/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── namespace.yaml
│       ├── configmap.yaml
│       ├── secret.yaml
│       ├── deployment.yaml
│       ├── backend-deployment.yaml
│       ├── service.yaml
│       ├── backend-service.yaml
│       └── ingress.yaml
│
└── README.md
```

## Frontend

Install dependencies:

```bash
npm ci
```

Run locally:

```bash
npm run dev
```

Build:

```bash
npm run build
```

The frontend communicates with the backend through `/api`.

Examples:

```text
/api/auth/login
/api/dashboard
/api/profile
/api/employees
```

## Backend

Go to the backend directory:

```bash
cd backend
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run FastAPI locally:

```bash
uvicorn app.main:app --reload --port 8000
```

Health check:

```bash
curl http://localhost:8000/api/health
```

Backend API:

```text
POST   /api/auth/login
GET    /api/health
GET    /api/dashboard
GET    /api/employees
POST   /api/employees
PUT    /api/employees/{employee_id}
DELETE /api/employees/{employee_id}
GET    /api/profile
PUT    /api/profile
```

## Docker

Frontend image:

```bash
docker build -t <docker-username>/frontend-dashboard:v1.19 -f src/Dockerfile .
docker push <docker-username>/frontend-dashboard:v1.19
```

Backend image:

```bash
docker build -t <docker-username>/backend:v2.19 -f backend/Dockerfile backend
docker push <docker-username>/backend:v2.19
```

Run backend:

```bash
docker run -d --name backend -p 8000:8000 <docker-username>/backend:v2.19
```

Run frontend:

```bash
docker run -d --name frontend -p 8080:80 <docker-username>/frontend-dashboard:v1.19
```

## GitHub Actions

The CI pipeline:
- Installs frontend dependencies
- Builds the React application
- Installs Python dependencies
- Builds the Python package
- Builds Docker images
- Pushes images to Docker Hub

Docker Hub credentials are stored as GitHub repository secrets.

Required secrets:

```text
DOCKER_USERNAME
DOCKER_PASSWORD
```

## Terraform - AWS

Terraform is used to create AWS infrastructure for Kubernetes.

Main flow:

```text
Terraform
   |
   +-- VPC
   +-- Subnets
   +-- Security Groups
   +-- IAM
   +-- EKS Cluster
   +-- EKS Node Group
   +-- ECR
   +-- EKS Add-ons
```

Initialize:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

Connect to EKS:

```bash
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

Check:

```bash
kubectl get nodes
```

## Terraform - Azure

Terraform is used to create Azure AKS infrastructure.

Main flow:

```text
Terraform
   |
   +-- Resource Group
   +-- VNet
   +-- Subnets
   +-- NSG
   +-- AKS Cluster
   +-- Node Pool
```

Initialize:

```powershell
terraform init
```

Validate:

```powershell
terraform validate
```

Plan:

```powershell
terraform plan
```

Apply:

```powershell
terraform apply
```

Connect to AKS:

```powershell
az aks get-credentials --resource-group <resource-group> --name <aks-name>
```

Check:

```powershell
kubectl get nodes
```

## Helm

Check the chart:

```bash
helm lint .
```

Render Kubernetes manifests:

```bash
helm template employee-dashboard .
```

Install:

```bash
helm install employee-dashboard . -n frontend-dashboard --create-namespace
```

Upgrade:

```bash
helm upgrade employee-dashboard . -n frontend-dashboard
```

Check Helm:

```bash
helm list -A
```

Check Helm release:

```bash
helm status employee-dashboard -n frontend-dashboard
```

Uninstall:

```bash
helm uninstall employee-dashboard -n frontend-dashboard
```

## Kubernetes Checks

Check pods:

```bash
kubectl get pods -n frontend-dashboard
```

Check services:

```bash
kubectl get svc -n frontend-dashboard
```

Check ingress:

```bash
kubectl get ingress -n frontend-dashboard
```

Check deployments:

```bash
kubectl get deployments -n frontend-dashboard
```

Check service endpoints:

```bash
kubectl get endpoints -n frontend-dashboard
```

For newer Kubernetes versions, EndpointSlice can be checked with:

```bash
kubectl get endpointslices -n frontend-dashboard
```

Check pod logs:

```bash
kubectl logs <pod-name> -n frontend-dashboard
```

Describe a pod:

```bash
kubectl describe pod <pod-name> -n frontend-dashboard
```

## Internal Connectivity Checks

Create a temporary curl pod:

```bash
kubectl run curl-test   -n frontend-dashboard   --image=curlimages/curl:latest   --rm -it   -- sh
```

Test backend Service:

```bash
curl http://employee-dashboard-backend-service:8000/api/health
```

Expected:

```json
{"status":"ok","timestamp":"..."}
```

Test frontend Service:

```bash
curl -I http://employee-dashboard-service:80
```

Test backend through Ingress:

```bash
curl -H "Host: example.com" http://ingress-nginx-controller/api/health
```

Test frontend through Ingress:

```bash
curl -H "Host: example.com" http://ingress-nginx-controller/
```

Exit the temporary pod:

```bash
exit
```

## Application URLs

Frontend:

```text
http://example.com/
```

React routes:

```text
/profile
/dashboard
/employees
```

Backend API:

```text
/api/health
/api/auth/login
/api/dashboard
/api/profile
/api/employees
```

## Kubernetes Routing

```text
example.com/
      |
      v
frontend-service:80
      |
      v
React + NGINX


example.com/api/*
      |
      v
backend-service:8000
      |
      v
FastAPI
```

The backend Service uses `ClusterIP`, so the FastAPI application is accessed internally through Kubernetes/Ingress rather than directly exposed with a LoadBalancer.

## Notes

- Do not commit passwords, cloud credentials, private keys, or Terraform state files.
- Keep `.tfvars` files out of Git when they contain sensitive values.
- SQLite is used for this learning project. For production, use an external database with appropriate persistent storage and backup.
