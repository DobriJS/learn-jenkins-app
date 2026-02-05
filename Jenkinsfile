pipeline {
    agent any

    stages {
       /*  stage('Build') {
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
        } */

        stage('Test') {
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
                    echo "=== Verify build output ==="
                    ls -la build || true
                    test -f build/index.html

                    echo "=== Run tests ==="
                    npm test
                '''
            }
        }

        stage('E2E') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                    reuseNode true
                    args '-u root'
                }
            }
            environment {
                HOME = "${WORKSPACE}"
                NPM_CONFIG_CACHE = "${WORKSPACE}/.npm-cache"
                }
            steps {
                sh '''
            
            export npm_config_cache="$WORKSPACE/.npm-cache"            
            npm install --quiet serve            
            ./node_modules/.bin/serve -s build &
            sleep 10
            npx playwright test --reporter=html
                '''
            }
        }
    }
     post {
        always {
            junit 'jest-results/junit.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
        }
    }
}