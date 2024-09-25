pipeline {
    agent any
    tools {
        maven 'Maven-3.9.9' // This is the name you gave in the Global Tool Configuration
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                // For a Maven project, for example, the following command can be used:
                sh 'mvn clean package'
            }
            post {
                success {
                    echo 'Build completed successfully'
                    archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Run unit tests using Maven, for example:
                sh 'mvn test'
            }
            post {
                success {
                    echo 'Tests passed successfully'
                    junit '**/target/surefire-reports/*.xml' // JUnit test results for Maven projects
                }
                failure {
                    echo 'Tests failed'
                }
            }
        }
       stage('Code Quality Analysis') {
            steps {
                echo 'Running code quality analysis...'
                withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
                    // Using SonarQube
                    withSonarQubeEnv('SonarQube') {
                        sh '''
                            mvn sonar:sonar \
                                -Dsonar.projectKey=projectone \
                                -Dsonar.projectName="projectone" \
                                -Dsonar.host.url=http://localhost:9000 \
                                -Dsonar.token=sqa_7260cdc6c9a4d431a00b562873388d74ea613c66
                        '''
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Build Docker image and deploy with Docker Compose
                    sh 'docker-compose down || true' // Stop any existing containers
                    sh 'docker-compose up --build -d' // Build and start the container
                }
            }
        }

    }
    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}

