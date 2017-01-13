#!groovy

node('node') {


    currentBuild.result = "SUCCESS"

    try {

       stage 'Checkout'

            git credentialsId: 'thalhallajenkins-github', url: 'https://github.com/Thalhalla/dockarmaiii.git'

       stage 'Test'

            env.NODE_ENV = "test"

            print "Environment will be : ${env.NODE_ENV}"

            sh 'npm prune'
            sh 'npm install'
            sh 'export DISPLAY=:99.0'
            sh 'sh -e /etc/init.d/xvfb start'
            sh 'npm install -g bower grunt-cli'
            sh 'gem install sass'
            sh 'bower install'
            sh 'grunt test'

       stage 'Build Docker'

            sh './dockerBuild.sh'

       stage 'Deploy'

            echo 'Push to Repo'
            sh './dockerPushToRepo.sh'

            echo 'ssh to web server and tell it to pull new image'
            sh 'echo ssh deploy@xxxxx.xxxxx.com running/xxxxxxx/dockerRun.sh'

       stage 'Cleanup'

            echo 'prune and cleanup'
            sh 'npm prune'
            sh 'rm node_modules -rf'

            mail body: 'project build successful',
                        from: 'thaladmin@thalhalla.com',
                        replyTo: 'no-reply@thalhalla.com',
                        subject: 'project build successful',
                        to: 'thaladmin@thalhalla.com'

        }


    catch (err) {

        currentBuild.result = "FAILURE"

            mail body: "project build error is here: ${env.BUILD_URL}" ,
            from: 'thaladmin@thalhalla.com',
            replyTo: 'thaladmin@thalhalla.com',
            subject: 'project build failed',
            to: 'thaladmin@thalhalla.com'

        throw err
    }

}
