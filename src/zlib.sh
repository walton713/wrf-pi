#!/usr/bin/env bash

install_zlib() {
  print_block_message "Installing zlib"
  zlib_setup
  zlib_download
  zlib_install
  zlib_cleanup
}

zlib_setup() {
  print_update_message "Creating directories..."
  mkdir -p ${ZLIB_DIR} ${ZLIB_BUILD} ${ZLIB_INSTALL}
  [[ $? -ne 0 ]] && print_error_message "Error while creating directories" && exit 1
}

zlib_download() {
  print_update_message "Downloading zlib..."
  cd ${ZLIB_DIR}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to zlib working directory" && exit 1
  wget https://github.com/madler/zlib/releases/download/v${ZLIB_VERSION}/zlib-${ZLIB_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while downloading zlib package" && exit 1
  tar xfz zlib-${ZLIB_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while unpacking zlib package" && exit 1
}

zlib_install() {
  print_update_message "Installing zlib..."
  cd ${ZLIB_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to zlib build directory" && exit 1
  ${ZLIB_DIR}/zlib-${ZLIB_VERSION}/configure --prefix=${ZLIB_INSTALL}
  [[ $? -ne 0 ]] && print_error_message "Error while configuring zlib install" && exit 1
  make
  [[ $? -ne 0 ]] && print_error_message "Error while running 'make' on zlib install" && exit 1
  make install
  [[ $? -ne 0 ]] && print_error_message "Error while installing zlib" && exit 1
}

zlib_cleanup() {
  print_update_message "Removing zlib build..."
  rm -rf ${ZLIB_DIR} ${ZLIB_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error removing zlib temp directories" && exit 1
}
