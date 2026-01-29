pipeline{
 agent any
 parameters{
 choice(
 name: 'ENV',
 choices: ['DEV', 'TEST', 'PROD'],
 description: 'select environment'
 )
 }
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
	 script{
	 try{ 
    sh 'sudo docker build -t secretsanta-senerator:latest .'
       }
	  catch(err){
	   currentBuild.result = 'FAILURE'
	   }
	  }
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
	  stage('Approval Gate'){
	  steps{
	  script{
	   try{
	   	   input message: "Please approve the Deployment"
	   }
	   catch(err){
	   currentBuild.Result = 'FAILURE'
	   }
	  }
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

