#!/usr/bin/env bash
set -e

mkdir -p infra/ssh_keys
touch infra/ssh_keys/your_key.pub

source helpers/basic.sh
source helpers/new_developer/decisions.sh
source helpers/new_developer/mouse_middle_button.sh
source helpers/new_developer/configure_git.sh
source helpers/new_developer/install_curl.sh
source helpers/new_developer/docker.sh
source helpers/new_developer/install_terraform.sh
source helpers/new_developer/chrome.sh
source helpers/new_developer/phpstorm.sh
printf "${GREEN}New developer finished!${NC}\n"
