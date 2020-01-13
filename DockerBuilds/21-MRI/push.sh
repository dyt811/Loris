#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ./ComposeLORISMRI21.0.5.yml push lorismri
docker-compose -f ./ComposeLORISMRI21.0.5.yml push lorismridb
docker-compose -f ./ComposeLORISMRI21.0.5.yml push lorismridbsetup
