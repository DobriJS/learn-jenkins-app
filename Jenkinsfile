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
    npm_config_loglevel = "warn"
    npm_config_fund = "false"
    npm_config_audit = "false"
  }

  steps {
    sh '''
      echo "=== Clean install dirs ==="
      rm -rf node_modules

      echo "=== npm config ==="
      npm config get cache

      echo "=== Install deps (fast + safe) ==="
      npm ci --prefer-offline

      echo "=== Build ==="
      npm run build
    '''
  }
}

    }
}
