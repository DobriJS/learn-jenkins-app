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
    NPM_CONFIG_CACHE = "${WORKSPACE}/.npm-cache"
  }

  steps {
    sh '''
      echo "=== Sanity check ==="
      whoami
      id

      echo "=== Using npm cache ==="
      npm config get cache

      echo "=== Clean dirs ==="
      rm -rf node_modules .npm-cache

      echo "=== Versions ==="
      node --version
      npm --version

      echo "=== Install ==="
      npm ci --prefer-offline --no-audit --no-fund

      echo "=== Build ==="
      npm run build
    '''
  }
}

    }

}
