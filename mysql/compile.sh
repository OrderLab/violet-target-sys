#!/bin/bash

if [ -z "$S2EDIR" ]; then
  echo "S2EDIR environment variable is not set. If you have setup the Violet workspace," 
  echo "do a 'source /path/to/violet/workspace/s2e_activate' first."
  exit 1
fi

mkdir -p {build,dist}
cd build

cmake ../5.5.59  -DCMAKE_INSTALL_PREFIX=`pwd`/../dist \
  -DMYSQL_DATADIR=`pwd`/../dist/data -DWITH_DEBUG=1 -DCMAKE_BUILD_TYPE=DEBUG \
  -DCMAKE_C_FLAGS_DEBUG="-g -O0" -DCMAKE_CXX_FLAGS_DEBUG="-g -O0" \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DMYSQL_MAINTAINER_MODE=false

make -j4
