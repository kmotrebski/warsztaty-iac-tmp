#!/usr/bin/env bash
set -e

function install_phpstorm_if_not_installed_yet() {

  IS_INSTALLED=`snap list | grep phpstorm | wc -l`

  if [ ${IS_INSTALLED} == "1" ] ; then
    printf "${GREEN}PHPStrom is installed!${NC}\n"
    return
  fi

  printf "Going to install PHPStorm...\n"
  sudo snap install phpstorm --classic
}

install_phpstorm_if_not_installed_yet
