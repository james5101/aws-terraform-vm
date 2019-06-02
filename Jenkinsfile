pipeline {
    agent any
    environment { 
        AWS_ACCESS_KEY_ID = credentials('dev')
        AWS_SECRET_ACCESS_KEY = credentials('dev')
    }
    stages {
        stage('Terraform Init') {
            steps {
                sh 'echo {$AWS_ACCESS_KEY_ID}'
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