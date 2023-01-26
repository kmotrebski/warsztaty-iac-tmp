#!/usr/bin/env bash
set -e

source helpers/basic.sh

function install_docker_and_make_it_run_without_sudo() {

  rm -rf get-docker.sh

  if docker --version 2&> /dev/null; then
    printf "${GREEN}Docker is installed!${NC}\n"
    docker --version
    return
  fi

  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm -rf get-docker.sh

  if docker --version 2&> /dev/null; then
    printf "${GREEN}Docker is installed!${NC}\n"
    docker --version
    return
  fi

  printf "${RED}Failed to install Docker.\n${NC}"
  exit 1
}

function make_docker_to_be_run_without_sudo() {

  if docker ps -a >> /dev/null 2> /dev/null ; then
    printf "${GREEN}Docker installed. Docker without sudo set up too.${NC}\n"
    return
  fi

  #made docker to run without sudo
  sudo groupadd --force docker
  sudo usermod -aG docker $USER
  printf "${YELLOW}You need to reboot computer so that settings are reloaded and Docker works without sudo. Reboot and run this script again.${NC}\n"
  newgrp docker

}

function assert_docker_can_be_run_without_sudo() {
  if ! docker ps -a >> /dev/null 2> /dev/null ; then
    printf "${RED}Docker without sudo is not set up. Try to reboot the system.${NC}\n"
    exit 1;
    return
  fi

  return
}

install_docker_and_make_it_run_without_sudo
make_docker_to_be_run_without_sudo
assert_docker_can_be_run_without_sudo
