pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Majka1012/snakegame-gui.git'
            }
        }
         stage('Build') {
            steps {
                sh 'docker build -t build_docker .'
            }
        }
    }
    post{
        success {
            echo 'Udało sie!'
        }
        failure{
            echo 'Nie udało się :/'
        }
    }
    
    
    
}

