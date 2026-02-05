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
            steps {
                sh '''
                echo "=== Fix npm cache permissions ==="
                chown -R $(id -u):$(id -g) /.npm || true

                echo "=== Clean workspace ==="
                rm -rf node_modules

                echo "=== Versions ==="
                node --version
                npm --version

                echo "=== Install & build ==="
                npm ci
                npm run build
                '''
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                test -f build/index.html
                npm test
                '''
            }
        }
    }
}
