#!/bin/bash

docker network create -d bridge strapi_network

docker run \
--name=strapi_mongo \
--hostname=466ff59bd786 \
--env=MONGO_INITDB_ROOT_PASSWORD=strapi \
--env=MONGO_INITDB_ROOT_USERNAME=strapi \
--env=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
--env=GOSU_VERSION=1.11 \
--env=JSYAML_VERSION=3.13.0 \
--env=GPG_KEYS=E162F504A20CDF15827F718D4B7C549A058F8B6B \
--env=MONGO_PACKAGE=mongodb-org \
--env=MONGO_REPO=repo.mongodb.org \
--env=MONGO_MAJOR=4.2 \
--env=MONGO_VERSION=4.2.3 \
--volume=/data/strapi_mongo/db:/data/db:Z \
--volume=/data/configdb \
--volume=/data/strapi_mongo/db \
--network=strapi_network \
-p 27017:27017 \
--label com.docker.compose.service="mongo" \
--label com.docker.compose.version="1.24.1" \
--label com.docker.compose.oneoff="False" \
--label com.docker.compose.project="root" \
--label com.docker.compose.config-hash="90bb1c8b079c908dde62cfa9a8bb2d6f2e73b598101d982e7971a8e7df3b7a87" \
--label com.docker.compose.container-number="1" \
--detach=true mongo mongod

docker run \
--name=strapi \
--hostname=09cf6a7d3795 \
--env=DATABASE_PASSWORD=strapi \
--env=DATABASE_PORT=27017 \
--env=DATABASE_USERNAME=strapi \
--env=DATABASE_CLIENT=mongo \
--env=DATABASE_NAME=strapi \
--env=DATABASE_HOST=mongo \
--env=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
--env=NODE_VERSION=12.13.0 \
--env=YARN_VERSION=1.19.1 \
--volume=/data/strapi:/srv/app:Z \
--volume=/srv/app \
--network=strapi_network \
-p 1337:1337 \
--label com.docker.compose.container-number="1" \
--label com.docker.compose.version="1.24.1" \
--label com.docker.compose.oneoff="False" \
--label com.docker.compose.project="root" \
--label com.docker.compose.config-hash="abb2fd07f2c1d5e7903f4daa636d30738382fd1c06e7c0456dbc3486f70e0670" \
--label com.docker.compose.service="strapi" \
--detach=true strapi/strapi strapi develop

