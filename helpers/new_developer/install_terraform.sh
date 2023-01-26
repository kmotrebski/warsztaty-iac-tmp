#!/bin/bash
set -e

source helpers/basic.sh

function install_terraform_on_linux_for_prod_deployment() {

    INSTALLED_FILE=infra/deployments/prod/terraform
    INSTALLED_DIR=infra/deployments/prod
    mkdir -p ${INSTALLED_DIR}

    if [ -f "$INSTALLED_FILE" ]; then
      printf "${GREEN}Terraform in prod deployment directory is already installed.${NC}\n"
      return;
    fi

    printf "${YELLOW}Terraform does not exist at ${INSTALLED_FILE}. Going to install it.${NC}/n"

    #download zipped archive
    ZIPPED_FILE=/tmp/terraform_1.3.3_linux_amd64.zip
    rm -rf ${ZIPPED_FILE}

    HASHICORP_URL=https://releases.hashicorp.com/terraform/1.3.3/terraform_1.3.3_linux_amd64.zip
    wget ${HASHICORP_URL} --output-document=${ZIPPED_FILE}

    #unzip file and remove archive
    unzip -o ${ZIPPED_FILE} -d ${INSTALLED_DIR}
    rm -rf ${ZIPPED_FILE}

    #apply execution permission
    chmod +x ${INSTALLED_FILE}

    #check if installed properly
    TERRAFORM_VERSION=$(./${INSTALLED_FILE} version)
    if [[ "${TERRAFORM_VERSION}" != *"Terraform v1.3.3"* ]]; then
        printf "${RED}Failed to install Terraform. Got ${TERRAFORM_VERSION}${NC}\n"
        exit 2;
    fi

    ./${INSTALLED_FILE} --version
    printf "${GREEN}Terraform installed successfully.${NC}\n"
}

install_terraform_on_linux_for_prod_deployment

./infra/deployments/prod/terraform -chdir=infra/deployments/prod/ init
printf "${YELLOW}Asserting AWS credentials are set up...${NC}\n"
./infra/deployments/prod/terraform -chdir=infra/deployments/prod/ plan
