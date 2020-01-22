#!/usr/bin/env bash
# bach script to automatically remove the image/container to
# Remove all pre-existing volumes.
docker volume rm $(docker volume ls)

docker-compose -f ./ComposeLORISMRI21.0.5.yml build
docker-compose -f ./ComposeLORISMRI21.0.5.yml up
