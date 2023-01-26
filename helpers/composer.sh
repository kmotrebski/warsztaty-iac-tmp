#!/usr/bin/env bash
set -e

source helpers/basic.sh
source development.env

mkdir -p vendor
docker run --rm -it --name warsztaty_pull \
  --volume $PWD:/var/www/html \
  ${WARSZTATY_IMAGE_DEV} runuser -g www-data -u www-data -- composer $*
