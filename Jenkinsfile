pipeline {
    agent any

    triggers {
            pollSCM('* * * * *')
        }
    stages {
        stage('Collect') {
            steps {
                sh "mkdir -p log"
                sh "docker container prune -f"
                sh "docker image prune -af"
                }
            }
        stage('Clean up') {
            steps {
                echo "Cleaning up wrokspace..."
                sh '''
                docker image rm -f build_stage
                docker image rm -f pysnake-test
                docker image rm -f pysnake-deploy
                
                docker stop artifact
                docker container rm artifact
                '''
            }
        }

        
        stage('Checkout') {
            steps {
                git 'https://github.com/Majka1012/snakegame-gui.git'
            }
        }

        stage('Build') {
            steps {
                echo "Building..."
                sh '''
                cd currency-exchange-files-docker
                docker build --no-cache -f Dockerfile.build -t build_stage .
                '''
                sh 'docker logs pysnake > ./log/pysnake_log.txt'
            }
        }
        stage('Test') {
            steps {
                sh 'docker build -t pysnake-test ./tests'
                sh 'docker run --name pysnake-test pysnake-test'
                sh 'docker logs pysnake-test > ./log/pysnake_deploy_log.txt'
            }
        }
        stage('Deploy'){
            steps {
                sh '''
                cd currency-exchange-files-docker
                docker build --no-cache -f Dockerfile.deploy -t pysnake-deploy .
                docker run --rm deploy_stage
                '''
                sh 'docker logs pysnake-deploy > ./log/pysnake_test_log.txt'
            }
        }
   
    }
 }

