#!/usr/bin/env bash
set -e

source helpers/basic.sh
source development.env

./infra/deployments/prod/terraform -chdir=infra/deployments/prod/ apply

WARSZTATY_INSTANCE_IP=$(./infra/deployments/prod/terraform -chdir=infra/deployments/prod/ output -raw instance_ip)

docker run --rm --name warsztaty_tests \
  --volume $PWD:/var/www/html \
  --memory=2048m \
  -e WARSZTATY_INSTANCE_IP="${WARSZTATY_INSTANCE_IP}" \
  ${WARSZTATY_IMAGE_DEV} runuser -g www-data -u www-data -- php vendor/phpunit/phpunit/phpunit tests/*
