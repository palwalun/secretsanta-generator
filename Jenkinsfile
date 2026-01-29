pipeline{
 agent any
 stages{
  stage('Checkout'){
    steps{
    checkout scm
    }
  }
    stage('Build'){
    steps{
    sh 'mvn clean package -DskipTests'
    }
  }
  stage('Build docker Image'){
    steps{
    sh 'sudo docker build -t secretsanta-senerator:latest .'
    }
  }
 
 }
 post{
  always {
  cleanWs()
  }
 }

}