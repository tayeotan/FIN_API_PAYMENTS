# Financial Payments API - DevOps Pipeline

A production-ready payment processing API built with PowerShell, containerized with Docker, and deployed to Google Kubernetes Engine (GKE) with automated CI/CD pipelines.

**Live API Endpoint**: `http://34.29.49.247`


### Endpoints

#### 1. Health Check
http
GET /health

curl http://34.29.49.247/health

#### 2. Payment Approved Check
POST /pay
Content-Type: application/json


**Use PowerShell to test through the Live API Endpoint on health checks and payment checks**:

- Health check for Live API Endpoint: `curl http://34.29.49.247/health`

- Payment approved check example: `curl -Method POST -Uri "http://34.29.49.247/pay" -Headers @{"Content-Type"="application/json"} -Body '{"amount": 100}'` (enter any amount to determine whether its approved or not approved (will result an error) of invalid amount.)



---

## 📋 Project Overview

This project demonstrates a complete DevOps workflow for building, containerizing, and deploying a RESTful payment API to a Kubernetes cluster on Google Cloud Platform. The API provides basic payment processing functionality with health monitoring and transaction approval logic.

The application showcases modern DevOps practices including Infrastructure as Code (IaC), containerization, orchestration, automated deployments, and cloud-native architecture.

---

## 🎯 Goals & Objectives

### Primary Goals
- Build a functional payment processing API from scratch
- Implement containerization best practices using Docker
- Deploy and manage applications on Kubernetes (GKE)
- Create an automated CI/CD pipeline with GitHub Actions
- Demonstrate cloud-native application architecture

### Learning Objectives
- Gain hands-on experience with Google Cloud Platform (GCP)
- Understand Kubernetes resource management and orchestration
- Implement secure authentication using Workload Identity
- Configure ingress controllers for external traffic routing
- Practice GitOps workflows and automated deployments

---

## 🏗️ Project Structure

- `server.ps1`: PowerShell HTTP server handling API requests
- `healthcheck.ps1`: Health check script for container probes
- `Dockerfile`: Container image definition
- `namespace.yaml`: Kubernetes namespace for resource isolation
- `deployment.yaml`: Deployment configuration with 2 replicas
- `service.yaml`: ClusterIP service exposing pods internally
- `ingress.yaml`: NGINX ingress for external access
- `deploy.yaml`: GitHub Actions CI/CD pipeline
- `build.ps1`: Local Docker build script
- `cleanup.ps1`: Cleanup script for testing
- `deploy.ps1`: Local deployment script

### File Descriptions

#### Application Files
- **`app/src/server.ps1`**: Core API server using .NET `HttpListener` to handle HTTP requests on port 8080. Implements two endpoints:
  - `GET /health` - Returns `OK` for readiness/liveness probes
  - `POST /pay` - Validates payment amounts and returns approval with transaction ID

- **`app/healthcheck.ps1`**: Docker health check that verifies the `/health` endpoint responds successfully

- **`app/Dockerfile`**: Multi-stage container definition based on `mcr.microsoft.com/powershell:lts-alpine` for minimal image size

#### Kubernetes Manifests
- **`k8s/namespace.yaml`**: Creates `fin-payments` namespace for logical resource grouping

- **`k8s/deployment.yaml`**: Defines the application deployment with:
  - 2 replicas for high availability
  - Resource limits (500m CPU, 256Mi memory)
  - Readiness probe (15s initial delay)
  - Liveness probe (30s initial delay)
  - Container image from Artifact Registry

- **`k8s/service.yaml`**: ClusterIP service exposing pods on port 80, routing to container port 8080

- **`k8s/ingress.yaml`**: NGINX ingress configuration routing external traffic to the service

#### CI/CD Pipeline
- **`.github/workflows/deploy.yaml`**: GitHub Actions workflow that:
  - Authenticates using Workload Identity (no secrets required)
  - Retrieves GKE cluster credentials
  - Applies Kubernetes manifests
  - Verifies rollout status

---

## 🛠️ Tools & Technologies Used

### Development
- **PowerShell 7** - Scripting language for API implementation
- **.NET HttpListener** - Built-in HTTP server for handling requests
- **Git** - Version control

### Containerization
- **Docker** - Container runtime and image builder
- **Google Artifact Registry** - Private container image repository

### Cloud Infrastructure
- **Google Kubernetes Engine (GKE)** - Managed Kubernetes cluster
- **Google Cloud Build** - Serverless Docker image builds
- **Google Cloud IAM** - Workload Identity for secure authentication

### Kubernetes Resources
- **Deployments** - Application lifecycle management
- **Services** - Internal networking and load balancing
- **Ingress** - External traffic routing with NGINX Ingress Controller
- **Namespaces** - Resource isolation and multi-tenancy

### CI/CD
- **GitHub Actions** - Automated deployment pipeline
- **Workload Identity Federation** - Secure, keyless authentication to GCP

### DevOps Practices
- **Infrastructure as Code (IaC)** - Kubernetes YAML manifests
- **GitOps** - Git as single source of truth for deployments
- **Container Orchestration** - Kubernetes for scaling and self-healing

---

## 🔑 Key Takeaways

**Technical Skills Developed**
1. Container Orchestration: Successfully deployed and managed multi-replica applications on Kubernetes with automated rollouts and health monitoring
2. Cloud-Native Architecture: Implemented scalable, resilient microservices architecture with proper resource limits and horizontal scaling capabilities
3. Secure Authentication: Configured Workload Identity Federation for keyless, secure communication between GitHub Actions and GCP services
4. Infrastructure as Code: Managed all infrastructure through declarative YAML manifests, enabling reproducible deployments
5. CI/CD Automation: Built end-to-end automated pipeline from code commit to production deployment

**DevOps Best Practices**
* Separation of Concerns: Application code, infrastructure definitions, and CI/CD pipelines in separate directories
* Health Monitoring: Implemented readiness and liveness probes for self-healing capabilities
* Resource Management: Defined CPU and memory limits to prevent resource exhaustion
* High Availability: Deployed multiple replicas with automatic load balancing
* Security: Used Workload Identity instead of storing credentials in GitHub secrets

**Challenges Overcome**
* Image Registry Networking: Resolved Docker push failures by using Cloud Build instead of Cloud Shell's Docker daemon
* IAM Permissions: Properly configured service account roles for Artifact Registry and Cloud Build
* Ingress Configuration: Set up NGINX Ingress Controller and LoadBalancer for external access

---

## 🔮 Future Enhancements
**Short-Term Improvements**
 - Add input validation for payment amount and currency
 - Implement request logging to Cloud Logging
 - Add Prometheus metrics endpoint for monitoring
 - Configure Horizontal Pod Autoscaler (HPA) based on CPU usage
 - Add TLS/HTTPS support with Let's Encrypt certificates

**Medium-Term Features**
 - Integrate with Cloud SQL for persistent transaction storage
 - Add authentication/authorization with OAuth 2.0
 - Implement rate limiting to prevent abuse
 - Add distributed tracing with Cloud Trace
 - Create Grafana dashboards for real-time monitoring

**Long-Term Goals**
 - Multi-region deployment for disaster recovery
 - Implement event-driven architecture with Pub/Sub
 - Add support for multiple payment methods
 - Integrate fraud detection using machine learning
 - Implement blue-green or canary deployment strategies





