pipeline{
 agent any
 environment{
  ACR_LOGIN_SERVER = "devopsproject1.azurecr.io"
  IMAGE_NAME = 'secretsanta-senerator'
  TAG = 'latest'
 }
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
 
  stage('Login to ACR') {
       steps {
         withCredentials([usernamePassword(
             credentialsId: 'acr-creds',
             usernameVariable: 'ACR_USER',
             passwordVariable: 'ACR_PASS'
         )]) {
             sh '''
               echo $ACR_PASS | docker login $ACR_LOGIN_SERVER \
               -u $ACR_USER --password-stdin
             '''
           }
          }
         }
		 stage('Tag Image') {
        steps {
         sh '''
           docker tag ${IMAGE_NAME}:${TAG} \
           $ACR_LOGIN_SERVER/${IMAGE_NAME}:${TAG}
         '''
          }
        }
 
 }
 post{
  always {
  cleanWs()
  }
 }
}

