def Imagename = "saigopi123456/tomcat"
def Containername = "tomcatcontainer"
node {
    stage('Git Checkout') {
        git branch: 'feature2', url: 'https://github.com/gopi732/Tomcat-CICD.git'
    }
    stage('Stop & Delete Previous Containers & remove unused images') {
        sh 'docker stop $(docker ps -a -q) || true && docker rm $(docker ps -a -q) || true && docker rmi -f $(docker images -a -q) || true'
    }
    withEnv(['http_proxy=http://127.0.0.1:3128/', 'https_proxy=http://127.0.0.1:3128/', 'ftp_proxy=http://127.0.0.1:3128/', 'socks_proxy=socks://127.0.0.1:3128/']) {
        stage('Build image') {
            sh "docker build -t ${Imagename}:${env.BUILD_ID} ."
        }
    }
    stage('create container') {
        sh "docker run -d --name ${Containername} -p 9028:8080 --restart unless-stopped ${Imagename}:${env.BUILD_ID} && docker ps"
    }
    stage('Container Testing ') {
        sh 'wget localhost:9028/gameoflife/'
    }
    stage('DockerHub Login and push') {
        withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhub')]) {
            sh "docker push ${Imagename}:${env.BUILD_ID}"
        }    
    }
}
