def image = "saigopi123456/tomcat"
def containerName = "tomcatcontainer"
node ("slave") {
    stage('Git Checkout') {
         git branch: 'feature', url: 'https://github.com/gopi732/Tomcat-CICD.git'
    }
    stage('Stop & Delete Previous Containers & remove unused images') {
        sh 'docker stop $(docker ps -a -q) || true && docker rm $(docker ps -a -q) || true && docker rmi -f $(docker images  -a -q) || true'
    }
    withEnv(['http_proxy=http://127.0.0.1:3128/', 'https_proxy=http://127.0.0.1:3128/', 'ftp_proxy=http://127.0.0.1:3128/', 'socks_proxy=socks://127.0.0.1:3128/']) {
        stage('Build Image') {
            docker.build("${image}:${env.BUILD_ID}")
        }
    }
    stage('creating Container using image') {
        docker.image("${image}:${env.BUILD_ID}").run("--name ${containerName} --publish 9028:8080")
    }
    stage('Container Testing') {
        sh 'wget localhost:9028/gameoflife/'
    }
    stage('DockerHub Login and push') {
        docker.withRegistry('', 'dockerhub') {
            docker.image("${image}:${env.BUILD_ID}").push()
        }
    }
}
