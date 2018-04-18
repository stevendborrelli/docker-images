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
        final bashbrew = "/usr/local/bin/bashbrew-entrypoint.sh" 
        final command = "build"
        final library = "library"
        final extra_args = "--debug" 
        final namespace = "steve" 

        def images = ["alpine", "bashbrew", "ubuntu"]

        stage('Build') {
            container('bashbrew') {
                echo 'Building docker images...'
                images.each {
                    echo 'building ${it}'
                    sh("${bashbrew} ${extra_args} --library ${library}/${it} build --namespace ${namespace} ${it}")
                }
            }
        }

        stage('Tag') {
            container('bashbrew') {
                echo 'Tagging docker images...'
                //sh("${bashbrew} ${extra_args} --library ${library}/alpine tag --namespace ${namespace} alpine")
            }
        }

        stage('Push') {
            container('bashbrew') {
                echo 'Push image to docker registry ${namespace}'
                sh("${bashbrew} ${extra_args} --library ${library}/alpine push --namespace ${namespace} alpine")
            }
        }
    }
}
