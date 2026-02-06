pipeline {
    agent any

    environment {
        IMAGE_NAME = "khosekushal/kushal-devops-app"
        IMAGE_TAG  = "${BUILD_NUMBER}"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/KhoseKushal/Portfolio.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Push Image to Docker Hub') {
          steps {
              withCredentials([usernamePassword(
                 credentialsId: 'dockerhub-creds',
                 usernameVariable: 'DOCKER_USER',
                 passwordVariable: 'DOCKER_PASS'
              )]) {
                  sh '''
                     echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                     docker push khosekushal/kushal-devops-app:${BUILD_NUMBER}
                     '''
              }
          }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                  export KUBECONFIG=/root/.kube/config
                  kubectl set image deployment/kushal-app \
                  kushal-app=$IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }
    }
}
