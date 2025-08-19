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
        // Monta el workspace y ejecuta PHPUnit en el directorio correcto
        sh 'docker run -v $PWD:/app -w /app jenkins-laravel ./vendor/bin/phpunit tests'
      }
    }
  }

  post {
    success {
      slackSend (channel: '#nuevo-canal', message: "Todo bien")
    }
    
    failure {
      slackSend (channel: '#nuevo-canal', message: "Algo anda mal")
    }
  }
}