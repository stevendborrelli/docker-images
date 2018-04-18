final def podLabel = "pod-${env.BUILD_TAG}".replace("%2F", "-")

podTemplate(label: podLabel,
    containers: [
        containerTemplate(
            name: 'docker',
            image: 'docker:18.03.0',
            ttyEnabled: true,
            command: 'cat'
        ),
        containerTemplate(
            name: 'bashbrew',
            image: 'steve/bashbrew:latest',
            ttyEnabled: true,
            command: 'cat'
        )
    ],
    volumes: [
        hostPathVolume(
            hostPath: '/var/run/docker.sock',
            mountPath: '/var/run/docker.sock'
        ),
        hostPathVolume(
            hostPath: '/usr/bin/docker',
            mountPath: '/usr/bin/docker',
        )
    ]
) {
    node(podLabel) {
        final scmVars = checkout scm
        final version = "versions/custom-3.7/x86_64/options"
        final imageTag = "gcr.io/${env.GOOGLE_PROJECT}"

        stage('Build') {
            container('bashbrew') {
                echo 'build'
                sh("./jenkins.sh build alpine")
            }
        }

        stage('Verify') {
            container('bashbrew') {
                echo 'Building docker image...'
                //sh("./build ${version}")
            }
        }

        stage('Push') {
            container('bashbrew') {
                echo 'Push image to GCR'
                //sh("gcloud docker -- push ${imageTag}")
            }
        }
    }
}
