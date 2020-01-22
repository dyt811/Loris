#!/usr/bin/env bash
# bach script to automatically remove the image/container to
# Remove all pre-existing volumes.
docker volume rm $(docker volume ls)

docker-compose -f ./ComposeLORIS22.0.0.yml build --pull
docker-compose -f ./ComposeLORIS22.0.0.yml up

