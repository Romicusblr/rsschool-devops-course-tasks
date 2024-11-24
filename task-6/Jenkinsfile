pipeline {
    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            metadata:
              name: kaniko
            spec:
              containers:
              - name: kaniko
                image: gcr.io/kaniko-project/executor:latest
                volumeMounts:
                - name: kaniko-secret
                  mountPath: /kaniko/.docker/
              volumes:
              - name: kaniko-secret
                secret:
                  secretName: ecr-registry
            """
        }
    }
    environment {
        // Define environment variables
        AWS_REGION = 'us-east-1'
        ECR_REPO = '441592700969.dkr.ecr.us-east-1.amazonaws.com/my-jenkins-app'
        HELM_RELEASE = 'my-jenkins-app'
        HELM_CHART_DIR = './my-jenkins-app' // Path to your Helm chart
        NAMESPACE = 'app'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                git branch: 'main', url: 'https://github.com/Romicusblr/rsschool-devops-course-tasks-app'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                container('kaniko') {
                    sh '/kaniko/executor --dockerfile=Dockerfile --context=dir://workspace/app --destination=441592700969.dkr.ecr.us-east-1.amazonaws.com/my-jenkins-app:${BUILD_NUMBER} --oci-layout-path=/kaniko/oci'
                }
            }
        }

        // stage('Deploy with Helm') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'kubeconfig-credentials', usernameVariable: 'KUBECONFIG_USERNAME', passwordVariable: 'KUBECONFIG_PASSWORD')]) {
        //             sh """
        //                 helm upgrade --install ${HELM_RELEASE} ${HELM_CHART_DIR} \
        //                     --namespace ${NAMESPACE} \
        //                     --set image.repository=${ECR_REPO} \
        //                     --set image.tag=${env.IMAGE_TAG}
        //             """
        //         }
        //     }
        // }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
