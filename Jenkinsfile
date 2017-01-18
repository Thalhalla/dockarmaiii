#!groovy

node {


    git credentialsId: 'thalhallajenkins-github', url: 'https://github.com/Thalhalla/dockarmaiii.git'
    currentBuild.result = "SUCCESS"

    env.NODE_ENV = "test"

    try {

       stage('Checkout') {

            checkout scm

      }
       stage('Test') {

            env.NODE_ENV = "test"

            print "Environment will be : ${env.NODE_ENV}"

      }
       stage('Build Docker') {

            echo "./dockerBuild.sh"

      }
       stage('Deploy') {

            echo 'Push to Repo'

      }
       stage('Cleanup') {

            echo 'done'

      }
    }


    catch (err) {

        currentBuild.result = "FAILURE"

        throw err
    }

}
