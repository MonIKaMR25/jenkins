pipeline {
  agent any
  
  stages {
    stage('Verificar Docker') {
      steps {
        sh 'docker info'
      }
    } 
    stage('Docker build') {
      steps {
        sh 'docker build -t jenkins-laravel .'
      }
    }
    stage('Run test') {
      steps {
        sh 'docker run jenkins-laravel ./vendor/bin/phpunit tests'
      }
    }
  }
}