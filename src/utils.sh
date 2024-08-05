#!/usr/bin/env bash

GREEN=$'\e[0;32m'
NC=$'\e[0m'

print_message() {
  echo ""
  echo ""
  echo -e "${GREEN}####################################################################################################${NC}"
  echo -e "${GREEN}#${NC}"
  echo -e "${GREEN}#${NC}"
  echo -e "${GREEN}# $1${NC}"
  echo -e "${GREEN}#${NC}"
  echo -e "${GREEN}#${NC}"
  echo -e "${GREEN}####################################################################################################${NC}"
  echo ""
  echo ""
}
