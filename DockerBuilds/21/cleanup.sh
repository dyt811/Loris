#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ComposeLORIS21.yml down
docker image prune -f
docker container prune -f

# nuke containers
docker rm chrome_1
docker rm hub_1
docker rm LORIS_1
docker rm MySQL_1
docker rm DC_LORIS21Configurator_v0.4

# nuke container images
docker rmi 21_selenium-driver:latest
#docker rmi dyt811:DC_LORIS21_v0.4

# sanity check on results
docker ps -a
docker image ls
