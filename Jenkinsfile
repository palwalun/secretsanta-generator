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
		stage('Push Image to ACR'){
	      steps{
	        sh 'docker push $ACR_LOGIN_SERVER/${IMAGE_NAME}:${TAG}'
	    }
	   }
      stage('Connect to AKS') {
  steps {
    sh '''
      az login --service-principal -u $AZ_CLIENT_ID -p $AZ_CLIENT_SECRET --tenant $AZ_TENANT_ID
      az account set --subscription $AZ_SUBSCRIPTION_ID
      az aks get-credentials --resource-group DevOps --name aks-cluster --overwrite-existing
    '''
   }
  }
  stage('Deploy to k8s cluster'){
	  steps{
	   sh '''
	    kubectl apply -f deployment.yml
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

