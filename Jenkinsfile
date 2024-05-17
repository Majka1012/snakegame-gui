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
        
        
        stage('Checkout') {
            steps {
                git 'https://github.com/Majka1012/snakegame-gui.git'
            }
        }

          stage('Build') {
            steps {
                sh 'docker build -t pysnake .'
                sh 'docker run --name pysnake pysnake'
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
               
               sh 'docker build --no-cache  -t -f pysnake-deploy ./deploy'
           
                sh 'docker run --rm deploy_stage'
            
                sh 'docker logs pysnake-deploy > ./log/pysnake_test_log.txt'
            }
        }
   
    }
 }

