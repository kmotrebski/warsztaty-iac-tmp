e#!/bin/bash
set -e

source helpers/basic.sh
source development.env

docker run -p 80:80 --rm \
  --name warsztaty-php-dev \
  --env WARSZTATY_INSTANCE_ID=uruchomienie_dev_z_lokala \
  -v "${PWD}"/src:/var/www/html \
  ${WARSZTATY_IMAGE_DEV}
