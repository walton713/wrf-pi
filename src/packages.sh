#!/usr/bin/env bash

update_and_install_packages() {
  print_block_message "Updating system and installing required packages"
  update
  upgrade
  install
}

update() {
  print_update_message "Updating system..."
  run_command "sudo apt update"
}

upgrade() {
  print_update_message "Upgrading packages..."
  run_command "sudo apt upgrade -y"
}

install() {
  print_update_message "Installing required packages..."
  run_command "sudo apt-get install gfortran libcurl4-gnutls-dev libxml2-dev m4 cmake libjpeg-dev -y"
}
