pipeline {
  agent { label 'agente1' }

  stages {
    stage('Vertificar Docker') {
      steps {
        sh 'docker info'
      }
    }

    stage('Sonarqube') {
      steps {
        script {
          docker.image('sonarsource/sonar-scanner-cli').inside('--network ci-network') {
            sh 'sonar-scanner'
          }
        }
      }
    }

    // stage('Docker build') {
    //   steps {
    //     sh 'docker build -t jenkins-laravel .'
    //   }
    // }

    // stage('Run test') {
    //   steps {
    //     sh 'docker run --rm jenkins-laravel ./vendor/bin/phpunit tests'
    //   }
    // }

    stage('Deploy') {
      steps {
        script {
          try {
            sshagent(credentials: ['71a7ee52-1c6a-476a-860f-6070ab4eb875']) {
              // Test SSH connectivity first
              sh 'ssh -o ConnectTimeout=10 -o StrictHostKeyChecking=no ubuntu@165.22.3.56 "echo Connection successful"'
              // If connection works, run deployment
              sh './deploy.sh'
            }
          } catch (Exception e) {
            echo "SSH connection failed: ${e.getMessage()}"
            echo "Please verify server is online and accessible"
            currentBuild.result = 'UNSTABLE'
          }
        }
      }
    }
  }

  // post {
  //   success {
  //     slackSend(channel: '#tutorial', message: "Todo bien")
  //   }

  //   failure {
  //     slackSend(channel: '#tutorial', message: "Algo anda mal")
  //   }
  // }
}