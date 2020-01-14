#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker-compose -f ./ComposeLORIS22.0.0.yml build --pull
docker-compose -f ./ComposeLORIS22.0.0.yml up
