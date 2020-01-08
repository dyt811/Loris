#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker image prune -f
docker container prune -f
docker rm DC_LORIS22Configurator_v0.4
docker rmi dockerbuilds_chrome:latest
