#!/bin/bash

version=${1}

imagename="ces-docker.dkrreg.mmih.biz/cms-strapi:${version}"

echo "Building Image: ${imagename}"

docker build --no-cache -t ${imagename} .

#Push the image to the IBS registry
export DOCKER_USERNAME=ces_ci
export DOCKER_PASSWORD='bZBFnsux4hcYe49Wrd'

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD ces-docker.dkrreg.mmih.biz
docker push ${imagename}
docker rmi ${imagename}

