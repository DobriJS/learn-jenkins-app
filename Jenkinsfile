pipeline {
    agent any
    stages {
      stage('Build') {
  agent {
    docker {
      image 'node:18-alpine'
      reuseNode true
    }
  }

  environment {
    HOME = "${WORKSPACE}"
    NPM_CONFIG_CACHE = "${WORKSPACE}/.npm-cache"
  }

  steps {
    sh '''
      echo "=== Identity ==="
      id
      echo "HOME=$HOME"

      echo "=== npm cache ==="
      npm config get cache

      echo "=== Clean ==="
      rm -rf node_modules .npm-cache

      echo "=== Install ==="
      npm ci --prefer-offline --no-audit --no-fund

      echo "=== Build ==="
      npm run build
    '''
  }
}
 
  

    }

}
