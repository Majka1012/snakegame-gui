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
        stage('Build') 
        {
            steps 
            {
                script 
                {
                    try 
                    {
                        docker.build("pysnake", "-f Dockerfile .")
                    } 
                    catch (Exception e) 
                    {
                        currentBuild.result = 'FAILURE'
                        error "Błąd podczas budowania obrazu Docker: ${e.message}"
                    }
                }
            }
        }

        
        stage('Test') {
            steps {
                sh 'docker build -t pysnake-test ./tests'
                sh 'docker run --name pysnake-test pysnake-test'
                sh 'docker logs pysnake-test > ./log/pysnake_deploy_log.txt'
            }
        }
        stage('Test') 
        {
            steps 
            {
                script 
                {
                    try 
                    {
                        docker.build("tester", "-f Dockerfile ./tests")
                    } 
                    catch (Exception e) 
                    {
                        currentBuild.result = 'FAILURE'
                        error "Błąd podczas testowania obrazu Docker: ${e.message}"
                    }
                }
            }
        }

        stage('Deploy and Publish'){
            steps {
               script 
                {
                    try 
                    {
                        sh "docker rm -f pysnake || true"
                        docker.image("pysnake").run("-d --name pysnake -p 8080:8080")

                        // smoke test
                        sh "curl -s -o /dev/null -w '%{http_code}' http://localhost:8080/"

                        sh "docker save pysnake -o pysnake.tar"
                    
                        // Archiwizacja artefaktu
                        archiveArtifacts artifacts: "pysnake.tar", onlyIfSuccessful: true
                        stash includes: "pysnake.tar", name: "pysnake"
                    } 
                    catch (Exception e) 
                    {
                        currentBuild.result = 'FAILURE'
                        error "Błąd podczas deployu: ${e.message}"
                    }
                }
            }
        }
   
    }
 }

