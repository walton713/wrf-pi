#!/usr/bin/env bash

install_netcdf() {
  print_block_message "Installing NetCDF"
  netcdf_setup
  netcdf_download
  netcdf_install
  netcdf_cleanup
}

netcdf_setup() {
  print_update_message "Creating directories..."
  mkdir -p ${NETCDF_C_DIR} ${NETCDF_C_BUILD} ${NETCDF_F_DIR} ${NETCDF_F_BUILD} ${NETCDF_INSTALL}
  [[ $? -ne 0 ]] && print_error_message "Error while creating directories" && exit 1
}

netcdf_download() {
  print_update_message "Downloading netcdf..."
  cd ${NETCDF_C_DIR}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to netcdf-c working directory" && exit 1
  wget https://downloads.unidata.ucar.edu/netcdf-c/${NETCDF_C_VERSION}/netcdf-c-${NETCDF_C_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while downloading netcdf-c package" && exit 1
  tar xfz netcdf-c-${NETCDF_C_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while unpacking netcdf-c package" && exit 1
  cd ${NETCDF_F_DIR}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to netcdf-fortran working directory" && exit 1
  wget https://downloads.unidata.ucar.edu/netcdf-fortran/${NETCDF_F_VERSION}/netcdf-fortran-${NETCDF_F_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while downloading netcdf-fortran package" && exit 1
  tar xfz netcdf-fortran-${NETCDF_F_VERSION}.tar.gz
  [[ $? -ne 0 ]] && print_error_message "Error while unpacking netcdf-fortran package" && exit 1
}

netcdf_install() {
  print_update_message "Installing netcdf..."
  cd ${NETCDF_C_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to netcdf-c build directory" && exit 1
  CPPFLAGS="-I${ZLIB_INSTALL}/include -I${HDF5_INSTALL}/include" LDFLAGS="-L${ZLIB_INSTALL}/lib -L${HDF5_INSTALL}/lib" ${NETCDF_C_DIR}/netcdf-c-${NETCDF_C_VERSION}/configure --prefix=${NETCDF_INSTALL}
  [[ $? -ne 0 ]] && print_error_message "Error while configuring netcdf-c install" && exit 1
  make check
  [[ $? -ne 0 ]] && print_error_message "Error while running 'make check' on netcdf-c install" && exit 1
  make install
  [[ $? -ne 0 ]] && print_error_message "Error while installing netcdf-c" && exit 1
  cd ${NETCDF_F_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error while moving to netcdf-fortran build directory" && exit 1
  CPPFLAGS="-I${ZLIB_INSTALL}/include -I${HDF5_INSTALL}/include -I${NETCDF_INSTALL}/include" LDFLAGS="-L${ZLIB_INSTALL}/lib -L${HDF5_INSTALL}/lib -L${NETCDF_INSTALL}/lib" ${NETCDF_F_DIR}/netcdf-fortran-${NETCDF_F_VERSION}/configure --prefix=${NETCDF_INSTALL}
  [[ $? -ne 0 ]] && print_error_message "Error while configuring netcdf-fortran install" && exit 1
  make check
  [[ $? -ne 0 ]] && print_error_message "Error while running 'make check' on netcdf-fortran install" && exit 1
  make install
  [[ $? -ne 0 ]] && print_error_message "Error while installing netcdf-fortran" && exit 1
}

netcdf_cleanup() {
  print_update_message "Removing netcdf build..."
  rm -rf ${NETCDF_C_DIR} ${NETCDF_C_BUILD} ${NETCDF_F_DIR} ${NETCDF_F_BUILD}
  [[ $? -ne 0 ]] && print_error_message "Error removing netcdf temp directories" && exit 1
}
