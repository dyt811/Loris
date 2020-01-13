#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ComposeLORIS21.0.5.yml down
docker image prune -f
docker container prune -f

# nuke containers
docker rm 21_chrome_1
docker rm 21_hub_1
docker rm 21_loris_1
docker rm 21_lorisdb_1
docker rm 21_lorisdbsetup_1

# nuke container images
docker rmi 21_lorisdbsetup:latest
#docker rmi dyt811:DC_LORIS21_v0.4

# sanity check on results
docker ps -a
docker image ls
