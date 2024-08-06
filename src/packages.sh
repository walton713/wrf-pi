#!/usr/bin/env bash

update_and_install_packages() {
  print_block_message "Updating System and Installing Required Packages"
  update
  upgrade
  install
}

update() {
  print_update_message "Updating system..."
  sudo apt update
  [[ $? -ne 0 ]] && print_error_message "Error while updating system" && exit 1
}

upgrade() {
  print_update_message "Upgrading packages..."
  sudo apt upgrade -y
  [[ $? -ne 0 ]] && print_error_message "Error while upgrading packages" && exit 1
}

install() {
  print_update_message "Installing required packages..."
  sudo apt-get install gfortran libcurl4-gnutls-dev libxml2-dev m4 cmake libjpeg-dev mpich -y
  [[ $? -ne 0 ]] && print_error_message "Error while installing packages" && exit 1
}
