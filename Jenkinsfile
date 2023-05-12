pipeline {
  agent any

  tools {
    maven 'M2_HOME'
    }
  
  stages {
    stage('CheckOut') {
      steps {
        echo 'Checkout the source code from GitHub'
        git 'https://github.com/kranthi619/star-agile-banking-finance-project-babu.git'
            }
    }
    
    stage('Package the Application') {
      steps {
        echo " Packaing the Application"
        sh 'mvn clean package'
            }
    }
    
    stage('Publish Reports using HTML') {
      steps {
      publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/insurence-project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true]) 
         }
       }

     stage('Docker Image Creation') {
       steps {
         sh 'docker build -t kranthi619/insure-me:latest .'
             }
       } 
      stage('Docker Login') {
       steps {
         withCredentials([usernamePassword(credentialsId: 'Docker-Hub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {         
         sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
   }  
             }
         }

     stage('Push Image to DockerHub') {
       steps {
         sh 'docker push kranthi619/insurence-me:latest'
            }
        }
     stage(Create infrastructure with terraform) {
       steps {
          sh 'sudo chmod 600 pu-up.ppk'
          sh 'terraform init'
          sh 'terraform validate'
          sh 'terraform apply --auto-approve'
          }
       }
    }
}
