pipeline {
  agent any
  environment {
    SONAR_TOKEN = credentials('SONAR_TOKEN')
  }
  stages {
    stage('PHPUnit') {
      steps {
        sh 'vendor/bin/phpunit --log-junit=phpunit-report.xml'
      }
    }
    stage('SonarCloud Analysis') {
      steps {
        sh 'sonar-scanner -Dsonar.login=$SONAR_TOKEN -Dsonar.php.tests.reportPath=phpunit-report.xml'
      }
    }
    stage('Docker Access Test') {
      steps {
        sh 'docker ps'
        sh 'docker info'
      }
    }
    stage('SonarQube Analysis') {
      steps {
        script {
          docker.image('sonarsource/sonar-scanner-cli').inside('--network ci-network') {
            sh 'sonar-scanner'
          }
        }
      }
    }
    stage('Deploy') {
      steps {
        script {
          try {
            sshagent(credentials: ['jenkins-ssh-key']) {
              /* Test SSH connectivity first */
              sh 'ssh -o ConnectTimeout=10 -o StrictHostKeyChecking=no ubuntu@165.22.3.56 "echo Connection successful"'
              /* If connection works, run deployment */
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
}