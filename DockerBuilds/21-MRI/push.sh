#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ./ComposeLORISMRI21.0.5.yml push loris
docker-compose -f ./ComposeLORISMRI21.0.5.yml push lorisdb
docker-compose -f ./ComposeLORISMRI21.0.5.yml push lorisdbsetup
