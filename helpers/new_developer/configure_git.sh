#!/usr/bin/env bash
set -e

source helpers/basic.sh

function configure_git_user_name() {
  FOUND=$(git config --local --get user.name | wc -m)
  if [ "${FOUND}" -ge 1 ]; then
    USERNAME=$(git config --local --get user.name)
    printf "${GREEN}Found git user name: \"${USERNAME}\".\n${NC}"
    return
  fi

  printf "${YELLOW}Setting up git local config for your name (commit author). \nType your name and press [enter]:\n${NC}"
  read USERNAME
  git config --local user.name "${USERNAME}"

  printf "${GREEN}User name set up. It is now the following:${NC}\n"
  git config --local --get user.name
  printf "\n"
}

configure_git_user_name

function configure_git_user_email() {

  FOUND=$(git config --local --get user.email | wc -m)
  if [ "${FOUND}" -ge 1 ]; then
    USEREMAIL=$(git config --local --get user.email)
    printf "${GREEN}Found git user email: \"${USEREMAIL}\".\n${NC}"
    return
  fi

  printf "${YELLOW}Setting up git local config for your email (commit author).\n"
  printf "Visit github settings at https://github.com/settings/emails to see your private stub,\n"
  printf "then type/copy&paste it here and press [enter]:\n${NC}"
  read USEREMAIL
  git config --local user.email "${USEREMAIL}"

  printf "${GREEN}User email set up. It is now the following:${NC}\n"
  git config --local --get user.email
  printf "\n"
}

configure_git_user_email
