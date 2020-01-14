#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ComposeLORIS22.0.0.yml down
docker image prune -f
docker container prune -f

# nuke containers
docker rm 22_chrome_1
docker rm 22_hub_1
docker rm 22_loris_1
docker rm 22_lorisdb_1
docker rm 22_lorisdbsetup_1

# nuke container images
docker rmi neonatalbrainplatform/lorisdbsetup:22.0.0

#docker rmi dyt811:DC_LORIS21_v0.4

# sanity check on results
docker ps -a
docker image ls
