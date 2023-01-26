#!/usr/bin/env bash
set -e

function make_sure_curl_is_installed() {

  if curl --version 2&> /dev/null; then
    printf "${GREEN}cURL is installed!${NC}\n"
    curl --version
    return
  fi

  printf "${YELLOW}Going to install cURL...${NC}\n"

  sudo apt-get update && sudo apt-get install curl -y
}

make_sure_curl_is_installed
