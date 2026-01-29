pipeline{
 agent any
 stages{
  stage('Checkout'){
    steps{
    checkout scm
    }
  }
    stage('Build Image'){
    steps{
    sh 'sudo docker build -t secretsanta-generator:latest .'
    }
  }
 
 }

}