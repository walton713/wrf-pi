#!/usr/bin/env bash

install_packages() {
  sudo apt update && sudo apt upgrade
  sudo apt-get install gfortran libcurl4-gnutls-dev libxml2-dev m4 cmake libjpeg-dev -y
}
