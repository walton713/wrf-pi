#!/usr/bin/env bash

HDF5_DIR=${HOME}/hdf5
HDF5_BUILD=${HOME}/hdf5_build
HDF5_INSTALL=${HOME}/WRF/libraries/hdf5

install_hdf5() {
  print_block_message "Installing HDF5"
  hdf5_setup
  hdf5_download
  hdf5_install
  hdf5_cleanup
}

hdf5_setup() {
  print_update_message "Creating directories..."
  mkdir -p ${HDF5_DIR} ${HDF5_BUILD} ${HDF5_INSTALL}
  [[ $? -ne 0 ]] && print_error_message "Error while creating directories" && exit 1
}

hdf5_download() {
  print_update_message "Downloading HDF5..."
  cd ${HDF5_DIR}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to HDF5 working directory" && exit 1
  wget https://github.com/HDFGroup/hdf5/archive/refs/tags/hdf5_${HDF5_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while downloading HDF5 package" && exit 1
  tar xfz hdf5_${HDF5_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while unpacking HDF5 package" && exit 1
}

hdf5_install() {
  print_update_message "Installing HDF5..."
  cd ${HDF5_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to HDF5 build directory" && exit 1
  ${HDF5_DIR}/hdf5-hdf5_${HDF5_VERSION}/configure --with-zlib=${ZLIB_INSTALL} --prefix=${HDF5_INSTALL} --enable-hl
  [[ $? -ne 0 ]] && print_error_message "Error while configuring HDF5 install" && exit 1
  make check
  [[ $? -ne 0 ]] && print_error_message "Error while running 'make check' on HDF5 install" && exit 1
  make install
  [[ $? -ne 0 ]] && print_error_message "Error while installing HDF5" && exit 1
}

hdf5_cleanup() {
  print_update_message "Removing HDF5 build..."
  rm -rf ${HDF5_DIR} ${HDF5_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error removing HDF5 temp directories" && exit 1
}
