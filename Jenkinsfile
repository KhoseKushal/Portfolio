pipeline { 
	agent any

	environment {
		DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
		IMAGE_NAME = '<khosekushal>/kushal-devops-app'
		IMAGE-TAG = 'v2'
	}

	stages {

		stage('Checkout Code') {
			steps {
				echo 'Cloning Github repository'
				checkout scm
			}
		}

		stege('Build Docker Image') {
			steps {
				echo 'Building Docker Image'
				sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
			}
		}

		stage('Push Image to Docker Hub') {
			steps {
				echo 'Logging in to Docker Hub'
				withCredentials([usernamePassword(
					credentialsId: DOCKERHUB_CREDENTIALS,
					usernameVaribale: 'DOCKER_USER',
					passwordVaribale: 'DOCKE_PASS'
				)]) {
					sh '''
						echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
						docker push $IMAGE_NAME:$IMAGE_TAG
					'''
				}
			}
		}
	}
}		
