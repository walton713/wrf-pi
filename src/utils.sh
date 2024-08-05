#!/usr/bin/env bash

RED=$'\e[0;31m'
GREEN=$'\e[0;32m'
NC=$'\e[0m'

print_block_message() {
  echo ""
  echo ""
  echo -e "${GREEN}####################################################################################################${NC}"
  echo -e "${GREEN}####################################################################################################${NC}"
  echo -e "${GREEN}#${NC}"
  echo -e "${GREEN}#${NC}"
  echo -e "${GREEN}# $1${NC}"
  echo -e "${GREEN}#${NC}"
  echo -e "${GREEN}#${NC}"
  echo -e "${GREEN}####################################################################################################${NC}"
  echo -e "${GREEN}####################################################################################################${NC}"
  echo ""
  echo ""
}

print_update_message() {
  echo -e "${GREEN}$1${NC}"
}

print_error_message() {
  echo -e "${RED}$1${NC}"
}

run_command() {
  if [[ $VERBOSE = true ]]
  then
    { ERR=$(${1} 2>&1 >&3 3>&-); } 3>&1
  else
    ERR=$(${1} 1>/dev/null 2>&1)
  fi

  if [[ $? -ne 0 ]]
  then
    print_error_message "Error while running command '${1}': ${ERR}"
  fi
}
