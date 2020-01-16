#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ComposeLORISMRI21.0.5.yml down
docker image prune -f
docker container prune -f

# nuke containers
docker rm 21-mri_chrome_1
docker rm 21-mri_hub_1
docker rm 21-mri_lorismri_1
docker rm 21-mri_lorismridb_1
docker rm 21-mri_lorismridbsetup_1

# nuke container images
docker rmi neonatalbrainplatform/lorisdbsetup:21.0.5-MRI

# sanity check on results
docker ps -a
docker image ls
