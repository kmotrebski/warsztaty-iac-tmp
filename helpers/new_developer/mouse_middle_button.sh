#!/usr/bin/env bash
set -e

source helpers/basic.sh

function disable_mouse_middle_button() {

  KMO_DEC_FILE=`cat tmp/new_developer/mouse.txt`

  if [ "${KMO_DEC_FILE}" != "y" ] ; then
     printf "${YELLOW}Skipping disabling mouse middle button.${NC}\n"
     return
  fi

  #disable annoying middle-touch-pad button paste
  #see https://linuxconfig.org/how-to-disable-middle-mouse-button-click-paste-on-ubuntu-20-04-focal-fossa-linux
  sudo apt install gnome-tweaks -y
  gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
}

disable_mouse_middle_button
