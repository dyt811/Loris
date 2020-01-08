#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ComposeLORIS21.yml down
docker image prune -f
docker container prune -f
docker rm chrome_1
docker rm hub_1
docker rm LORIS_1
docker rm MySQL_1
docker rm DC_LORIS21Configurator_v0.4
docker rmi 21_selenium-driver:latest
docker ps -a
docker image ls
