
```markdown
# Terraform AWS Infrastructure Project

This project provisions a modular, production-ready AWS infrastructure using **Terraform**, with **CI/CD automation via Jenkins**, and follows best practices including backend state management, modular architecture, and scalable infrastructure provisioning.

---

## Project Overview

This infrastructure-as-code project includes:

- A **modular VPC** setup with public and private subnets.
- **Security groups** for controlled access.
- An **EC2 instance** running an NGINX Docker container.
- An **EKS Cluster** provisioned using the official Terraform AWS EKS module.
- **State management** via an S3 bucket with locking enabled.
- A full **CI/CD pipeline using Jenkins**, automating Terraform tasks.

---

## Project Structure

```bash
terraform_lab_1/
├── backend.tf
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
├── variables.tf
├── Jenkinsfile
├── modules/
│   ├── vpc/
│   ├── ec2/
│   ├── security_group/
│   ├── eks/
│   ├── iam/
```

---

## Modules

### VPC Module

Provisions a custom VPC with two public subnets.

- `vpc_cidr`
- `availability_zones`
- `public_subnets`

### Security Group Module

Creates security groups to allow SSH, HTTP, and EKS-related communication.

### EC2 Module

Launches an EC2 instance in the public subnet and installs Docker + NGINX container.

### EKS Module

Provisions:

- An EKS Cluster using the official AWS module
- Worker node groups (using managed node groups)
- Required IAM roles and policies (split into its own `iam` module)

---

## State Backend (S3)

State is stored in an S3 bucket with locking enabled via `use_lockfile`.

```hcl
terraform {
  backend "s3" {
    bucket         = "*****BUCKET-Name*****"
    key            = "terraform/terraform.tfstate"
    region         = "*****REGION*****"
    encrypt        = true
    use_lockfile   = true
  }
}
```

---

## CI/CD Pipeline (Jenkins)

Jenkins automates the following:

1. **Clones Git repo**
2. **Installs Terraform**
3. **Runs init → validate → plan**
4. **Applies infrastructure if `APPLY=true` is passed**

### Jenkinsfile Sample

```groovy
pipeline {
  agent { label "Jenkins-agent" }

  environment {
    TF_IN_AUTOMATION = "true"
    AWS_REGION = "eu-west-1"
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: "main" url: "https://github.com/De-General-1/terraform-prov-infra.git"
      }
    }

    stage('Install Terraform') {
      steps {
       script {
                    sh '''
                    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
                    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                    sudo apt update && sudo apt install terraform
                    '''
        }
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Validate') {
      steps {
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -var-file="terraform.tfvars"'
      }
    }

    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve -var-file="terraform.tfvars"'
      }
    }
  }

  post {
    failure {
      echo "Build failed!"
    }
    success {
      echo "Infrastructure provisioned successfully!"
    }
  }
}
```

---

## Variables (terraform.tfvars)

```hcl
vpc_cidr = "10.0.0.0/16"

vpc_name = "modular-vpc-terra"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

availability_zones = [
  "eu-west-1a",
  "eu-west-1b"
]
```

---

## Usage

### 1. Clone the repo

```bash
git clone https://github.com/De-General-1/terraform-prov-infra.git
cd terraform_lab_1
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Plan Infrastructure

```bash
terraform plan -var-file="terraform.tfvars"
```

### 4. Apply Infrastructure

```bash
terraform apply -auto-approve -var-file="terraform.tfvars"
```

> Or let Jenkins handle all of this for you!

---

## Security Considerations

- Sensitive data (keys, credentials) should not be stored in this repo.
- Consider using **AWS Secrets Manager** or **SSM Parameter Store** for secrets.

---

## Status

VPC Provisioned  
EC2 + Docker + NGINX running  
Security Groups set up  
EKS Cluster deployed  
S3 Backend with Locking enabled  
Jenkins CI/CD pipeline live

---

## Author

**@De-General-1**

---

## License

MIT – use, modify, and contribute freely.

```

---
```
