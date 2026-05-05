pipeline {
    agent any

    environment {
        IMAGE_NAME = "myapp"
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Clone Code') {
            steps {
                git ''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }
        }

        stage('Trivy Scan - Image') {
            steps {
                sh '''
                trivy image --exit-code 1 --severity CRITICAL,HIGH \
                --format json -o trivy-report.json \
                $IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Archive Report') {
            steps {
                archiveArtifacts artifacts: 'trivy-report.json', fingerprint: true
            }
        }

    }

    post {
        failure {
            echo "❌ Build failed due to vulnerabilities!"
        }
        success {
            echo "✅ Image is safe. Proceed to deploy."
        }
    }
}
