#!/usr/bin/env bash
set -e

source helpers/basic.sh

mkdir -p tmp/new_developer

function ask_about_mouse_middle_button() {

  KMO_DEC_FILE=tmp/new_developer/mouse.txt

  if [ -f "${KMO_DEC_FILE}" ]; then
    #decision already made, question asked
    return
  fi

  printf "${GREEN}Would you like to disable mouse middle button?${NC}\n"
  printf "Type y for yes\n"
  read KMO_SHOULD_INSTALL

  if [ ${KMO_SHOULD_INSTALL} != "y" ] ; then
     printf "${GREEN}Skipping disabling mouse middle button.${NC}\n"
     touch ${KMO_DEC_FILE}
     return
  fi

  #mark that dev wants soft to be installed
  printf 'y' > ${KMO_DEC_FILE}
}

ask_about_mouse_middle_button
