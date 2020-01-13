#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ComposeLORISMRI21.0.5.yml down
docker image prune -f
docker container prune -f

# nuke containers
docker rm 21_chrome_1
docker rm 21_hub_1
docker rm 21_lorismri_1
docker rm 21_lorismridb_1
docker rm 21_lorismridbsetup_1

# nuke container images
docker rmi 21_lorismridbsetup

# sanity check on results
docker ps -a
docker image ls
