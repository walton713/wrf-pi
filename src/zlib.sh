#!/usr/bin/env bash

ZLIB_DIR=${HOME}/zlib
ZLIB_BUILD=${HOME}/zlib_build
ZLIB_INSTALL=${HOME}/WRF/libraries/zlib

install_zlib() {
  print_block_message "Installing zlib"
  zlib_setup
  zlib_download
  zlib_install
  zlib_cleanup
}

zlib_setup() {
  print_update_message "Creating directories..."
  run_command "mkdir -p ${ZLIB_DIR} ${ZLIB_BUILD} ${ZLIB_INSTALL}"
}

zlib_download() {
  print_update_message "Downloading zlib..."
  run_command "cd ${ZLIB_DIR} && wget https://github.com/madler/zlib/releases/download/v${ZLIB_VERSION}/zlib-${ZLIB_VERSION}.tar.gz && tar xfz zlib-${ZLIB_VERSION}.tar.gz"
}

zlib_install() {
  print_update_message "Installing zlib..."
  run_command "cd ${ZLIB_BUILD} && ../zlib-${ZLIB_VERSION}/configure --prefix=${ZLIB_INSTALL} && make && make install"
  run_command "export PATH=${PATH}:${ZLIB_INSTALL}"
}

zlib_cleanup() {
  print_update_message "Removing zlib build..."
  run_command "rm -rf ${ZLIB_DIR} ${ZLIB_BUILD}"
}
