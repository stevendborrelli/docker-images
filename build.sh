


sudo docker run -v $PWD/library/$1:/library \
                -v /var/run/docker.sock:/var/run/docker.sock \
                bashbrew --library /library/ build $1
