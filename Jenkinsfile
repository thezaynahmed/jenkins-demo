pipeline {
    agent any

    options {
        // Slide 31: Keep last 10 builds & stop hung builds
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 10, unit: 'MINUTES')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                echo 'Running automated Pytest suite...'
                sh 'python3 -m pytest -v'
            }
        }

        stage('Package') {
            steps {
                echo "Packaging artifact for build #${BUILD_NUMBER}..."
                sh 'zip -r app-${BUILD_NUMBER}.zip . -x ".git/*"'
                archiveArtifacts artifacts: '*.zip', fingerprint: true
            }
        }
    }

    post {
        always {
            echo "Pipeline finished for Build #${BUILD_NUMBER}"
        }
        success {
            echo 'Build, Test & Package succeeded! ✓'
        }
        failure {
            echo 'Pipeline failed! Check Console Output. ✗'
        }
    }
}
