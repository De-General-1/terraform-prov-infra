pipeline {
  agent any

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
        sh '''
            wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
            sudo apt update && sudo apt install terraform
            terraform --version
        '''
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
      echo " Build failed!"
    }
    success {
      echo "Infrastructure provisioned successfully!"
    }
  }
}
