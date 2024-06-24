#!/bin/sh -e 

name=traefik/whoami
version=1.8.7

docker pull $name:$version --platform linux/amd64
docker tag $name:$version harbor.zjuqsc.com/k8s/$name:$version
docker push harbor.zjuqsc.com/k8s/$name:$version

echo "done"
