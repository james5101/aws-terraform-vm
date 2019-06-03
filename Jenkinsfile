pipeline {
    agent any
    
    environment { 
        AWS_ACCESS_KEY_ID = credentials('dev')
        AWS_SECRET_ACCESS_KEY = credentials('dev')
        AWS_REGION = "us-east-1"
    }
    
    stages {
        stage ('Git Checkout') {
            steps {
                cleanWs()
                checkout([$class: 'GitSCM', branches: [[name :'*/master', name: '*/develop']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/james5101/aws-terraform-vm']]])
            }
        }
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