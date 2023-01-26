#!/bin/bash
set -e

docker run -p 80:80 --rm \
  --name warsztaty-php-prod \
  --env WARSZTATY_INSTANCE_ID=uruchomienie_prod_z_lokala \
  ${WARSZTATY_IMAGE_PROD}
