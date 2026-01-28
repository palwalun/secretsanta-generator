pipeline{
 agent any
 stages{
  stage('Checkout'){
    steps{
    git url: 'https://github.com/palwalun/secretsanta-generator.git', branch: 'master'
    }
  }
    stage('Build Image'){
    steps{
    sh 'docker build -t secretsanta-generator:latest .'
    }
  }
 
 }

}