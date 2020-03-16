pipeline {
    agent any
    tools {
        maven 'Maven 3.6'
    }
    stages {
        stage('checkout code') {
            steps {
            sh 'mkdir -p code'
            dir("code") {
                git branch: 'master', url: 'https://github.com/kantega/react-and-spring.git'
                }
            }
        }
        stage('checkout OpsCode') {
            steps {
            sh 'mkdir -p opscode'
            dir("opscode") {
                git branch: 'master', url: 'https://github.com/kantega/react-and-spring.git'
                }
            }
        }
        stage ('Build') {
            steps {
                sh 'mvn clean package' 
            }
        }
        stage ('Copy Package') {
            steps {
                sh 'cp ${env.WORKSPACE}/code/target/spring-and-react-0.0.1-SNAPSHOT.jar ${env.WORKSPACE}/opscode/packages' 
            }
        }
        stage('Set Terraform path') {
            steps {
                script {
                def tfHome = tool name: 'Terraform'
                env.PATH = "${tfHome}:${env.PATH}"
                }
            sh 'terraform — version'
            }
        }
        stage ('Deploy') {
            steps {
                sh 'terraform init' 
                sh 'terraform plan -out=plan'
                sh 'terraform apply plan'
            }
        }
    }
}