#!/usr/bin/env bash
set -e

function make_sure_chrome_is_installed() {

  if google-chrome --version 2&> /dev/null; then
    printf "${GREEN}Google Chrome is installed!${NC}\n"
    google-chrome --version
    return
  fi

  printf "${YELLOW}Going to install Google Chrome...${NC}\n"

  mkdir -p /tmp/chrome_installation
  curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output /tmp/chrome_installation/file.deb
  sudo dpkg -i /tmp/chrome_installation/file.deb
  rm -rf /tmp/chrome_installation
}

make_sure_chrome_is_installed
