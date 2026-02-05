pipeline {
    agent any
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
            rm -rf node_modules .npm-cache
            npm ci
            npm run build
            '''
        }
}
   
}
