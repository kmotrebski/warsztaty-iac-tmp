#!/usr/bin/env bash
set -e

#colors to be used in output cmds
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

#assert project root directory
if [ ! -d ".git" ] ; then
  printf "${RED}You are not in the project root directory! Fire the cmd from there.\n${NC}"
  exit 1
fi
