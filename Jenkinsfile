pipeline {
    agent any

    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Run InSpec'){
            steps {
                sh 'inspec exec inspec-aws-vm/ -t aws:// --reporter cli'
            }
        }
        stage('Terraform Destroy'){
            steps {
                input "Destroy infra?"
                sh 'terraform destroy -auto-approve'
            }

        }
    }
}