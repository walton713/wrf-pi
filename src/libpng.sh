#!/usr/bin/env bash

install_libpng() {
  print_block_message "Installing libpng"
  libpng_setup
  libpng_download
  libpng_install
  libpng_cleanup
}

libpng_setup() {
  print_update_message "Creating directories..."
  mkdir -p ${LIBPNG_DIR} ${LIBPNG_BUILD} ${LIBPNG_INSTALL}
  [[ $? -ne 0 ]] && print_error_message "Error while creating directories" && exit 1
}

libpng_download() {
  print_update_message "Downloading libpng..."
  cd ${LIBPNG_DIR}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to libpng working directory" && exit 1
  wget http://prdownloads.sourceforge.net/libpng/libpng-${LIBPNG_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while downloading libpng package" && exit 1
  tar xfz libpng-${LIBPNG_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while unpacking libpng package" && exit 1
}

libpng_install() {
  print_update_message "Installing libpng..."
  cd ${LIBPNG_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to libpng build directory" && exit 1
  ${LIBPNG_DIR}/libpng-${LIBPNG_VERSION}/configure --prefix=${LIBPNG_INSTALL}
  [[ $? -ne 0 ]] && print_error_message "Error while configuring libpng install" && exit 1
  make check
  [[ $? -ne 0 ]] && print_error_message "Error while running 'make check' on libpng install" && exit 1
  make install
  [[ $? -ne 0 ]] && print_error_message "Error while installing libpng" && exit 1
}

libpng_cleanup() {
  print_update_message "Removing libpng build..."
  rm -rf ${LIBPNG_DIR} ${LIBPNG_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error removing libpng temp directories" && exit 1
}
