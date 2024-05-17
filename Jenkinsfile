pipeline {
    agent any

    environment {
        REPOSITORY = 'https://github.com/Majka1012/snakegame-gui.git'
        CREDENTIALS = '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'
        BRANCH = 'master'
        DOCKERHUB_CREDENTIALS = credentials('767a3e7d-821c-4e40-b740-8f4725be8d37')
    }
    
    triggers {
        pollSCM('* * * * *')
    }

    stages {
        stage('Collect') {
            steps {
                git branch: "${BRANCH}", credentialsId: "${CREDENTIALS}", url: "${REPOSITORY}"
            }
        }
        
        stage('Build') 
        {
            steps {
                sh 'docker build -t pysnake .'
                sh 'docker run --name pysnake pysnake'
                sh 'docker logs pysnake > ./log/pysnake_log.txt'
            }
        }
        
        stage('Test') 
        {
            steps 
            {
                sh 'docker build -t pysnake-test ./test'
                sh 'docker run --name pysnake-test pysnake-test'
                sh 'docker logs pysnake-test > ./log/pysnake_deploy_log.txt'
            }
        }
        
        stage('Deploy') 
        {
            agent any
            steps {
                sh 'docker build -t pysnake-deploy ./deploy'
                sh 'docker run --name pysnake-deploy pysnake-deploy'
                sh 'docker logs pysnake-deploy > ./log/pysnake_test_log.txt'
            }
        }
        
    }
}
