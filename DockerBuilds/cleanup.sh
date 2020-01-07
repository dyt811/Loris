#!/usr/bin/env bash
# bach script to automatically remove the image/container to
docker image prune
docker container prune
docker rm DC_LORIS22Configurator_v0.4
docker rmi dockerbuilds_chrome:latest
