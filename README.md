# 🚀 Terraform + Docker Static Website Deployment

## 📌 Project Overview

This project demonstrates a simple DevOps workflow using:

- Terraform for Infrastructure as Code (IaC)
- AWS EC2 for cloud infrastructure
- Docker for containerization
- nginx for static website hosting

The infrastructure is fully automated using Terraform and deploys a custom static website inside a Docker container running on an AWS EC2 instance.

---

# 🏗️ Architecture

```text
Terraform
    │
    ▼
AWS EC2 Instance
    │
    ▼
Docker Installed via user_data
    │
    ▼
nginx Container Running
    │
    ▼
Custom Static Website Hosted
```

---

# ⚙️ Technologies Used

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure provisioning |
| AWS EC2 | Virtual machine hosting |
| Docker | Container runtime |
| nginx | Web server |
| Ubuntu | EC2 operating system |

---

# 📁 Project Structure

```text
terraform-docker-website/
│
├── provider.tf
├── main.tf
├── outputs.tf
└── README.md
```

---

# ✨ Features

- Automated EC2 provisioning using Terraform
- Dynamic Ubuntu AMI retrieval using Terraform data source
- Security Group configuration for SSH and HTTP access
- Docker installation during EC2 boot
- nginx container deployment
- Custom static HTML website hosting
- Infrastructure automation using `user_data`

---

# 🌊 Terraform Workflow

```text
Write Terraform Code
        │
        ▼
terraform init
        │
        ▼
terraform validate
        │
        ▼
terraform plan
        │
        ▼
terraform apply
        │
        ▼
EC2 + Docker + nginx Deployed
```

---

# 🧠 Key Terraform Concepts Used

## 1. Data Sources

Used dynamic Ubuntu AMI lookup:

```hcl
data "aws_ami" "ubuntu"
```

This avoids hardcoded AMI issues across regions.

---

## 2. Security Groups

Allowed:
- Port 22 → SSH
- Port 8080 → Website access

---

## 3. user_data

Used EC2 bootstrap automation to:
- install Docker
- start Docker service
- pull nginx image
- run nginx container
- host static website

---

# 🔥 Challenges Faced & Debugging Journey

This project involved several real-world DevOps troubleshooting scenarios.

---

## 1. Terraform Syntax & Indentation Issues

### ❌ Problem

Terraform initially failed due to:
- incorrect indentation
- improper block structure
- heredoc formatting mistakes

### ✅ Fix

Used:

```bash
terraform fmt
terraform validate
```

to auto-format and validate Terraform code.

### 📚 Learning

Terraform is sensitive to:
- block closures
- syntax structure
- heredoc formatting

---

# 2. Invalid AMI Errors

### ❌ Problem

Terraform failed with:

```text
InvalidAMIID.NotFound
```

because hardcoded AMI IDs did not exist in the selected AWS region.

### ✅ Fix

Replaced static AMI with dynamic data source:

```hcl
ami = data.aws_ami.ubuntu.id
```

### 📚 Learning

AMI IDs are region-specific and should not be hardcoded in production environments.

---

# 3. Docker Not Installing Automatically

### ❌ Problem

EC2 launched successfully but Docker was not installed.

### 🔍 Root Cause

`user_data` script failed during boot due to:
- package manager timing
- cloud-init execution timing
- missing logging visibility

### ✅ Fix

Improved `user_data` script with:
- `sleep` delay
- logging
- explicit Docker installation
- Docker service startup

Example:

```bash
exec > /var/log/user-data.log 2>&1
```

### 📚 Learning

Infrastructure automation requires debugging and log inspection.

---

# 4. nginx Container Not Starting

### ❌ Problem

Docker installed successfully but nginx container failed to run.

### ✅ Fix

Added:

```bash
docker pull nginx
```

before running the container.

### 📚 Learning

Containers may fail if required images are not pulled beforehand.

---

# 5. Terraform State & Incremental Deployments

### 👀 Observation

Terraform successfully created some resources even when others failed.

Example:
- Security Group created
- EC2 creation failed

### 📚 Learning

Terraform performs incremental infrastructure creation and tracks successful resources inside:

```text
terraform.tfstate
```

---

# 🚀 Deployment Commands

## Initialize Terraform

```bash
terraform init
```

---

## Validate Configuration

```bash
terraform validate
```

---

## Format Terraform Code

```bash
terraform fmt
```

---

## Preview Infrastructure

```bash
terraform plan
```

---

## Deploy Infrastructure

```bash
terraform apply
```

---

## Destroy Infrastructure

```bash
terraform destroy
```

---

# 🧪 Verification Steps

SSH into EC2:

```bash
ssh -i terraform-key.pem ubuntu@PUBLIC_IP
```

Check Docker:

```bash
docker --version
```

Check running containers:

```bash
docker ps
```

---

# 🌍 Website Access

Open browser:

```text
http://PUBLIC_IP:8080
```

Expected output:

```text
🚀 Nixk DevOps Lab
Terraform + Docker + nginx
```

---

# 📚 Key DevOps Learnings

- Infrastructure as Code (IaC)
- Cloud provisioning with Terraform
- AWS EC2 automation
- Docker container deployment
- Bootstrap automation using `user_data`
- Infrastructure debugging
- Terraform state management
- Production-style automation troubleshooting

---

# 🚀 Future Improvements

Potential next upgrades:

- Docker Compose integration
- Terraform modules
- GitHub Actions CI/CD
- Docker Hub image automation
- Kubernetes deployment
- Load Balancer integration
- HTTPS setup using Nginx reverse proxy

---

# ⚡ Final Thoughts

This project demonstrates how Terraform and Docker can work together to automate infrastructure provisioning and application deployment in a cloud environment.

The debugging process itself became one of the biggest learning experiences, covering:
- Terraform validation
- AMI compatibility
- cloud-init troubleshooting
- Docker automation
- infrastructure lifecycle management

This project reflects a foundational DevOps workflow combining:
- Cloud
- Infrastructure as Code
- Containers
- Automation
- Debugging mindset
