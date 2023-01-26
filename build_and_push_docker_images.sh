#!/bin/bash
set -e

source helpers/basic.sh
source development.env

#build images
docker build -t ${WARSZTATY_IMAGE_DEV}  --no-cache -f infra/docker/dev/Dockerfile .
docker build -t ${WARSZTATY_IMAGE_PROD} --no-cache -f infra/docker/prod/Dockerfile .

#log in to AWS ECR
docker run --rm -it \
  -v ${WARSZTATY_AWS_DIR}:/root/.aws amazon/aws-cli:2.8.5 \
  ecr get-login-password --region ${WARSZTATY_REGION} \
  --profile warsztaty_iac | docker login --username AWS --password-stdin ${WARSZTATY_ECR_URL}

#push prod image to ECR
docker push ${WARSZTATY_IMAGE_PROD}

printf "${GREEN}Building and pushing done!${NC}\n"
